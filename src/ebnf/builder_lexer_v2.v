module ebnf

import v.fmt
import v.ast
import v.parser
import v.pref
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
${ctx.get_parse_tree_functions()}
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
"
	return result
}

fn (mut ctx VParseusContext) get_tokens() string {
	mut result := '\n\tunknown\n\t'
	for key in ctx.ast.rules {
		if key.children.len == 2 && key.children[0].children.len == 1
			&& key.children[0].children[0].s_type == .literal {
			result += key.value + '\n\t'
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_symbol_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1
			&& rule.children[0].children[0].s_type == .literal
			&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.symbols {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_keyword_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		syntax_rules := rule.children[0].children
		if rule.children.len == 2 && syntax_rules.len == 1 && syntax_rules[0].s_type == .literal
			&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.keywords && rule_value.len > 2 {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_operator_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1
			&& rule.children[0].children[0].s_type == .literal
			&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.operators {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_comment_symbol() string {
	return '#'
}

fn (mut ctx VParseusContext) get_symbol_list() string {
	mut result := ''
	for key in ctx.ast.symbols {
		result += "'${key}',"
	}
	return result.substr(0, result.len - 1)
}

fn (mut ctx VParseusContext) get_operator_list() string {
	mut result := ''
	for key in ctx.ast.operators {
		result += "'${key}',"
	}
	return result.substr(0, result.len - 1)
}

fn (mut ctx VParseusContext) get_char_arrays() string {
	prefix := '\tall_'
	mut result := ''
	for rule in ctx.ast.rules {
		println('max depth(${rule.value}): ${rule.children[0].get_depth()}')
		if rule.children.len > 2 && rule.children[0].get_depth() == 2
			&& rule.enforce_type(.literal) == 0 {
			result += '${prefix + rule.value} = [\n\t\t'
			for i in rule.get_literals() {
				result += '${i},'
			}
			result += '\n\t]\n'
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_parse_tree_functions() string {
	mut result := ''
	for rule in ctx.ast.rules {
		result += ctx.gen_fn(rule)
	}
	return result
}

fn (mut ctx VParseusContext) gen_fn(rule SyntaxNode) string {
	mut res := 'fn parse_${rule.value}() {'
	// dump(rule)
	mut match_head := false
	for child in rule.children {
		// ':=' // '|' // ';'
		match child.s_type {
			.assign {
				res += '//-assign-'
				if rule.children.len > 2 && rule.children[1].s_type == .alt {
					res += 'match peek() {'
					res += ctx.gen_alt(child)
				} else {
					for item in child.children {
						println('Ping ${item.s_type} ${item.value}')
						match item.s_type {
							.rule {
								res += ctx.gen_rule(item)
							}
							.group {
								res += ctx.gen_grp(item)
							}
							.repeat {
								res += ctx.gen_repeat(item)
							}
							.optional {
								res += ctx.gen_opt(item)
							}
							.literal {
								res += ctx.gen_literal(item)
							}
							.alt {
								// TODO: One time match header
								res += ctx.gen_alt(item)
							}
							else {
								error('Expected <rule>, <group>, <repeat>, <optional>, <literal> or <alternative>')
							}
						}
					}
				}
			}
			.alt {
				res += '//-alt Header'
				res += ctx.gen_alt(child)
			}
			.end {
				if rule.children.len > 2 && rule.children[1].s_type == .alt {
					res += "else {error('expected ${rule.value}')}"
					res += '}'
				}
				res += '//-end-'
			}
			else {
				panic('Parser: Wrong token Type')
			}
		}
		res += ''
	}
	return res + '}'
}

fn (mut ctx VParseusContext) gen_alt(rule SyntaxNode) string {
	mut res := '
		${rule.children[0].value} {
			${ctx.gen_literal(rule.children[0])}
		}'
	return res
}

fn (mut ctx VParseusContext) gen_rule(rule SyntaxNode) string {
	mut res := ''
	res += '${rule.value}()'
	res += ''
	return res
}

fn (mut ctx VParseusContext) gen_opt(rule SyntaxNode) string {
	mut res := ''
	return 'gen_opt'
}

fn (mut ctx VParseusContext) gen_grp(rule SyntaxNode) string {
	return 'gen_grp'
}

fn (mut ctx VParseusContext) gen_repeat(rule SyntaxNode) string {
	return 'gen_repeat'
}

fn (mut ctx VParseusContext) gen_literal(rule SyntaxNode) string {
	match rule.s_type {
		.literal { return 'consume(${rule.value})' }
		.rule { return '${rule.value}()' }
		else { return "consume('${rule.value}')" }
	}
}
