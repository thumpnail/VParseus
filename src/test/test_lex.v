module main

import regex

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

// rule: test # 0
fn @test() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// group: ( # 2
		if group_2 {
			// alt: | # 3
		} else if 0 {
			// optional: [ # 3
			if opt_3 {
				// alt: | # 4
			} else if 0 {
				// end: ] # 4
			}

			// alt: | # 3
		} else if 0 {
			// repeat: { # 3
			for repeat_3 {
				if repeat3 {
					// alt: | # 4
				} else if 0 {
					// end: } # 4
				}
			}

			// alt: | # 3
		} else if 0 {
			// optional: [ # 3
			if opt_3 {
				// alt: | # 4
			} else if 0 {
				// repeat: { # 4
				for repeat_4 {
					if repeat4 {
						// alt: | # 5
					} else if 0 {
						// end: } # 5
					}
				}

				// alt: | # 4
			} else if 0 {
				// end: ] # 4
			}

			// alt: | # 3
		} else if 0 {
			// end: ) # 3
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}
