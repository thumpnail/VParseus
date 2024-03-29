module main
import ebnf
import os
import json

fn main() {
	mut ctx := ebnf.VParseusContext{}
	if os.args.len > 1 {
		ctx.args = args_to_map(os.args)
		if ctx.args[''].len == 2 { // .\VParseus.exe script.ebnf ...
			println('Reading')
			ctx.ast.filename = os.file_name(ctx.args[''][1])
			ctx.read_ebnf(ctx.args[''][1])
			//Finalize
			if 'final' in ctx.args {
				println('Creating finalized ebnf (with tokens)')
				ctx.finalize(ctx.args[''][1], ctx.args['final'][0])
			}
			//Export to Json file
			if 'json' in ctx.args {
				//print json to file
				println('Outputting to ${ctx.args[''][1]}.json')
				json := json.encode_pretty(ctx.ast)
				os.write_file('${ctx.args[''][1]}.json', json) or { println("Failed to write file") }
			}
			//Dump out to stdout
			if 'dump' in ctx.args {
				//print json to file
				println('Dumping to stdout')
				dump(ctx.ast)
			}
			//Generate parser
			if 'gen' in ctx.args {
				println('Generating code')
				ctx.build()
			}
		} else {
			println("Wrong amount of arguments!")
			print_help()
			return
		}
	} else {
		println("Wrong amount of arguments!")
		print_help()
		return
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
		"usage: VParseus <ebnf file> [options]\n"
		"\t options:\n"
		"\t\t -final -> extract all literals into their own rules\n"
		"\t\t -json -> to export to json\n"
		"\t\t -dump -> dump the ebnf document to std out\n"
		"\t\t -gen 	-> generate parser\n"
		"\t\t TODO\n"
	]
	for h in help {
		print(h)
	}
}
