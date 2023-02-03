module ebnf

import os
//Code Generator

pub fn (mut ctx VParseusContext)build() {
	//get literals and then store them in the EbnfDocument
	// also the name of the module
	ctx.ast.filename = os.file_name(ctx.args[''][1]).split('.')[0]
	println('building lexer')
	if ctx.args['gen'].len == 1 {
		ctx.ast.filename = ctx.args['gen'][0]
		os.mkdir(ctx.ast.filename) or {println('Failed Creating Dir')}
		os.write_file(ctx.args['gen'][0]+'\\'+ctx.args['gen'][0] + '_lex.v', ctx.build_lexer_v2()) or {println('failed writing code gen file')}
	} else {
		os.mkdir(ctx.ast.filename) or {println('Failed Creating Dir')}
		os.write_file(ctx.ast.filename+'\\'+ctx.ast.filename + '_lex.v', ctx.build_lexer_v2()) or {println('failed writing code gen file')}
	}
	println('code_gen is still WIP')
	return
}
