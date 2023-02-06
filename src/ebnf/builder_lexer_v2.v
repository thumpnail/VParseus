module ebnf

const(
	test_head = "module main
	import regex
fn (mut ctx ParserContext) consume(value string) {
	nxt := value
	if rgx := regex.regex_base(value) {
		// is regex
	} else if ctx.peek() == value {
		ctx.next()
	}
	error('Expected ' + value + ' got ' + nxt)
}
//peek
fn (mut ctx ParserContext) peek() string {
	return ctx.tokens[ctx.idx + 1]
}
//next
fn (mut ctx ParserContext) next() string {
	return ctx.tokens[ctx.idx++]
}"
)
// use recursive match?

// build_lexer_v2 is generates a lexer for recursive decent lexing...
fn (mut ctx VParseusContext) build_lexer_v2() string {
	mut result := "
module main
import regex
struct ParserContext {
	pub:
	source []string
	mut:
	idx int
}
struct Token {
	pub mut:
	t_type TokenType
	t_value string
	line int
	pos int
}
enum TokenType {${ctx.get_tokens()}
}
fn parse(words []string) []Token {
	mut Tokens := []Token{}
	//write start function //aka first rule
	parse_${ctx.ast.rules[0].value}()
	return Tokens
}
//generate recursive decent lexing
"
	//${ctx.get_parse_tree_functions()}//old
+"
//helper functions
//consume
// only consumes if matches
fn (mut ctx ParserContext) consume(value string) {
	nxt := value
	if rgx := regex.regex_base(value) {
		// is regex
	} else if ctx.peek() == value {
		ctx.next()
	}
	error('Expected ' + value + ' got ' + nxt)
}
//peek
fn (mut ctx ParserContext) peek() string {
	return ctx.tokens[ctx.idx + 1]
}
//next
fn (mut ctx ParserContext) next() string {
	return ctx.tokens[ctx.idx++]
}
//usw
${ctx.gen_src()}
"
	//TODO: Change for production
	return "$test_head\n${ctx.gen_src()}"
}
fn (ctx VParseusContext) gen_src() string {
	mut sb := StringBuilder{}
	for i in ctx.ast.rules {
		dump(i)
		sb.append_text(i.gen_src(0))
	}
	return sb.get_final()
}
fn (node SyntaxNode) gen_src(depth int) string {
	mut sb := StringBuilder{}
	mut repeat := 0
	mut jumper := 0
	sb.append_line('//${node.s_type.str()}: ${node.value.str()} # $depth')
	match node.s_type {
		.rule {
			if depth == 0 {
				sb.append_line('fn @${node.value}() bool {')
				for i in jumper .. node.children.len {
					sb.append_line(node.children[i].gen_src(depth+1))
				}
				sb.append_line('return false }')//Failed
			} else {
				sb.append_line('@${node.value}()')//or { return false }
			}
		}
		.literal {
			sb.append_line('consume(${node.value})') //or { return false }
		}
		.alt {
			sb.append_line('} else if 0 {')
		}
		.group {
			sb.append_line('if group_$depth {')
			if node.children.contains(SyntaxNode{value: '|',s_type: .alt, children: []}) {
				sb.append_line(node.next_jmp(jumper,depth))
			} else {
				sb.append_line(node.next(depth))
			}
		}
		.repeat {
			sb.append_line('for repeat_$depth {')
			if node.children.contains(SyntaxNode{value: '|',s_type: .alt, children: []}) {
				sb.append_line('if repeat$depth {')
				sb.append_line(node.next_jmp(jumper,depth))
				sb.append_line('}')
			} else {
				sb.append_line(node.next(depth))
			}
			sb.append_line('}')
		}
		.optional {
			sb.append_line('if opt_$depth {')
			if node.children.contains(SyntaxNode{value: '|',s_type: .alt, children: []}) {
				sb.append_line(node.next_jmp(jumper,depth))
			} else {
				sb.append_line(node.next(depth))
			}
			sb.append_line('}')
		}
		.assign {
			//add match if there are alt's upcoming
			sb.append_line(node.next(depth))
		}
		.end {
			if node.value == ')' {
				sb.append_line('}')
			}
		}
		else {error('wrong token type')}
	}
	return sb.get_final()
}
fn (node SyntaxNode) next(depth int) string {
	mut sb := StringBuilder{}
	for child in node.children {
		sb.append_line(child.gen_src(depth+1))
	}
	return sb.final
}
fn (node SyntaxNode) next_jmp(jumper int, depth int) string {
	mut sb := StringBuilder{}
	for i in jumper .. node.children.len {
		sb.append_line(node.children[i].gen_src(depth+1))
	}
	return sb.final
}
