module ebnf

import context
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

		if tok := operator_list[str] {
			token = tok
		} else if str.contains("\"") { // strings and chars
			token = TokenType.literal
		} else if str.contains('\'') {
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
fn string_exist_of(src string, arr []u8) bool {
	mut check := 0
	for item in src {
		if arr.contains(item) {
			check++
		}
	}
	return check == src.len // Exist Of
}
fn string_contains_u8(src string, arr []u8) bool {
	mut check := 0
	for item in src {
		if arr.contains(item) {
			check++
		}
	}
	return check >= 0 // Contains
}
fn string_contains_string(src string, arr []string) bool {
	return arr.contains(src)
}
fn string_equals(src string, arr []u8) bool {
	mut check := 0
	for c in arr {
		if src == c.ascii_str() {
			check++
		}
	}
	return check == src.len
}