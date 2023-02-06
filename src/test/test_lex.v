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

// rule: chunk # 0
fn @chunk() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: block # 3
		@block()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: block # 0
fn @block() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// repeat: { # 3
		for repeat_3 {
			// rule: stat # 4
			@stat()

			// end: } # 4
		}

		// optional: [ # 3
		if opt_3 {
			// rule: retstat # 4
			@retstat()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: stat # 0
fn @stat() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: ';' # 3
		consume(';')

		// alt: | # 3
	} else if 0 {
		// rule: varlist # 3
		@varlist()

		// literal: '=' # 3
		consume('=')

		// rule: explist # 3
		@explist()

		// alt: | # 3
	} else if 0 {
		// rule: functioncall # 3
		@functioncall()

		// alt: | # 3
	} else if 0 {
		// rule: label # 3
		@label()

		// alt: | # 3
	} else if 0 {
		// literal: 'break' # 3
		consume('break')

		// alt: | # 3
	} else if 0 {
		// literal: 'goto' # 3
		consume('goto')

		// rule: Name # 3
		@Name()

		// alt: | # 3
	} else if 0 {
		// literal: 'do' # 3
		consume('do')

		// rule: block # 3
		@block()

		// literal: 'end' # 3
		consume('end')

		// alt: | # 3
	} else if 0 {
		// literal: 'while' # 3
		consume('while')

		// rule: exp # 3
		@exp()

		// literal: 'do' # 3
		consume('do')

		// rule: block # 3
		@block()

		// literal: 'end' # 3
		consume('end')

		// alt: | # 3
	} else if 0 {
		// literal: 'repeat' # 3
		consume('repeat')

		// rule: block # 3
		@block()

		// literal: 'until' # 3
		consume('until')

		// rule: exp # 3
		@exp()

		// alt: | # 3
	} else if 0 {
		// literal: 'if' # 3
		consume('if')

		// rule: exp # 3
		@exp()

		// literal: 'then' # 3
		consume('then')

		// rule: block # 3
		@block()

		// repeat: { # 3
		for repeat_3 {
			// literal: 'elseif' # 4
			consume('elseif')

			// rule: exp # 4
			@exp()

			// literal: 'then' # 4
			consume('then')

			// rule: block # 4
			@block()

			// end: } # 4
		}

		// optional: [ # 3
		if opt_3 {
			// literal: 'else' # 4
			consume('else')

			// rule: block # 4
			@block()

			// end: ] # 4
		}

		// literal: 'end' # 3
		consume('end')

		// alt: | # 3
	} else if 0 {
		// literal: 'for' # 3
		consume('for')

		// rule: Name # 3
		@Name()

		// literal: '=' # 3
		consume('=')

		// rule: exp # 3
		@exp()

		// literal: ',' # 3
		consume(',')

		// rule: exp # 3
		@exp()

		// optional: [ # 3
		if opt_3 {
			// literal: ',' # 4
			consume(',')

			// rule: exp # 4
			@exp()

			// end: ] # 4
		}

		// literal: 'do' # 3
		consume('do')

		// rule: block # 3
		@block()

		// literal: 'end' # 3
		consume('end')

		// alt: | # 3
	} else if 0 {
		// literal: 'for' # 3
		consume('for')

		// rule: namelist # 3
		@namelist()

		// literal: 'in' # 3
		consume('in')

		// rule: explist # 3
		@explist()

		// literal: 'do' # 3
		consume('do')

		// rule: block # 3
		@block()

		// literal: 'end' # 3
		consume('end')

		// alt: | # 3
	} else if 0 {
		// literal: 'function' # 3
		consume('function')

		// rule: funcname # 3
		@funcname()

		// rule: funcbody # 3
		@funcbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'local' # 3
		consume('local')

		// rule: attnamelist # 3
		@attnamelist()

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: typelist # 4
			@typelist()

			// end: ] # 4
		}

		// optional: [ # 3
		if opt_3 {
			// literal: '=' # 4
			consume('=')

			// rule: explist # 4
			@explist()

			// end: ] # 4
		}

		// alt: | # 3
	} else if 0 {
		// literal: 'local' # 3
		consume('local')

		// literal: 'function' # 3
		consume('function')

		// rule: Name # 3
		@Name()

		// rule: funcbody # 3
		@funcbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'local' # 3
		consume('local')

		// literal: 'record' # 3
		consume('record')

		// rule: Name # 3
		@Name()

		// rule: recordbody # 3
		@recordbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'local' # 3
		consume('local')

		// literal: 'enum' # 3
		consume('enum')

		// rule: Name # 3
		@Name()

		// rule: enumbody # 3
		@enumbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'local' # 3
		consume('local')

		// literal: 'type' # 3
		consume('type')

		// rule: Name # 3
		@Name()

		// literal: '=' # 3
		consume('=')

		// rule: newtype # 3
		@newtype()

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// rule: attnamelist # 3
		@attnamelist()

		// literal: ':' # 3
		consume(':')

		// rule: typelist # 3
		@typelist()

		// optional: [ # 3
		if opt_3 {
			// literal: '=' # 4
			consume('=')

			// rule: explist # 4
			@explist()

			// end: ] # 4
		}

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// rule: attnamelist # 3
		@attnamelist()

		// literal: '=' # 3
		consume('=')

		// rule: explist # 3
		@explist()

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// literal: 'function' # 3
		consume('function')

		// rule: Name # 3
		@Name()

		// rule: funcbody # 3
		@funcbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// literal: 'record' # 3
		consume('record')

		// rule: Name # 3
		@Name()

		// rule: recordbody # 3
		@recordbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// literal: 'enum' # 3
		consume('enum')

		// rule: Name # 3
		@Name()

		// rule: enumbody # 3
		@enumbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'global' # 3
		consume('global')

		// literal: 'type' # 3
		consume('type')

		// rule: Name # 3
		@Name()

		// optional: [ # 3
		if opt_3 {
			// literal: '=' # 4
			consume('=')

			// rule: newtype # 4
			@newtype()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: attnamelist # 0
fn @attnamelist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// optional: [ # 3
		if opt_3 {
			// rule: attrib # 4
			@attrib()

			// end: ] # 4
		}

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: Name # 4
			@Name()

			// optional: [ # 4
			if opt_4 {
				// rule: attrib # 5
				@attrib()

				// end: ] # 5
			}

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: attrib # 0
fn @attrib() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '<' # 3
		consume('<')

		// rule: Name # 3
		@Name()

		// literal: '>' # 3
		consume('>')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: retstat # 0
fn @retstat() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'return' # 3
		consume('return')

		// optional: [ # 3
		if opt_3 {
			// rule: explist # 4
			@explist()

			// end: ] # 4
		}

		// optional: [ # 3
		if opt_3 {
			// literal: ';' # 4
			consume(';')

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: label # 0
fn @label() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '::' # 3
		consume('::')

		// rule: Name # 3
		@Name()

		// literal: '::' # 3
		consume('::')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: funcname # 0
fn @funcname() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// repeat: { # 3
		for repeat_3 {
			// literal: '.' # 4
			consume('.')

			// rule: Name # 4
			@Name()

			// end: } # 4
		}

		// literal: ':' # 3
		consume(':')

		// rule: Name # 3
		@Name()

		// alt: | # 3
	} else if 0 {
		// rule: Name # 3
		@Name()

		// repeat: { # 3
		for repeat_3 {
			// literal: '.' # 4
			consume('.')

			// rule: Name # 4
			@Name()

			// end: } # 4
		}

		// literal: '.' # 3
		consume('.')

		// rule: Name # 3
		@Name()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: varlist # 0
fn @varlist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: var # 3
		@var()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: var # 4
			@var()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: var # 0
fn @var() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// alt: | # 3
	} else if 0 {
		// rule: prefixexp # 3
		@prefixexp()

		// literal: '[' # 3
		consume('[')

		// rule: exp # 3
		@exp()

		// literal: ']' # 3
		consume(']')

		// alt: | # 3
	} else if 0 {
		// rule: prefixexp # 3
		@prefixexp()

		// literal: '.' # 3
		consume('.')

		// rule: Name # 3
		@Name()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: namelist # 0
fn @namelist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: Name # 4
			@Name()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: explist # 0
fn @explist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: exp # 3
		@exp()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: exp # 4
			@exp()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: exp # 0
fn @exp() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'nil' # 3
		consume('nil')

		// alt: | # 3
	} else if 0 {
		// literal: 'false' # 3
		consume('false')

		// alt: | # 3
	} else if 0 {
		// literal: 'true' # 3
		consume('true')

		// alt: | # 3
	} else if 0 {
		// rule: Numeral # 3
		@Numeral()

		// alt: | # 3
	} else if 0 {
		// rule: LiteralString # 3
		@LiteralString()

		// alt: | # 3
	} else if 0 {
		// literal: '...' # 3
		consume('...')

		// alt: | # 3
	} else if 0 {
		// rule: functiondef # 3
		@functiondef()

		// alt: | # 3
	} else if 0 {
		// rule: prefixexp # 3
		@prefixexp()

		// alt: | # 3
	} else if 0 {
		// rule: tableconstructor # 3
		@tableconstructor()

		// alt: | # 3
	} else if 0 {
		// rule: exp # 3
		@exp()

		// rule: binop # 3
		@binop()

		// rule: exp # 3
		@exp()

		// alt: | # 3
	} else if 0 {
		// rule: unop # 3
		@unop()

		// rule: exp # 3
		@exp()

		// alt: | # 3
	} else if 0 {
		// rule: exp # 3
		@exp()

		// literal: 'as' # 3
		consume('as')

		// rule: type # 3
		@type()

		// alt: | # 3
	} else if 0 {
		// rule: exp # 3
		@exp()

		// literal: 'as' # 3
		consume('as')

		// literal: '(' # 3
		consume('(')

		// rule: typelist # 3
		@typelist()

		// literal: ')' # 3
		consume(')')

		// alt: | # 3
	} else if 0 {
		// rule: Name # 3
		@Name()

		// literal: 'is' # 3
		consume('is')

		// rule: type # 3
		@type()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: prefixexp # 0
fn @prefixexp() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: var # 3
		@var()

		// alt: | # 3
	} else if 0 {
		// rule: functioncall # 3
		@functioncall()

		// alt: | # 3
	} else if 0 {
		// literal: '(' # 3
		consume('(')

		// rule: exp # 3
		@exp()

		// literal: ')' # 3
		consume(')')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: functioncall # 0
fn @functioncall() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: prefixexp # 3
		@prefixexp()

		// rule: args # 3
		@args()

		// alt: | # 3
	} else if 0 {
		// rule: prefixexp # 3
		@prefixexp()

		// literal: ':' # 3
		consume(':')

		// rule: Name # 3
		@Name()

		// rule: args # 3
		@args()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: args # 0
fn @args() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '(' # 3
		consume('(')

		// optional: [ # 3
		if opt_3 {
			// rule: explist # 4
			@explist()

			// end: ] # 4
		}

		// literal: ')' # 3
		consume(')')

		// alt: | # 3
	} else if 0 {
		// rule: tableconstructor # 3
		@tableconstructor()

		// alt: | # 3
	} else if 0 {
		// rule: LiteralString # 3
		@LiteralString()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: functiondef # 0
fn @functiondef() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'function' # 3
		consume('function')

		// rule: funcbody # 3
		@funcbody()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: funcbody # 0
fn @funcbody() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// optional: [ # 3
		if opt_3 {
			// rule: typeargs # 4
			@typeargs()

			// end: ] # 4
		}

		// literal: '(' # 3
		consume('(')

		// optional: [ # 3
		if opt_3 {
			// rule: parlist # 4
			@parlist()

			// end: ] # 4
		}

		// literal: ')' # 3
		consume(')')

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: retlist # 4
			@retlist()

			// end: ] # 4
		}

		// rule: block # 3
		@block()

		// literal: 'end' # 3
		consume('end')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: parlist # 0
fn @parlist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: parnamelist # 3
		@parnamelist()

		// optional: [ # 3
		if opt_3 {
		}

		// literal: ',' # 3
		consume(',')

		// literal: '...' # 3
		consume('...')

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: type # 4
			@type()

			// end: ] # 4

			// end: ] # 4
		}

		// alt: | # 3
	} else if 0 {
		// literal: '...' # 3
		consume('...')

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: type # 4
			@type()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: tableconstructor # 0
fn @tableconstructor() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '{' # 3
		consume('{')

		// optional: [ # 3
		if opt_3 {
			// rule: fieldlist # 4
			@fieldlist()

			// end: ] # 4
		}

		// literal: '}' # 3
		consume('}')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: fieldlist # 0
fn @fieldlist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: field # 3
		@field()

		// repeat: { # 3
		for repeat_3 {
			// rule: fieldsep # 4
			@fieldsep()

			// rule: field # 4
			@field()

			// end: } # 4
		}

		// optional: [ # 3
		if opt_3 {
			// rule: fieldsep # 4
			@fieldsep()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: field # 0
fn @field() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '[' # 3
		consume('[')

		// rule: exp # 3
		@exp()

		// literal: ']' # 3
		consume(']')

		// literal: '=' # 3
		consume('=')

		// rule: exp # 3
		@exp()

		// alt: | # 3
	} else if 0 {
		// rule: Name # 3
		@Name()

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: type # 4
			@type()

			// end: ] # 4
		}

		// literal: '=' # 3
		consume('=')

		// rule: exp # 3
		@exp()

		// alt: | # 3
	} else if 0 {
		// rule: exp # 3
		@exp()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: fieldsep # 0
fn @fieldsep() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: ',' # 3
		consume(',')

		// alt: | # 3
	} else if 0 {
		// literal: ';' # 3
		consume(';')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: binop # 0
fn @binop() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '+' # 3
		consume('+')

		// alt: | # 3
	} else if 0 {
		// literal: '-' # 3
		consume('-')

		// alt: | # 3
	} else if 0 {
		// literal: '*' # 3
		consume('*')

		// alt: | # 3
	} else if 0 {
		// literal: '/' # 3
		consume('/')

		// alt: | # 3
	} else if 0 {
		// literal: '//' # 3
		consume('//')

		// alt: | # 3
	} else if 0 {
		// literal: '^' # 3
		consume('^')

		// alt: | # 3
	} else if 0 {
		// literal: '%' # 3
		consume('%')

		// alt: | # 3
	} else if 0 {
		// literal: '&' # 3
		consume('&')

		// alt: | # 3
	} else if 0 {
		// literal: '~' # 3
		consume('~')

		// alt: | # 3
	} else if 0 {
		// literal: '|' # 3
		consume('|')

		// alt: | # 3
	} else if 0 {
		// literal: '>>' # 3
		consume('>>')

		// alt: | # 3
	} else if 0 {
		// literal: '<<' # 3
		consume('<<')

		// alt: | # 3
	} else if 0 {
		// literal: '..' # 3
		consume('..')

		// alt: | # 3
	} else if 0 {
		// literal: '<' # 3
		consume('<')

		// alt: | # 3
	} else if 0 {
		// literal: '<' # 3
		consume('<')

		// rule: = # 3
		@=()

		// alt: | # 3
	} else if 0 {
		// literal: '>' # 3
		consume('>')

		// alt: | # 3
	} else if 0 {
		// literal: '>' # 3
		consume('>')

		// rule: = # 3
		@=()

		// alt: | # 3
	} else if 0 {
		// literal: '==' # 3
		consume('==')

		// alt: | # 3
	} else if 0 {
		// literal: '~' # 3
		consume('~')

		// rule: = # 3
		@=()

		// alt: | # 3
	} else if 0 {
		// literal: 'and' # 3
		consume('and')

		// alt: | # 3
	} else if 0 {
		// literal: 'or' # 3
		consume('or')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: unop # 0
fn @unop() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '-' # 3
		consume('-')

		// alt: | # 3
	} else if 0 {
		// literal: 'not' # 3
		consume('not')

		// alt: | # 3
	} else if 0 {
		// literal: '#' # 3
		consume('#')

		// alt: | # 3
	} else if 0 {
		// literal: '~' # 3
		consume('~')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: type # 0
fn @type() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '(' # 3
		consume('(')

		// rule: type # 3
		@type()

		// literal: ')' # 3
		consume(')')

		// alt: | # 3
	} else if 0 {
		// rule: basetype # 3
		@basetype()

		// repeat: { # 3
		for repeat_3 {
			// literal: '|' # 4
			consume('|')

			// rule: basetype # 4
			@basetype()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: basetype # 0
fn @basetype() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'string' # 3
		consume('string')

		// alt: | # 3
	} else if 0 {
		// literal: 'boolean' # 3
		consume('boolean')

		// alt: | # 3
	} else if 0 {
		// literal: 'nil' # 3
		consume('nil')

		// alt: | # 3
	} else if 0 {
		// literal: 'number' # 3
		consume('number')

		// alt: | # 3
	} else if 0 {
		// literal: '{' # 3
		consume('{')

		// rule: type # 3
		@type()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: type # 4
			@type()

			// end: } # 4
		}

		// literal: '}' # 3
		consume('}')

		// alt: | # 3
	} else if 0 {
		// literal: '{' # 3
		consume('{')

		// rule: type # 3
		@type()

		// literal: ':' # 3
		consume(':')

		// rule: type # 3
		@type()

		// literal: '}' # 3
		consume('}')

		// alt: | # 3
	} else if 0 {
		// rule: functiontype # 3
		@functiontype()

		// alt: | # 3
	} else if 0 {
		// rule: Name # 3
		@Name()

		// repeat: { # 3
		for repeat_3 {
		}

		// repeat: { # 3
		for repeat_3 {
			// literal: '.' # 4
			consume('.')

			// rule: Name # 4
			@Name()

			// end: } # 4

			// end: } # 4
		}

		// optional: [ # 3
		if opt_3 {
			// rule: typeargs # 4
			@typeargs()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: typelist # 0
fn @typelist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: type # 3
		@type()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: type # 4
			@type()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: retlist # 0
fn @retlist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '(' # 3
		consume('(')

		// optional: [ # 3
		if opt_3 {
			// rule: typelist # 4
			@typelist()

			// end: ] # 4
		}

		// optional: [ # 3
		if opt_3 {
			// literal: '...' # 4
			consume('...')

			// end: ] # 4
		}

		// literal: ')' # 3
		consume(')')

		// alt: | # 3
	} else if 0 {
		// rule: typelist # 3
		@typelist()

		// optional: [ # 3
		if opt_3 {
			// literal: '...' # 4
			consume('...')

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: typeargs # 0
fn @typeargs() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: '<' # 3
		consume('<')

		// rule: Name # 3
		@Name()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: Name # 4
			@Name()

			// end: } # 4
		}

		// literal: '>' # 3
		consume('>')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: newtype # 0
fn @newtype() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'record' # 3
		consume('record')

		// rule: recordbody # 3
		@recordbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'enum' # 3
		consume('enum')

		// rule: enumbody # 3
		@enumbody()

		// alt: | # 3
	} else if 0 {
		// rule: type # 3
		@type()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: recordbody # 0
fn @recordbody() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// optional: [ # 3
		if opt_3 {
			// rule: typeargs # 4
			@typeargs()

			// end: ] # 4
		}

		// repeat: { # 3
		for repeat_3 {
			// rule: recordentry # 4
			@recordentry()

			// end: } # 4
		}

		// literal: 'end' # 3
		consume('end')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: recordentry # 0
fn @recordentry() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'userdata' # 3
		consume('userdata')

		// alt: | # 3
	} else if 0 {
		// literal: '{' # 3
		consume('{')

		// rule: type # 3
		@type()

		// literal: '}' # 3
		consume('}')

		// alt: | # 3
	} else if 0 {
		// literal: 'type' # 3
		consume('type')

		// rule: Name # 3
		@Name()

		// literal: '=' # 3
		consume('=')

		// rule: newtype # 3
		@newtype()

		// alt: | # 3
	} else if 0 {
		// optional: [ # 3
		if opt_3 {
			// literal: 'metamethod' # 4
			consume('metamethod')

			// end: ] # 4
		}

		// rule: recordkey # 3
		@recordkey()

		// literal: ':' # 3
		consume(':')

		// rule: type # 3
		@type()

		// alt: | # 3
	} else if 0 {
		// literal: 'record' # 3
		consume('record')

		// rule: recordbody # 3
		@recordbody()

		// alt: | # 3
	} else if 0 {
		// literal: 'enum' # 3
		consume('enum')

		// rule: enumbody # 3
		@enumbody()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: recordkey # 0
fn @recordkey() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// alt: | # 3
	} else if 0 {
		// literal: '[' # 3
		consume('[')

		// rule: LiteralString # 3
		@LiteralString()

		// literal: ']' # 3
		consume(']')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: enumbody # 0
fn @enumbody() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// repeat: { # 3
		for repeat_3 {
			// rule: LiteralString # 4
			@LiteralString()

			// end: } # 4
		}

		// literal: 'end' # 3
		consume('end')

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: functiontype # 0
fn @functiontype() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// literal: 'function' # 3
		consume('function')

		// optional: [ # 3
		if opt_3 {
			// rule: typeargs # 4
			@typeargs()

			// end: ] # 4
		}

		// literal: '(' # 3
		consume('(')

		// rule: partypelist # 3
		@partypelist()

		// literal: ')' # 3
		consume(')')

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: retlist # 4
			@retlist()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: partypelist # 0
fn @partypelist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: partype # 3
		@partype()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: partype # 4
			@partype()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: partype # 0
fn @partype() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// optional: [ # 3
		if opt_3 {
			// rule: Name # 4
			@Name()

			// literal: ':' # 4
			consume(':')

			// end: ] # 4
		}

		// rule: type # 3
		@type()

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: parnamelist # 0
fn @parnamelist() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: parname # 3
		@parname()

		// repeat: { # 3
		for repeat_3 {
			// literal: ',' # 4
			consume(',')

			// rule: parname # 4
			@parname()

			// end: } # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}

// rule: parname # 0
fn @parname() bool {
	// assign: := # 1
	// group: ( # 2
	if group_2 {
		// rule: Name # 3
		@Name()

		// optional: [ # 3
		if opt_3 {
			// literal: ':' # 4
			consume(':')

			// rule: type # 4
			@type()

			// end: ] # 4
		}

		// end: ) # 3
	}

	// end: ; # 1

	return false
}
