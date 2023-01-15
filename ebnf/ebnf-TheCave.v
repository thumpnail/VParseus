module ebnf
import os

pub fn read_ebnf(filename string) EbnfDocument {
	document_lines := os.read_lines(filename) or { panic("Could not read file...")}
	preprocessed := preprocessor(document_lines)
	lexed := lexer(preprocessed)
	ast := parser(lexed)
	return EbnfDocument {
		raw: preprocessed
		rules: ast
	}
}
