module scretches

// start := { stat };
//stat := data_decl
//    | assign
//    | decl;
//data_decl := 'data' { expr_list } '{' decl '}';
//assign := identifier [ ':' type ] := expr;
//decl := identifier [ ':' type ];
//expr := expr | expr '+' expr | expr '*' expr | number;
//expr_list := expr { ',' expr };
//identifier := '[a-zA-Z_0-9]';
//number := ['-'] '[0-9]+';

fn preprocessor(lines []string) []string {
	mut is_comment := false
	mut is_string := false
	mut is_char := false
	mut is_number := false
	mut words := []string{}
	mut word := ""
	// TODO: Tupel for errors
	for line in lines {
		word = ""
		for i := 0; i < line.len; i+=1 {
			//HEAD
			mut c := line[i].ascii_str()
			mut next := ' '
			//BODY
			if i + 1 < line.len {
				next = line[i + 1].ascii_str()
			} else {
				next = "EOL"
			}
			// string and chars
			if is_string || is_char {
				if c != '\"' {
					word += c
					continue
				}
			}
			if c == '#' || is_comment {
				is_comment = true
				continue
			}

			if c == '-' && next.contains_only('1234567890') {
				word += c
				continue
			}

			if c == ' ' {
				// whitespace
				if word != "" {
					words << (word)
					word = ""
				}
			}

			if array_contains(c,all_chars) {
				// word
				word += c
			}
			if x := symbol_list[c] {
				if y := symbol_list[next] {
					tmp := "" + c + next
					if z := operator_list[tmp] {
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
				if word != "" {
					words << word
					word = ""
				}
				word += c
				if word != "" {
					words << word
					word = ""
				}
			}
		}
		is_comment = false
		is_string = false
		is_char = false
		if word != "" {
			words << (word)
		}
	}
	return words
}

enum TokenType {
	unkown
}
const(
	symbols = map[string]TokenType{
		'=': TokenType.unkown
	}
	keywords = map[string]TokenType{
		'void': TokenType.unkown
	}
	operators = map[string]TokenType{
		'+': TokenType.unkown
	}
)

fn lexer(words []string) []TokenTuple {
	mut final := []TokenTuple{}
	mut inside_comment := false
	for i := 0; i < words.len; i++ {
		mut token := TokenType.unknown
		mut str := words[i]

		if tok := operator_list[str] {
			token = tok
		} else if str.contains("\"") { // strings and chars
			token = TokenType.literal
		} else if str.contains('\'') { // todo: workaround based on ebnf
			token = TokenType.literal
		} else {
			token = TokenType.rule
		}
		if token == TokenType.comment_open || inside_comment {
			inside_comment = true
			if token == TokenType.comment_close {
				inside_comment = false
				continue
			}
			continue
		}
		final << TokenTuple{token, str}
		str = ""
	}
	// CommentFix
	inside_comment = false
	return final
}
