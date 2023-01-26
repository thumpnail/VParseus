
module teal

enum TokenType {
	unknown
	tk_semicolon
	tk_equals
	tk_comma
	tk_colon
	tk_less
	tk_greater
	tk_colon_colon
	tk_dot
	tk_bracket_open
	tk_bracket_close
	tk_dot_dot_dot
	tk_parentheses_open
	tk_parentheses_close
	tk_braces_open
	tk_braces_close
	tk_plus
	tk_minus
	tk_asterisk
	tk_slash
	tk_slash_slash
	tk_circumflex
	tk_percent
	tk_tilde
	tk_greater_greater
	tk_less_less
	tk_dot_dot
	tk_equals_equals
	tk_hash
	tk_break
	tk_goto
	tk_do
	tk_end
	tk_while
	tk_repeat
	tk_until
	tk_if
	tk_then
	tk_elseif
	tk_else
	tk_for
	tk_in
	tk_function
	tk_local
	tk_record
	tk_enum
	tk_type
	tk_global
	tk_return
	tk_nil
	tk_false
	tk_true
	tk_as
	tk_is
	tk_and
	tk_or
	tk_not
	tk_string
	tk_boolean
	tk_number
	tk_userdata
	tk_metamethod
	
}
const(

	all_chars = [
		'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	]
	all_num = [
		'0','1','2','3','4','5','6','7','8','9','.'
	]
	symbol_list = {
		';': TokenType.tk_semicolon
		'=': TokenType.tk_equals
		',': TokenType.tk_comma
		':': TokenType.tk_colon
		'<': TokenType.tk_less
		'>': TokenType.tk_greater
		'.': TokenType.tk_dot
		'[': TokenType.tk_bracket_open
		']': TokenType.tk_bracket_close
		'(': TokenType.tk_parentheses_open
		')': TokenType.tk_parentheses_close
		'{': TokenType.tk_braces_open
		'}': TokenType.tk_braces_close
		'+': TokenType.tk_plus
		'-': TokenType.tk_minus
		'*': TokenType.tk_asterisk
		'/': TokenType.tk_slash
		'^': TokenType.tk_circumflex
		'%': TokenType.tk_percent
		'~': TokenType.tk_tilde
		'#': TokenType.tk_hash
	}
	keyword_list = {
		'break': TokenType.tk_break
		'goto': TokenType.tk_goto
		'do': TokenType.tk_do
		'end': TokenType.tk_end
		'while': TokenType.tk_while
		'repeat': TokenType.tk_repeat
		'until': TokenType.tk_until
		'if': TokenType.tk_if
		'then': TokenType.tk_then
		'elseif': TokenType.tk_elseif
		'else': TokenType.tk_else
		'for': TokenType.tk_for
		'in': TokenType.tk_in
		'function': TokenType.tk_function
		'local': TokenType.tk_local
		'record': TokenType.tk_record
		'enum': TokenType.tk_enum
		'type': TokenType.tk_type
		'global': TokenType.tk_global
		'return': TokenType.tk_return
		'nil': TokenType.tk_nil
		'false': TokenType.tk_false
		'true': TokenType.tk_true
		'as': TokenType.tk_as
		'is': TokenType.tk_is
		'and': TokenType.tk_and
		'or': TokenType.tk_or
		'not': TokenType.tk_not
		'string': TokenType.tk_string
		'boolean': TokenType.tk_boolean
		'number': TokenType.tk_number
		'userdata': TokenType.tk_userdata
		'metamethod': TokenType.tk_metamethod
	}
	operator_list = {
		';': TokenType.tk_semicolon
		'=': TokenType.tk_equals
		',': TokenType.tk_comma
		':': TokenType.tk_colon
		'<': TokenType.tk_less
		'>': TokenType.tk_greater
		'::': TokenType.tk_colon_colon
		'.': TokenType.tk_dot
		'[': TokenType.tk_bracket_open
		']': TokenType.tk_bracket_close
		'...': TokenType.tk_dot_dot_dot
		'(': TokenType.tk_parentheses_open
		')': TokenType.tk_parentheses_close
		'{': TokenType.tk_braces_open
		'}': TokenType.tk_braces_close
		'+': TokenType.tk_plus
		'-': TokenType.tk_minus
		'*': TokenType.tk_asterisk
		'/': TokenType.tk_slash
		'//': TokenType.tk_slash_slash
		'^': TokenType.tk_circumflex
		'%': TokenType.tk_percent
		'~': TokenType.tk_tilde
		'>>': TokenType.tk_greater_greater
		'<<': TokenType.tk_less_less
		'..': TokenType.tk_dot_dot
		'==': TokenType.tk_equals_equals
		'#': TokenType.tk_hash
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
				if c != '\"' {
					word += c
					continue
				}
			}
			if c == 'fn () string' || is_comment {
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
				if c == '\'' {
					word += '\''
					i++
					for i < line.len {
						if line[i].ascii_str() != '\'' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += '\''
					continue
				}
				if c == '\"' {
					word += '\''
					i++
					for i < line.len {
						if line[i].ascii_str() != '\"' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += '\''
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
			token = TokenType.unknown
		} else if words[i].contains_only('-1234567890.') {
			token = TokenType.unknown
			if !words[i].contains_only('-1234567890') {
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
			else if str.contains('\"') {
				token = TokenType.unknown
			} else if str.contains('\'') {
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
		if item.item2.contains('\n') {
			inside_comment = false
		} else if item.item2 == ('\n') {
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

