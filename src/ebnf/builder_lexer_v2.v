module ebnf
// build_lexer_v2 is generates a lexer the recursive decent way...
fn (mut ctx VParseusContext)build_lexer_v2() string {
	mut result := "
module main
struct Token {
	t_type TokenType
	t_value string
	line int
	pos int
}
enum TokenType {${ctx.get_tokens()}
}
const(
	all_chars = []
	all_nums = []
	all_symbols = []
	literal_map = {
		' ': TokenType.unknown
	}
)
fn lexer(words []string) []Token {
	mut Tokens := []Token{}
	return Tokens
}
"
	return result
}
