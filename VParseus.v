module main
import ebnf
import os
import json
import io
import regex

struct VParseusContext {
	pub mut:
	args map[string][]string
	ast ebnf.EbnfDocument
}
fn main() {
	mut ctx := VParseusContext{}
	if os.args.len > 1 {
		ctx.args = args_to_map(os.args)
		if ctx.args[''].len == 2 { // .\VParseus.exe script.ebnf test.ebnf ...
			ctx.ast = ebnf.read_ebnf(ctx.args[''][1])
			if ctx.args['o'].len == 1 {
				//print json to file
				json := json.encode_pretty(ctx.ast)
				os.write_file(ctx.args['o'][1], json) or { println("Failed to write file") }
			} else {
				//print json to stdout
				json := json.encode_pretty(ctx.ast)
				println(json)
			}
		} else {
			println("Wrong amount of initial arguments!")
			print_help()
			return
		}
	} else {
		ast := ebnf.read_ebnf("script.ebnf")
		println(json.encode_pretty(ast))
	}
}
fn args_to_map(args []string) map[string][]string {
	mut res := map[string][]string{}
	mut last_element := ""
	for i in args {
		if i.starts_with('-') || i.starts_with('/') {
			res[i.substr(1, i.len)] = []string{}
			last_element = i.substr(1, i.len)
		} else {
			res[last_element] << i
		}
	}
	return res
}
fn print_help() {
	help := [
		"usage: VParseus [initial-options] <ebnf file> [options]\n"
		"\t initial-options:\n"
		"\t\t TODO\n"
		"\n"
		"\t options:\n"
		"\t\t TODO\n"
	]
	for h in help {
		print(h)
	}
}
