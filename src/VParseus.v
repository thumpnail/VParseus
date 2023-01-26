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
			mut ebnf_lines := []string{}
			ctx.ast.filename = os.file_name(ctx.args[''][1])
			ebnf_lines << os.read_lines(ctx.args[''][1]) or { panic("Could not read file...")}
			//Finalize //Add token rules for easier parsing
			if 'final' in ctx.args {
				if ctx.args['final'].len > 0 {
					println('Creating finalized ebnf (without tokens)')
					//read the given tokens.ebnf and append to the input.ebnf stream
					ebnf_lines << os.read_lines(ctx.args['final'][0]) or { panic("Could not read file...")}
					ctx.read_ebnf(ebnf_lines)
				} else {
					println('Creating finalized ebnf (with tokens)')
					ctx.read_ebnf(ebnf_lines)
					//Resolve tokens inside input.ebnf and create new rules
					ctx.finalize()
				}
				if 'out' in ctx.args {
					println('Writing to output file')
					if ctx.args['out'].len == 1 {
						os.write_file(ctx.args['out'][0], ctx.get_ebnf(ctx.ast.rules)) or {}
					} else {
						println(ctx.get_ebnf(ctx.ast.rules))
					}
				}
			} else {
				ctx.read_ebnf(ebnf_lines)
			}
			//Export to Json file
			if 'json' in ctx.args {
				//print json to file
				if ctx.args['json'].len == 1 {
					println('Outputting to ${ctx.args['json'][0]}')
					json := json.encode_pretty(ctx.ast)
					os.write_file('${ctx.args[''][1]}.json', json) or { println("Failed to write file") }
				} else {
					println('Outputting to stdout')
					json := json.encode_pretty(ctx.ast)
					println(json)
				}
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
		"\t\t -final \t\textract all literals into their own rules\n"
		"\t\t -final <ebnf file> \textract all literals from the given file into their own rules\n"
		"\t\t -json  \t\tto export to json\n"
		"\t\t -dump  \t\tdump the ebnf document to std out\n"
		"\t\t -gen 	 \t\tgenerate parser\n"
		"\t\t TODO\n"
	]
	for h in help {
		print(h)
	}
}