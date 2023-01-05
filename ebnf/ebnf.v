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
	preprocessed := preprocessor(document_lines)
	lexed := lexer(preprocessed)
	for item in lexed {
		println("${item.item1} : ${item.item2}")
		if item.item2 == ";" {
			println("")
		}
	}
	return EbnfDocument {
		raw: preprocessed
	}
}