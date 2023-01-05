module main
import ebnf

fn main() {
	dump(ebnf.read_ebnf("script.ebnf"))
}