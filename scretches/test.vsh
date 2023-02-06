fn test_bool_or() !bool {
	return error('bla')
}
test_bool_or() or { println('worked')}
