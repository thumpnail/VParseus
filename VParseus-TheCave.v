module main
import ebnf
import os
import json

fn main() {
	ast := ebnf.read_ebnf("script.ebnf")
	println(json.encode_pretty(ast))
}