module main

pub enum Token {
	unknown
}

struct ParseLib {
	pub mut:
		// e.g. anything rule := subrule { subrule2 } ;
		rules_map map[string][]string
		// e.g. tk_*
		literals_map map[string][]string
}
