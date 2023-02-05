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
fn (mut ctx ParserContext) consume(value string) ! {
	nxt := value
	if rgx := regex.regex_base(value) {
		// is regex
	} else if ctx.peek() == value {
		ctx.next()
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
fn @start() bool {
	for @stat() or { return false } {
	}

	return true
}

fn @stat() bool {
	// Match
	{
		@assign() or { return false }

		// OR

		@decl() or { return false }

		// OR

		@fndecl() or { return false }

		// OR

		@fncall() or { return false }
	}
	return true
}

fn @assign() bool {
	@name() or { return false }

	consume('=') or { return false }

	@value() or { return false }

	return true
}

fn @decl() bool {
	// Match
	{
		consume('var') or { return false }

		@name() or { return false }

		consume(':') or { return false }

		@type() or { return false }

		consume('=') or { return false }

		@value() or { return false }

		// OR

		consume('var') or { return false }

		@name() or { return false }

		consume(':=') or { return false }

		@value() or { return false }
	}
	return true
}

fn @value() bool {
	// Match
	{
		consume('0') or { return false }

		// OR

		consume('1') or { return false }

		// OR

		consume('2') or { return false }

		// OR

		consume('3') or { return false }

		// OR

		consume('4') or { return false }

		// OR

		consume('5') or { return false }

		// OR

		consume('6') or { return false }

		// OR

		consume('7') or { return false }

		// OR

		consume('8') or { return false }

		// OR

		consume('9') or { return false }
	}
	return true
}

fn @name() bool {
	// Match
	{
		consume('a') or { return false }

		// OR

		consume('b') or { return false }

		// OR

		consume('c') or { return false }

		// OR

		consume('d') or { return false }

		// OR

		consume('e') or { return false }
	}
	return true
}

fn @type() bool {
	// Match
	{
		consume('number') or { return false }

		// OR

		consume('any') or { return false }
	}
	return true
}

fn @fndecl() bool {
	consume('fnc') or { return false }

	@name() or { return false }

	consume(':') or { return false }

	@type() or { return false }

	consume('(') or { return false }

	@arglist() or { return false }

	consume(')') or { return false }

	consume('{') or { return false }

	for @stat() or { return false } {
	}

	consume('}') or { return false }

	return true
}

fn @fncall() bool {
	@name() or { return false }

	consume('(') or { return false }

	@arglist() or { return false }

	consume(')') or { return false }

	return true
}

fn @arglist() bool {
	@arg() or { return false }

	for consume(',') or { return false } {
		@arg() or { return false }
	}

	return true
}

fn @arg() bool {
	// Match
	{
		@value() or { return false }

		// OR

		@name() or { return false }
	}
	return true
}
