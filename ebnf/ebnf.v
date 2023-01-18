module ebnf
import os
pub struct VParseusContext {
	pub mut:
	args map[string][]string
	ast EbnfDocument
}
pub fn (mut ctx VParseusContext) read_ebnf(filename string) {
	document_lines := os.read_lines(filename) or { panic("Could not read file...")}
	preprocessed := preprocessor(document_lines)
	lexed := lexer(preprocessed)
	ast := parser(lexed)
	ctx.ast = EbnfDocument {
		raw: preprocessed
		rules: ast
	}
}
