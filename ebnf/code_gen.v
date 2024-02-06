module ebnf

import os
//Code Generator

pub fn (mut ctx VParseusContext)build() {
	//get literals and then store them in the EbnfDocument
	ctx.ast.filename = os.file_name(ctx.args[''][1]).split('.')[0]
	println('Filename: ${ctx.ast.filename}')

	ctx.ast.symbols, ctx.ast.operators, ctx.ast.keywords, ctx.ast.regex = filter_keywords(get_literals(ctx))

	println(ctx.build_lexer())
	return
}
