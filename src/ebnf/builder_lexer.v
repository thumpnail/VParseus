module ebnf
// build_lexer_strict strict version of lexer generator with custom number detection
fn (mut ctx VParseusContext)build_lexer_strict() string {
	mut code := "
module ${ctx.args['gen'][0]}

enum TokenType {${ctx.get_tokens()}
}
const(

	all_chars = [
		'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	]
	all_num = [
		'0','1','2','3','4','5','6','7','8','9','.'
	]
	symbol_list = {${ctx.get_symbol_map()}
	}
	keyword_list = {${ctx.get_keyword_map()}
	}
	operator_list = {${ctx.get_operator_map()}
	}
)

fn preprocessor(script_lines []string) []string {
	mut is_comment := false
	mut is_string := false
	mut is_char := false
	//mut is_number := false
	mut words := []string{}
	mut word := ''
	for line in script_lines {
		word = ''
		for i := 0; i < line.len; i+=1 {
			//HEAD
			mut c := line[i].ascii_str()
			mut next := ' '
			//BODY
			if i + 1 < line.len {
				next = line[i + 1].ascii_str()
			} else {
				//next = 'EOL'
			}
			// string and chars
			if is_string || is_char {
				if c != '\\\"' {
					word += c
					continue
				}
			}
			if c == '${ctx.get_comment_symbol}' || is_comment {
				is_comment = true
				continue
			}

			if c == '-' && all_num.contains(next) {
				word += c
				continue
			}

			if c == ' ' {
				// whitespace
				if word != '' {
					words << (word)
					word = ''
				}
			}

			if all_chars.contains(c) {
				// word
				word += c
			}
			if c in symbol_list {
				if next in symbol_list {
					tmp := '' + c + next
					if tmp in operator_list {
						words << tmp
						word = ''
						i += 2
						continue
					}
				}
				if c == '\\\'' {
					word += '\\\''
					i++
					for i < line.len {
						if line[i].ascii_str() != '\\\'' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += '\\\''
					continue
				}
				if c == '\\\"' {
					word += '\\\''
					i++
					for i < line.len {
						if line[i].ascii_str() != '\\\"' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += '\\\''
					continue
				}
				if word != '' {
					words << word
					word = ''
				}
				word += c
				if word != '' {
					words << word
					word = ''
				}
			}
		}
		is_comment = false
		is_string = false
		is_char = false
		//is_number = false
		if word != '' {
			words << (word)
		}
	}
	return words
}
struct TokenTuple {
	item1 TokenType
	item2 string
}

fn lexer(words []string) []TokenTuple {
	mut final := []TokenTuple{}
	mut inside_comment := false
	for i := 0; i < words.len; i++ {
		mut token := TokenType.unknown
		mut str := words[i]
		// is digit
		if words[i].contains_only('-1234567890') {
			//is no floating point
			token = TokenType.unknown
		} else if words[i].contains_only('-1234567890.') {
			//is floating point
			token = TokenType.unknown
			if !words[i].contains_only('-1234567890') {
				//anything else or just dot
				token = TokenType.unknown
			}
		} else {
			// special keyword_list
			if str in keyword_list{
				token = keyword_list[str]
			}
			// symbol_list and operator
			else if str in operator_list {
				token = operator_list[str]
			}
			// strings and chars
			else if str.contains('\\\"') {
				token = TokenType.unknown
			} else if str.contains('\\\'') {
				token = TokenType.unknown
				if str.len > 3 {
					token = TokenType.unknown
				}
			} else {
				token = TokenType.unknown
			}
		}
		final << TokenTuple{
			item1: token
			item2: str
		}
		str = ''
	}
	inside_comment = false
	mut remlist := []TokenTuple{}
	for item in final {
		if item.item2.contains('\\n') {
			inside_comment = false
		} else if item.item2 == ('\\n') {
			remlist << item
		} else if item.item2 == '#' {
			remlist << item
			inside_comment = true
		} else if inside_comment {
			remlist << item
		}
	}
	return final
}

"
	return code
}

fn (ctx VParseusContext) get_tokens() string {
	mut result := '\n\tunknown\n\t'
	for key in ctx.ast.rules {
		if key.children.len == 2 && key.children[0].children.len == 1 && key.children[0].children[0].s_type == .literal {
			result += key.value + '\n\t'
		}
	}
	return result
}
fn (ctx VParseusContext) get_symbol_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1 && rule.children[0].children[0].s_type == .literal && rule_value.substr(1, rule_value.len-1) in ctx.ast.symbols {
			result += "\n\t\t${rule_value}: " + "TokenType." + rule_name
		}
	}
	return result
}
fn (ctx VParseusContext) get_keyword_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		syntax_rules := rule.children[0].children
		if  rule.children.len == 2 && syntax_rules.len == 1 && syntax_rules[0].s_type == .literal && rule_value.substr(1, rule_value.len-1) in ctx.ast.keywords && rule_value.len > 2 {
			result += "\n\t\t${rule_value}: " + "TokenType." + rule_name
		}
	}
	return result}
fn (ctx VParseusContext) get_operator_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1 && rule.children[0].children[0].s_type == .literal && rule_value.substr(1, rule_value.len-1) in ctx.ast.operators {
			result += "\n\t\t${rule_value}: " + "TokenType." + rule_name
		}
	}
	return result}
fn (ctx VParseusContext) get_comment_symbol() string {
	return '#'
}
fn (ctx VParseusContext) get_symbol_list() string {
	mut result := ''
	for key in ctx.ast.symbols {
		result += "'${key}',"
	}
	return result.substr(0,result.len-1)
}
fn (ctx VParseusContext) get_operator_list() string {
	mut result := ''
	for key in ctx.ast.operators {
		result += "'${key}',"
	}
	return result.substr(0,result.len-1)
}
