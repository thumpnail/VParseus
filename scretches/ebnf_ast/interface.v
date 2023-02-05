module ebnf_ast

type Node = RuleStatement | RuleExpression
interface RuleStatement {
	raw string
	nodes []RuleExpression
	gen_src() string
}
interface RuleExpression {
	raw string
	gen_src() string
}
