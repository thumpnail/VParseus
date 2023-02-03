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
	tk_equals
	tk_colon
	tk_colon_equals
	tk_var
	tk_number
	tk_any
}

fn parse(words []string) []Token {
	mut Tokens := []Token{}
	// write start function //aka first rule
	parse_start()
	return Tokens
}

// generate recursive decent lexing
fn parse_start() {
	//-assign-
	gen_repeat

	//-end-
}

fn parse_stat() {
	//-assign-
	match peek() {
		assign {
			assign()
		}
		//-alt Header-
		decl {
			decl()
		}
		else {
			error('expected stat')
		}
	}
	//-end-
}

fn parse_assign() {
	//-assign-
	name()
	tk_equals()
	value()

	//-end-
}

fn parse_decl() {
	//-assign-
	match peek() {
		tk_var {
			tk_var()
		}
		//-alt Header-
		tk_var {
			tk_var()
		}
		else {
			error('expected decl')
		}
	}
	//-end-
}

fn parse_value() {
	//-assign-
	match peek() {
		'0' {
			consume('0')
		}
		//-alt Header-
		'1' {
			consume('1')
		}
		//-alt Header-
		'2' {
			consume('2')
		}
		//-alt Header-
		'3' {
			consume('3')
		}
		//-alt Header-
		'4' {
			consume('4')
		}
		//-alt Header-
		'5' {
			consume('5')
		}
		//-alt Header-
		'6' {
			consume('6')
		}
		//-alt Header-
		'7' {
			consume('7')
		}
		//-alt Header-
		'8' {
			consume('8')
		}
		//-alt Header-
		'9' {
			consume('9')
		}
		else {
			error('expected value')
		}
	}
	//-end-
}

fn parse_name() {
	//-assign-
	match peek() {
		'a' {
			consume('a')
		}
		//-alt Header-
		'b' {
			consume('b')
		}
		//-alt Header-
		'c' {
			consume('c')
		}
		//-alt Header-
		'd' {
			consume('d')
		}
		//-alt Header-
		'e' {
			consume('e')
		}
		else {
			error('expected name')
		}
	}
	//-end-
}

fn parse_type() {
	//-assign-
	match peek() {
		tk_number {
			tk_number()
		}
		//-alt Header-
		tk_any {
			tk_any()
		}
		else {
			error('expected type')
		}
	}
	//-end-
}

fn parse_tk_equals() {
	//-assign-
	consume('=')
	//-end-
}

fn parse_tk_colon() {
	//-assign-
	consume(':')
	//-end-
}

fn parse_tk_colon_equals() {
	//-assign-
	consume(':=')
	//-end-
}

fn parse_tk_var() {
	//-assign-
	consume('var')
	//-end-
}

fn parse_tk_number() {
	//-assign-
	consume('number')
	//-end-
}

fn parse_tk_any() {
	//-assign-
	consume('any')
	//-end-
}

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
