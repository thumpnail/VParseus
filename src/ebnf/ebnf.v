module ebnf

pub struct VParseusContext {
	pub mut:
	args map[string][]string
	ast EbnfDocument
	//
}
pub fn (mut ctx VParseusContext) read_ebnf(lines []string) {
	document_lines := lines.clone()
	preprocessed := preprocessor(document_lines)
	lexed := lexer(preprocessed)
	ast := parser(lexed)
	ctx.ast.raw, ctx.ast.rules = preprocessed, ast
	ctx.ast.literals = get_literals(ctx)
	ctx.ast.operators, ctx.ast.symbols, ctx.ast.keywords, ctx.ast.regex = filter_keywords(ctx.ast.literals)
}
