[translated]
module main

/*!*/[weak] __global ( LBRACKET  = i8 (`[`)
)

/*!*/[weak] __global ( RBRACKET  = i8 (`]`)
)

/*!*/[weak] __global ( LPAREN  = i8 (`(`)
)

/*!*/[weak] __global ( RPAREN  = i8 (`)`)
)

/*!*/[weak] __global ( LBRACE  = i8 (`{`)
)

/*!*/[weak] __global ( RBRACE  = i8 (`}`)
)

/*!*/[weak] __global ( ASSIGN  = i8 (`=`)
)

/*!*/[weak] __global ( OR  = i8 (`|`)
)

/*!*/[weak] __global ( SPACE  = i8 (` `)
)

struct Token { 
	typ int
	val &i8
}
fn lex(input &i8, tokens &&Token, n &int)  {
	i := 0
	start := 0
	*n = 0
	for i = 0 ; input [i]  ; i ++ {
		if input [i]  == LBRACKET || input [i]  == RBRACKET || input [i]  == LPAREN || input [i]  == RPAREN || input [i]  == LBRACE || input [i]  == RBRACE || input [i]  == ASSIGN || input [i]  == OR || input [i]  == SPACE {
			if start < i {
				(*tokens) [*n] .typ = input [start] 
				(*tokens) [*n] .val = strndup(input + start, i - start)
				(*n) ++
			}
			start = i + 1
		}
	}
	if start < i {
		(*tokens) [*n] .typ = input [start] 
		(*tokens) [*n] .val = strndup(input + start, i - start)
		(*n) ++
	}
}

fn strndup( &i8,  i64) &i8

fn main()  {
	input := c"a := \"alpha\" | a a a | ( b | b | b ) | { c c c } | [ d d d ] ; b := \"beta\" | '[0-9]+' [ \".\" '[0-9]+' ]; c := \"gamma\" | '\\w+' { '[0-9]+' }; d := \"delta\";"
	tokens := C.malloc(1000 * sizeof(Token))
	n := 0
	lex(input, &tokens, &n)
	for i := 0 ; i < n ; i ++ {
		C.printf(c'%s\n', tokens [i] .val)
	}
	return 
}

