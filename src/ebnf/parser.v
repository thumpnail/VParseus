module ebnf
import json

// prgm := { name '=' { exp } } name;
// exp := number | exp '+' exp | exp '*' exp;
// name := "A" | "B" | "C";

fn parse(tokenTuple []TokenTuple) []SyntaxNode { // []SyntaxNode <- list of rules
	mut ctx := ParserContext{ar: ArrayReader{}, ast: []}
	return ctx.ast
}
fn (mut ctx ParserContext) parse_group() SyntaxNode
fn (mut ctx ParserContext) parse_optional() SyntaxNode
fn (mut ctx ParserContext) parse_repeat() SyntaxNode
fn (mut ctx ParserContext) parse_rule() SyntaxNode {
	mut rule := SyntaxNode{}
	ctx.consume_e(.rule)
	ctx.consume_e(.assign)
	ctx.parse_expression()
	ctx.consume_e(.end)
}
fn (mut ctx ParserContext) parse_expression() []SyntaxNode {
	mut res := []SyntaxNode{}
	for ctx.peekc_e(.rule) || ctx.peekc_e(.literal) {
		tmp := ctx.consume()
		res << SyntaxNode{
			value: tmp.item2
			s_type: tmp.item1
			children: []
		}
	}
	return res
}
fn (mut ctx ParserContext) parse_factor() SyntaxNode

fn is_group(val SyntaxType) bool {
	if val == .group || val == .optional || val == .repeat {
		return true
	}
	return false
}
fn contains_stype_in_group(val SyntaxType, arr []SyntaxNode) bool {
	for i := arr.len-1; i >= 0; i-- {
		if !is_group(arr[i].s_type) {
			if arr[i].s_type == val {
				return true
			}
		} else {
			return false
		}
	}
	return false
}
fn collapse_until(val SyntaxType) {}
