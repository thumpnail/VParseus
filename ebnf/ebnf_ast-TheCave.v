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
struct EbnfDocument {
	pub mut:
	raw []string
	rules []SyntaxNode
}
struct SyntaxNode {
	pub mut:
	value string
	s_type SyntaxType
	children []SyntaxNode
}