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
	parse_test()
	return Tokens
}

// generate recursive decent lexing

// helper functions
// consume
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

// peek
fn (mut ctx ParserContext) peek() string {
	return ctx.tokens[ctx.idx + 1]
}

// next
fn (mut ctx ParserContext) next() string {
	return ctx.tokens[ctx.idx++]
}

// usw
// rule: test # 0
fn (mut ctx ParserContext) @test() bool {
	// assign: := # 1
	// group: ( # 2
	if placeholder_group_2 {
		// group: ( # 2
		if placeholder_group_2 {
			// rule: a # 3
			ctx.@a()

			// alt: | # 3
		} else if placeholder_alt_3 {
			// rule: a # 3
			ctx.@a()

			// optional: [ # 3
			if placeholder_opt_3 {
				// literal: 'aa' # 4
				ctx.consume('aa')

				// alt: | # 4
			} else if placeholder_alt_4 {
				// literal: 'aa' # 4
				ctx.consume('aa')

				// end: ] # 4
			}

			// rule: a # 3
			ctx.@a()

			// alt: | # 3
		} else if placeholder_alt_3 {
			// rule: a # 3
			ctx.@a()

			// repeat: { # 3
			for placeholder_repeat_3 {
				if placeholder_repeat_3 {
					// literal: 'aa' # 4
					ctx.consume('aa')

					// alt: | # 4
				} else if placeholder_alt_4 {
					// rule: a # 4
					ctx.@a()

					// end: } # 4
				} else {
					break
				}
			}

			// rule: a # 3
			ctx.@a()

			// alt: | # 3
		} else if placeholder_alt_3 {
			// literal: 'aa' # 3
			ctx.consume('aa')

			// optional: [ # 3
			if placeholder_opt_3 {
				// rule: a # 4
				ctx.@a()

				// alt: | # 4
			} else if placeholder_alt_4 {
				// literal: 'aa' # 4
				ctx.consume('aa')

				// repeat: { # 4
				for placeholder_repeat_4 {
					if placeholder_repeat_4 {
						// literal: 'aa' # 5
						ctx.consume('aa')

						// alt: | # 5
					} else if placeholder_alt_5 {
						// rule: a # 5
						ctx.@a()

						// end: } # 5
					} else {
						break
					}
				}

				// literal: 'aa' # 4
				ctx.consume('aa')

				// alt: | # 4
			} else if placeholder_alt_4 {
				// literal: 'aa' # 4
				ctx.consume('aa')

				// end: ] # 4
			}

			// rule: a # 3
			ctx.@a()

			// alt: | # 3
		} else if placeholder_alt_3 {
			// rule: a # 3
			ctx.@a()

			// end: ) # 3
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: a # 0
fn (mut ctx ParserContext) @a() bool {
	// assign: := # 1
	// group: ( # 2
	if placeholder_group_2 {
		// literal: 'bb' # 3
		ctx.consume('bb')

		// alt: | # 3
	} else if placeholder_alt_3 {
		// literal: 'cc' # 3
		ctx.consume('cc')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}
