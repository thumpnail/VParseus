module ebnf_ast

struct Rule {
	raw string
	nodes []RuleExpression
}
fn (r &Rule) gen_src() string {
	panic('not implemented')
}
struct Alternative {
	raw string
	nodes []RuleExpression
}

fn (a &Alternative) gen_src() string {
	panic('not implemented')
}
struct Repeat {
	raw string
	nodes []RuleExpression
}

fn (r &Repeat) gen_src() string {
	panic('not implemented')
}
struct Group {
	raw string
	nodes []RuleExpression
}

fn (g &Group) gen_src() string {
	panic('not implemented')
}
