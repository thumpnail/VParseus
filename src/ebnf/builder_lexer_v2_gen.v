module ebnf

fn (mut ctx VParseusContext) get_parse_tree_functions() string {
	mut result := ''
	for rule in ctx.ast.rules {
		result += ctx.gen_fn(rule)
	}
	return result
}

fn (mut ctx VParseusContext) gen_fn(rule SyntaxNode) string {
	mut res := 'fn parse_${rule.value}() {'
	// dump(rule)
	mut match_head := false
	for child in rule.children {
		// ':=' // '|' // ';'
		match child.s_type {
			.assign {
				res += '//-assign-'
				if rule.children.len > 2 && rule.children[1].s_type == .alt {
					res += 'match peek() {'
					res += ctx.gen_alt(child)
				} else {
					for item in child.children {
						println('Ping ${item.s_type} ${item.value}')
						match item.s_type {
							.rule {
								res += ctx.gen_rule(item)
							}
							.group {
								res += ctx.gen_grp(item)
							}
							.repeat {
								res += ctx.gen_repeat(item)
							}
							.optional {
								res += ctx.gen_opt(item)
							}
							.literal {
								res += ctx.gen_literal(item)
							}
							.alt {
								// TODO: One time match header
								res += ctx.gen_alt(item)
							}
							else {
								error('Expected <rule>, <group>, <repeat>, <optional>, <literal> or <alternative>')
							}
						}
					}
				}
			}
			.alt {
				res += '//-alt Header'
				res += ctx.gen_alt(child)
			}
			.end {
				if rule.children.len > 2 && rule.children[1].s_type == .alt {
					res += "else {error('expected ${rule.value}')}"
					res += '}'
				}
				res += '//-end-'
			}
			else {
				panic('Parser: Wrong token Type')
			}
		}
		res += ''
	}
	return res + '}'
}

fn (mut ctx VParseusContext) gen_alt(rule SyntaxNode) string {
	mut res := '
		${rule.children[0].value} {
			${ctx.gen_literal(rule.children[0])}
		}'
	return res
}

fn (mut ctx VParseusContext) gen_rule(rule SyntaxNode) string {
	mut res := ''
	res += '${rule.value}()'
	res += ''
	return res
}

fn (mut ctx VParseusContext) gen_opt(rule SyntaxNode) string {
	mut res := ''
	return 'gen_opt'
}

fn (mut ctx VParseusContext) gen_grp(rule SyntaxNode) string {
	return 'gen_grp'
}

fn (mut ctx VParseusContext) gen_repeat(rule SyntaxNode) string {
	return 'gen_repeat'
}

fn (mut ctx VParseusContext) gen_literal(rule SyntaxNode) string {
	match rule.s_type {
		.literal { return 'consume(${rule.value})' }
		.rule { return '${rule.value}()' }
		else { return "consume('${rule.value}')" }
	}
}
