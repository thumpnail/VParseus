module ebnf

enum SyntaxType {
	unknown
	rule
	group
	repeat
	optional
	literal
	assign
	alt
	end
}
pub struct EbnfDocument {
	pub mut:
	filename string

	raw []string
	rules []SyntaxNode

	literals []string
	keywords []string
	symbols []string
	operators []string
	regex []string
}
struct SyntaxNode {
	pub mut:
	value string
	s_type SyntaxType
	children []SyntaxNode
}
