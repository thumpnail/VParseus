module main

import regex
import os

fn main() {
	ctx := ParserContext {
		tokens: []
	}
	entry()
}

struct ParserContext {
	pub:
	tokens []TokenTuple
	mut:
	idx int
}

// // entry := { stat };
fn (mut ctx ParserContext) entry() { // entry :=
	for { // {
		ctx.stat() // stat
	} // }
} // ;

// stat := data_decl
// | assign
// | decl;
fn (mut ctx ParserContext) stat() { // stat :=
	match stat_type {
		.data_decl { // data_decl
			ctx.data_decl()
		}
		.assign { // | assign
			ctx.assign()
		}
		.decl { // | decl
			ctx.decl()
		}
		else {
			// ERROR: expected stat
		}
	} // ...
} // ;

// data_decl := 'data' identifier '{' { decl } '}';
fn (mut ctx ParserContext) data_decl() { // data_decl :=
	ctx.consume('data') // 'data'
	ctx.identifier()  // identifier
	ctx.consume('{') // '{'
	for { // {
		ctx.decl()  // decl
	} // }
	ctx.consume('}') // '}'
} // ;

// assign := identifier [ ':' type ] ':=' expr;
fn (mut ctx ParserContext) assign() { // assign :=
	ctx.identifier() // identifier
	if ctx.peek() == ':' { // [
		ctx.consume(':')
		ctx.type_rule() // type
	} // ]
	ctx.consume(':=') // ':='
	ctx.expr() // expr
} // ;

// decl := identifier [ ':' type | '->' '(' (  type { ',' type } ) ')' ]
fn (mut ctx ParserContext) decl() {
	ctx.identifier()
	if ctx.peek() == ':' {
		ctx.consume(':')
		ctx.@type()
	} else if ctx.peek() == '->' {
		ctx.consume('->')
		ctx.consume('(')
		ctx.@type()
		for ctx.peek() == ',' {
			ctx.@type()
		}
		ctx.consume(')')
	}
}

// identifier := "[a-zA-Z_0-9]"
fn (mut ctx ParserContext) identifier() {
	ctx.consume('[a-zA-Z_0-9]+')
}

// type := number | string | any | identifier;
fn (mut ctx ParserContext) @type() {
	if ctx.number() {

	} else if ctx.@string() {

	} else if ctx.any() {

	} else if ctx.identifier() {

	}
}

// exprlist := expr { ',' expr };
fn (mut ctx ParserContext) exprlist() {
	ctx.consume(ctx.expr.str())
	for {
		ctx.consume(',')
		ctx.expr()
	}
}

// expr := expr | expr '+' expr | expr '*' expr | number;
fn (mut ctx ParserContext) expr() {
	ctx.expr()
	match ctx.peek() {
		'+' {
			ctx.expr()
		}
		'*' {
			ctx.expr()
		}
		else {
			ctx.number()
		}
	}
}

// number := ['-'] "[0-9]+"
fn (mut ctx ParserContext) number() {
	if ctx.peek() == '-' {
		ctx.consume('-')
	}
	ctx.consume('[0-9]+').int
}

fn (mut ctx ParserContext) consume(value string) bool {
	nxt := value
	if rgx := regex.regex_base(value) {
		// is regex
		return true
	} else if ctx.peek() == value {
		ctx.next()
		return true
	}
	panic('Expected ${value} got ${nxt}')
}
fn (mut ctx ParserContext) peek() string {
	return ctx.tokens[ctx.idx + 1]
}

fn (mut ctx ParserContext) next() string {
	return ctx.tokens[ctx.idx++]
}
