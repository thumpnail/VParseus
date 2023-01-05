module ebnf
enum TokenType {
	unknown
	rule // bla
	literal // 'int'
	assign // :=
	end // ;
	alt // |
	opt_open // [
	opt_close // ]
	opt_repeat_open // {
	opt_repeat_close // }
	group_open // (
	group_close // )

	comment // #
	comment_open // (*
	comment_close// *)

	colon
	eql
	star
}
const(
	all_chars = [
		'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
	]
	all_num = [
		'0','1','2','3','4','5','6','7','8','9','.'
	]
	operator_list = {
		':=': TokenType.assign
		';': TokenType.end
		'|': TokenType.alt
		'[': TokenType.opt_open
		']': TokenType.opt_close
		'{': TokenType.opt_repeat_open
		'}': TokenType.opt_repeat_close
		'(': TokenType.group_open
		')': TokenType.group_close
		'\'': TokenType.literal
		'\"': TokenType.literal
		'#': TokenType.comment
		'(*': TokenType.comment_open
		'*)': TokenType.comment_close
	}
	symbol_list = {
		':': TokenType.colon
		'=': TokenType.eql
		';': TokenType.end
		'|': TokenType.alt
		'[': TokenType.opt_open
		']': TokenType.opt_close
		'{': TokenType.opt_repeat_open
		'}': TokenType.opt_repeat_close
		'(': TokenType.group_open
		')': TokenType.group_close
		'\'': TokenType.literal
		'\"': TokenType.literal
		'#': TokenType.comment
		'*': TokenType.star
	}
)
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

			if c == '-' && array_contains(next, all_num) {
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
					word += "\'"
					i++
					for i < line.len {
						if line[i].ascii_str() != '\'' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += "\'"
					continue
				}
				if c == '\"' {
					word += "\""
					i++
					for i < line.len {
						if line[i].ascii_str() != '\"' {
							word += line[i].ascii_str()
						} else {
							break
						}
						i++
					}
					word += "\""
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
fn array_contains(c string, arr []string) bool {
	for item in arr {
		if item == c {
			return true
		}
	}
	return false
}
