module main
import ebnf
import os

fn main() {
	dump(ebnf.read_ebnf("script.ebnf"))
}