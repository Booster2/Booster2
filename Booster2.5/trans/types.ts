module trans/types

imports

type rules // references

	Input(a) : ty
	where definition of a : ty

	Output(a) : ty
	where definition of a : ty

	PathStart(a, prime) : ty
	where definition of a : ty
	
	Path(path-start, PathComponent(path-component, prime)) : ty
	where definition of path-component : ty
	
	// Path(path-start, path-component) : ty
	// where path-component : ty
	// 
	// // PathComponent gets its 'refers to' only in the context of Path(_,_) so this doesnt work
	// PathComponent(a, prime) : ty
	// where definition of a : ty

	t@This() : ty
	where definition of t : ty

type rules // model refs

	UniDirectional(s) : ty
	where definition of s : ty

	BiDirectional(class, attr): ty
	where definition of class : ty
	
	Optional(s) : ty
	where s : ty
	
	Set(s, mult) : ty
	where s : ty

type rules // primitives are their own type (so that a type-lookup can be done on the AST instead of using the AST itself)

	ty@BasicType(x) : ty
