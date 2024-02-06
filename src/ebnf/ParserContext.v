module ebnf
struct ParserContext {
	mut:
		i int
		array []TokenTuple
	pub mut:
		ast []SyntaxNode
}
fn (mut ctx ParserContext) set(i int) {
	ctx.i = i
}
fn (ctx ParserContext) get() int {
	return i;
}
fn (mut ctx ParserContext) incr() {
	ctx.i++
}
fn (ctx ParserContext) peekc() TokenTuple {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	}
	return ctx.array[ctx.i]
}
fn (ctx ParserContext) peekc_e(expected TokenType) bool {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	}
	if ctx.peekc().item1 == expected {
		return true
	}
	return false
}
fn (ctx ParserContext) peekn() TokenTuple {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	}
	return ctx.array[ctx.i+1]
}
fn (ctx ParserContext) peekn_e(expected TokenType) bool {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	}
	if ctx.peekn().item1 == expected {
		return true
	}
	return false
}
fn (mut ctx ParserContext) consume() TokenTuple {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	}
	return ctx.array[ctx.i++]
}
fn (mut ctx ParserContext) consume_e(expected TokenType) TokenTuple {
	if ctx.i >= ctx.array.len {
		error('Out of Bounds')
	} else if !ctx.peekc_e(expected) {
		error('Expected "$expected" got "${ctx.peekc().item1}"')
	}
	return ctx.array[ctx.i++]
}
