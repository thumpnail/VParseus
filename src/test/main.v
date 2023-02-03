module main

fn main() {
	src := ["Hello := 12","hello2 := 12 * 3"]
	out := lexer(preprocessor(src))
	dump(out)
}