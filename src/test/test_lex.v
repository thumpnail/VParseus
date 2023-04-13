
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
enum TokenType {
	unknown
	
}
fn parse(words []string) []Token {
	mut Tokens := []Token{}
	//write start function //aka first rule
	parse_a()
	return Tokens
}
//generate recursive decent lexing

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
//rule: a # 0
fn (mut ctx ParserContext) @a() bool {
//assign: := # 1
//group: ( # 2
if peek() == 'group' {


//alt: alt # 2
} else if peek() == 'alt' {

//group: ( # 2
if peek() == 'group' {
//alt: alt # 3
} else if peek() == 'alt' {

//alt: alt # 3
} else if peek() == 'alt' {

//repeat: { # 3
for {
//rule: c # 4
ctx.@c()

//rule: c # 4
ctx.@c()

//rule: c # 4
ctx.@c()


}





//end: ; # 1

return false }

