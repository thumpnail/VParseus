module ebnf

// use recursive match?

// build_lexer_v2 is generates a lexer for recursive decent lexing...
fn (mut ctx VParseusContext) build_lexer_v2() string {
	mut result := "
module main
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
	//${ctx.get_parse_tree_functions()}
+"
//helper functions
//consume
fn (mut ctx ParserContext) consume(value string) bool {
	nxt := value
	if rgx := regex.regex_base(value) {
		// is regex
		return true
	} else if ctx.peek() == value {
		ctx.next()
		return true
	}
	panic('Expected ' + value + ' got ' + nxt)
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
	return result
}
fn (ctx VParseusContext) gen_src() string {
	mut sb := StringBuilder{}
	for i in ctx.ast.rules {
		sb.append_text(i.gen_src(0))
	}
	return sb.get_final()
}
fn (node SyntaxNode) gen_src(depth int) string {
	mut sb := StringBuilder{}
	mut repeat := 0
	if depth == 0 {
		sb.append_line('fn @${node.value}() {')
	} else {
		match node.s_type {
			.rule {
				sb.append_line('@${node.value}()')
			}
			.group {}
			.repeat {
				sb.append_line('for /* condition */{')
				repeat++
			}
			.optional {}
			.literal {
				sb.append_line('consume(${node.value})')
			}
			.assign {}
			.alt {
				sb.append_line('//OR//')
			}
			.end {}
			else {error('wrong token type')}
		}
	}
	for child in node.children {
		sb.append_line(child.gen_src(depth+1))
	}
	if depth == 0 || repeat > 0 {
		if repeat > 0 {repeat -= 0}
		sb.append_line('}')
	}
	return sb.get_final()
}
