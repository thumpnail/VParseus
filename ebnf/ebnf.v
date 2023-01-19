module ebnf
import os
pub struct VParseusContext {
	pub mut:
	args map[string][]string
	ast EbnfDocument
}
pub fn (mut ctx VParseusContext) read_ebnf(lines []string) {
	document_lines := lines
	preprocessed := preprocessor(document_lines)
	lexed := lexer(preprocessed)
	ast := parser(lexed)
	ctx.ast = EbnfDocument {
		raw: preprocessed
		rules: ast
	}
}
