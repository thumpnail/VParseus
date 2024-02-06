module ebnf
struct ArrayReader[T] {
	mut:
		array []T
		i int
}
fn (mut ar ArrayReader[T]) set(i int) {
	ar.i = i
}
fn (ar ArrayReader[T]) get() int {
	return i;
}
fn (mut ar ArrayReader[T]) incr() {
	ar.i++
}
fn (ar ArrayReader[T]) peekc() T {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	}
	return ar.array[ar.i]
}
fn (ar ArrayReader[T]) peekc_e(expected T) bool {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	}
	return false
}
fn (ar ArrayReader[T]) peekn() T {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	}
	return ar.array[ar.i+1]
}
fn (ar ArrayReader[T]) peekn_e(expected T) bool {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	}
	return false
}
fn (mut ar ArrayReader[T]) consume() bool {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	}
	ar.i++
}
fn (mut ar ArrayReader[T]) consume(expected T) bool {
	if ar.i >= ar.array.len {
		error('Out of Bounds')
	} else if !ar.peekc_e(expected) {
		return false
	}
	ar.i++
	return true
}
