module ebnf
import json
struct ParserContext {
	pub mut:
	i int
	t_list []TokenTuple
	rules []SyntaxNode
}
// prgm := { name '=' { exp } } name;
// exp := number | exp '+' exp | exp '*' exp;
// name := "A" | "B" | "C";

fn parser(tokenTuple []TokenTuple) []SyntaxNode { // []SyntaxNode <- list of rules
	mut stk := []SyntaxNode{} // stack for a subrule
	mut ast := []SyntaxNode{} // [Rule1,Rule2,Rule3,...]
	for idx in tokenTuple {
		match idx.item1 {
			.rule {
				stk << SyntaxNode{value: idx.item2, s_type: .rule, children: []}
			}
			.assign { // create Rule and add a Subrule
				add_rule(mut ast, stk.pop())
				add_subrule(mut ast, SyntaxNode{ value: idx.item2, s_type: .assign, children: []SyntaxNode{} })
			}
			.literal {
				stk << SyntaxNode{value: idx.item2, s_type: .literal, children: []}
			}
			.end {
				//TODO: alt cleanup
				//Add all stack items in correct order

				add_item_m(mut ast, stk)
				stk.clear()
				add_subrule(mut ast,(SyntaxNode{value: idx.item2, s_type: .end, children: []}))
			}
			.opt_open {
				stk << SyntaxNode{
					value: '['
					s_type: .optional
					children: []
				}
			}
			.opt_close {
				mut tmp := []SyntaxNode{}
				//TODO: alt cleanup
				if contains_stype_in_group(.alt, stk) {
					for stk.len > 0 && !is_group(stk.last().s_type) && stk.last().s_type != .alt {
						tmp << stk.pop()
					}
					tmp.reverse_in_place()
					stk.last().children << SyntaxNode{
						value: 'subgroup'
						s_type: .group
						children: tmp
					}
					tmp = []SyntaxNode{}
				}
				for stk.len > 0 && stk.last().s_type != .optional {
					tmp << stk.pop()
				}
				tmp.reverse_in_place()
				if stk.last().s_type == .optional {
					stk.last().children << tmp
				} else {
					dump(stk)
					panic("No Optional")
				}
			}
			.opt_repeat_open {
				stk << SyntaxNode{
					value: '{'
					s_type: .repeat
					children: []
				}
			}
			.opt_repeat_close {
				//TODO: alt cleanup
				mut tmp := []SyntaxNode{}
				if contains_stype_in_group(.alt, stk) {
					for stk.len > 0 && !is_group(stk.last().s_type) && stk.last().s_type != .alt {
						tmp << stk.pop()
					}
					tmp.reverse_in_place()
					stk.last().children << SyntaxNode{
						value: 'subgroup'
						s_type: .group
						children: tmp
					}
					tmp = []SyntaxNode{}
				}
				for stk.len > 0 && stk.last().s_type != .repeat {
					tmp << stk.pop()
				}
				tmp.reverse_in_place()
				if stk.last().s_type == .repeat {
					stk.last().children << tmp
				} else {
					dump(stk)
					panic("No Repeat")
				}
			}
			.group_open {
				stk << SyntaxNode{
					value: '('
					s_type: .group
					children: []
				}
			}
			.group_close {
				//TODO: alt cleanup
				mut tmp := []SyntaxNode{}
				if contains_stype_in_group(.alt, stk) {
					for stk.len > 0 && !is_group(stk.last().s_type) && stk.last().s_type != .alt {
						tmp << stk.pop()
					}
					tmp.reverse_in_place()
					stk.last().children << SyntaxNode{
						value: 'subgroup'
						s_type: .group
						children: tmp
					}
					tmp = []SyntaxNode{}
				}
				for stk.len > 0 && stk.last().s_type != .group {
					tmp << stk.pop()
				}
				tmp.reverse_in_place()
				if stk.last().s_type == .group {
					stk.last().children << tmp
				} else {
					dump(stk)
					panic("No Group")
				}
			}
			.alt {
				mut tmp := []SyntaxNode{}
				for stk.len > 0 && !is_group(stk.last().s_type) && stk.last().s_type != .alt {
					tmp << stk.pop()
				}
				tmp.reverse_in_place()
				if stk.len == 0 {
					stk << SyntaxNode{
						value: 'alt'
						s_type: .alt
						children: [SyntaxNode{
							value: 'subgroup'
							s_type: .group
							children: tmp
						}]
					}
				} else if stk.last().s_type != .alt {
					stk << SyntaxNode{
						value: 'alt'
						s_type: .alt
						children: [SyntaxNode{
							value: 'subgroup'
							s_type: .group
							children: tmp
						}]
					}
				} else {
					stk.last().children << SyntaxNode{
						value: 'subgroup'
						s_type: .group
						children: tmp
					}
				}
			}
			else {
				panic("not implemented")
			}
		}
	}
	println(json.encode(ast))
	return ast
}
fn add_rule(mut ast []SyntaxNode, node SyntaxNode) {
	ast << node
}
fn add_subrule(mut ast []SyntaxNode, node SyntaxNode) {
	ast.last().children << node
}
fn add_item(mut ast []SyntaxNode, node SyntaxNode) {
	ast.last().children.last().children << node
}
fn add_item_m(mut ast []SyntaxNode, nodes []SyntaxNode) {
	ast.last().children.last().children << nodes
}
fn create_item(mut ast []SyntaxNode, nodes []SyntaxNode) {

}
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
