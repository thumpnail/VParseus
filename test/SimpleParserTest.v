module main

fn main() {
	println('Hello World!')
	parser := ParseLib{
		rules_map: {
			'start': ['{','stat','}']
			'stat': ['datadecl','|','assign','|','decl']
			'datadecl': ['tk_data','identifier','tk_braces_open','decl','tk_braces_close']
			'assign': ['identifier','[','tk_colon','type',']','tk_colon_equals','expr']
			'decl': ['identifier','[','tk_colon','type',']']
			'expr': ['expr','|','expr','tk_plus','expr','|','expr','tk_asterisk','expr','|','expr','tk_plus_plus','|','expr','tk_minus_minus','|','number']
			'exprlist': ['expr','{','tk_comma','expr','}']
			'identifier': ['letter','{','letter','|','digit','}']
			'number': ['[','tk_minus',']','{','digit','}']
			'type': ['tk_number','|','tk_string']
		}
		literals_map: {
			'digit': ['0123456789']
			'letter': ['abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ']
			'tk_braces_open': ['{']
			'tk_braces_close': ['}']
			'tk_colon': [':']
			'tk_colon_equals': [':=']
			'tk_plus': ['+']
			'tk_asterisk': ['*']
			'tk_plus_plus': ['++']
			'tk_minus_minus': ['--']
			'tk_comma': [',']
			'tk_minus': ['-']
			'tk_underscore': ['_']
			'tk_data': ['data']
			'tk_number': ['number']
			'tk_string': ['string']
			'tk_keyword': ['data','number','string']
		}
	}
	code := ["test = 12","test2 = 4 + 3"]
	out := lexer(preprocessor(code))
	dump(out)
}
