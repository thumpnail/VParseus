module ebnf
import os

struct RuleElement {

}
struct Rule {
	children []RuleElement
}
struct EbnfDocument {
	raw []string
	rules []Rule
}
pub fn read_ebnf(filename string) EbnfDocument {
	document_lines := os.read_lines(filename) or { panic("Could not read file...")}
	lexed := preprocessor(document_lines)
	for item in lexed {
		println("${item}")
	}
	return EbnfDocument{
		raw: lexed
	}
}