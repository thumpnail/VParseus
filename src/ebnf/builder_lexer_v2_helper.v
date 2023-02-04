module ebnf

fn (mut ctx VParseusContext) get_tokens() string {
	mut result := '\n\tunknown\n\t'
	for key in ctx.ast.rules {
		if key.children.len == 2 && key.children[0].children.len == 1
		&& key.children[0].children[0].s_type == .literal {
			result += key.value + '\n\t'
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_symbol_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1
		&& rule.children[0].children[0].s_type == .literal
		&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.symbols {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_keyword_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		syntax_rules := rule.children[0].children
		if rule.children.len == 2 && syntax_rules.len == 1 && syntax_rules[0].s_type == .literal
		&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.keywords && rule_value.len > 2 {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_operator_map() string {
	mut result := ''
	for rule in ctx.ast.rules {
		rule_value, rule_name := rule.children[0].children[0].value, rule.value
		if rule.children.len == 2 && rule.children[0].children.len == 1
		&& rule.children[0].children[0].s_type == .literal
		&& rule_value.substr(1, rule_value.len - 1) in ctx.ast.operators {
			result += '\n\t\t${rule_value}: ' + 'TokenType.' + rule_name
		}
	}
	return result
}

fn (mut ctx VParseusContext) get_comment_symbol() string {
	return '#'
}

fn (mut ctx VParseusContext) get_symbol_list() string {
	mut result := ''
	for key in ctx.ast.symbols {
		result += "'${key}',"
	}
	return result.substr(0, result.len - 1)
}

fn (mut ctx VParseusContext) get_operator_list() string {
	mut result := ''
	for key in ctx.ast.operators {
		result += "'${key}',"
	}
	return result.substr(0, result.len - 1)
}

fn (mut ctx VParseusContext) get_char_arrays() string {
	prefix := '\tall_'
	mut result := ''
	for rule in ctx.ast.rules {
		println('max depth(${rule.value}): ${rule.children[0].get_depth()}')
		if rule.children.len > 2 && rule.children[0].get_depth() == 2
		&& rule.enforce_type(.literal) == 0 {
			result += '${prefix + rule.value} = [\n\t\t'
			for i in rule.get_literals() {
				result += '${i},'
			}
			result += '\n\t]\n'
		}
	}
	return result
}
