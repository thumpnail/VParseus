module ebnf
import regex
import os
//Code Generator

pub fn (mut ctx VParseusContext)build() {
	//get literals and then store them in the EbnfDocument
	ctx.ast.filename = os.file_name(ctx.args[''][1]).split('.')[0]
	println('Filename: ${ctx.ast.filename}')

	dump(ctx)

	ctx.ast.symbols, ctx.ast.operators, ctx.ast.keywords, ctx.ast.regex = filter_keywords(get_literals(ctx))
	return
}
fn (mut ctx VParseusContext)build_preprocessor(node SyntaxNode) string
fn (mut ctx VParseusContext)build_lexer(node SyntaxNode) string
fn (mut ctx VParseusContext)build_parser(node SyntaxNode) string
fn (mut ctx VParseusContext)build_ast_structure(node SyntaxNode) string

// Helper

fn get_literals(ctx VParseusContext) []string {
	mut result := []string{}
	for node in ctx.ast.rules {
		result << get_literal_rec(node)
	}
	return result
}
fn get_literal_rec(node SyntaxNode) []string {
	mut result := []string{}
	for item in node.children {
		if item.s_type == .literal {
			result << item.value
		}
		result << get_literal_rec(item)
	}
	return result
}
fn filter_keywords(literals []string) ([]string, []string, []string, []string) {
	mut arr_symbols,mut arr_operators, mut arr_keywords, mut arr_regex:= []string{}, []string{}, []string{}, []string{}
	mut key2 := ""
	for key in literals {
		if key.starts_with('\'') && key.ends_with('\'') {
			key2 = key.substr(1,key.len-1)
		} else {
			key2 = key
		}
		if ((key2.starts_with('[') && key2.ends_with(']')) || (key2.starts_with('(') && key2.ends_with(')')) || (key2.starts_with('{') && key2.ends_with('}'))) || ((key2.starts_with('[') && key2.ends_with(']+')) || (key2.starts_with('(') && key2.ends_with(')+')) || (key2.starts_with('{') && key2.ends_with('}+'))) || ((key2.starts_with('[') && key2.ends_with(']*')) || (key2.starts_with('(') && key2.ends_with(')*')) || (key2.starts_with('{') && key2.ends_with('}*'))) || ((key2.starts_with('[') && key2.ends_with(']~')) || (key2.starts_with('(') && key2.ends_with(')~')) || (key2.starts_with('{') && key2.ends_with('}~'))) {
			add_unique(key2, mut arr_regex)
		} else if key2.contains_any('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW0123456789') {
			add_unique(key2,mut arr_keywords)
		} else if key2.contains_any_substr(['^','°','!','"','§','$','%','&&','/','(',')','=','?','`','{','[',']','}','\\','\´','+','#','*','\'','~',',','.','-',';',':','_','<','>','||']) {
			if !arr_regex.contains(key2) {
				add_unique(key2, mut arr_symbols)
			}
			if key2.len > 1 {
				for c in key2 {
					add_unique("${c.ascii_str()}", mut arr_operators)
				}
			} else {
				add_unique(key2, mut arr_operators)
			}
		}
	}
	return arr_symbols, arr_operators, arr_keywords, arr_regex
}
fn add_unique(str string, mut arr []string) {
	if !array_contains(str, arr) {
		arr << str
	}
}
