module main

struct ParserContext {
pub:
	source []string
mut:
	idx int
}

struct Token {
pub mut:
	t_type  TokenType
	t_value string
	line    int
	pos     int
}

enum TokenType {
	unknown
}

fn parse(words []string) []Token {
	mut Tokens := []Token{}
	// write start function //aka first rule
	parse_start()
	return Tokens
}

// generate recursive decent lexing

// helper functions
// consume
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

// peek
fn (mut ctx ParserContext) peek() string {
	return ctx.tokens[ctx.idx + 1]
}

// next
fn (mut ctx ParserContext) next() string {
	return ctx.tokens[ctx.idx++]
}

// usw
fn @start() {
	// condition
	for {
		@stat()
	}
}

fn @stat() {
	@datadecl()

	// OR//
	@assign()

	// OR//
	@decl()
}

fn @datadecl() {
	consume('data')

	@identifier()

	consume('{')

	@decl()

	consume('}')
}

fn @assign() {
	@identifier()

	consume(':')

	@type()

	consume(':=')

	@expr()
}

fn @decl() {
	@identifier()

	consume(':')

	@type()
}

fn @expr() {
	@expr()

	// OR//
	@expr()

	consume('+')

	@expr()

	// OR//
	@expr()

	consume('*')

	@expr()

	// OR//
	@expr()

	consume('++')

	// OR//
	@expr()

	consume('--')

	// OR//
	@number()
}

fn @exprlist() {
	@expr()

	// condition
	for {
		consume(',')

		@expr()
	}
}

fn @identifier() {
	@letter()

	// condition
	for {
		@letter()

		// OR//

		@digit()
	}
}

fn @number() {
	consume('-')

	// condition
	for {
		@digit()
	}
}

fn @type() {
	consume('number')

	// OR//
	consume('string')
}

fn @digit() {
	consume('0')

	// OR//
	consume('1')

	// OR//
	consume('2')

	// OR//
	consume('3')

	// OR//
	consume('4')

	// OR//
	consume('5')

	// OR//
	consume('6')

	// OR//
	consume('7')

	// OR//
	consume('8')

	// OR//
	consume('9')
}

fn @letter() {
	consume('a')

	// OR//
	consume('b')

	// OR//
	consume('c')

	// OR//
	consume('d')

	// OR//
	consume('e')

	// OR//
	consume('f')

	// OR//
	consume('g')

	// OR//
	consume('h')

	// OR//
	consume('i')

	// OR//
	consume('j')

	// OR//
	consume('k')

	// OR//
	consume('l')

	// OR//
	consume('m')

	// OR//
	consume('n')

	// OR//
	consume('o')

	// OR//
	consume('p')

	// OR//
	consume('q')

	// OR//
	consume('r')

	// OR//
	consume('s')

	// OR//
	consume('t')

	// OR//
	consume('u')

	// OR//
	consume('v')

	// OR//
	consume('w')

	// OR//
	consume('x')

	// OR//
	consume('y')

	// OR//
	consume('z')

	// OR//
	consume('_')

	// OR//
	consume('A')

	// OR//
	consume('B')

	// OR//
	consume('C')

	// OR//
	consume('D')

	// OR//
	consume('E')

	// OR//
	consume('F')

	// OR//
	consume('G')

	// OR//
	consume('H')

	// OR//
	consume('I')

	// OR//
	consume('J')

	// OR//
	consume('K')

	// OR//
	consume('L')

	// OR//
	consume('M')

	// OR//
	consume('N')

	// OR//
	consume('O')

	// OR//
	consume('P')

	// OR//
	consume('Q')

	// OR//
	consume('R')

	// OR//
	consume('S')

	// OR//
	consume('T')

	// OR//
	consume('U')

	// OR//
	consume('V')

	// OR//
	consume('W')

	// OR//
	consume('X')

	// OR//
	consume('Y')

	// OR//
	consume('Z')
}
