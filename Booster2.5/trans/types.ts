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

relations // sub typing

	define transitive <sub:
	
	BasicType(Int()) <sub: BasicType(Decimal())

type rules // sub typing

	Class(c,extends,members):-
	where store Null() <sub: c

type rules // BasicValue

	BasicValue(True())             : BasicType(Boolean())
	BasicValue(False())            : BasicType(Boolean())
	BasicValue(CurrentDate())      : BasicType(Date())
	BasicValue(CurrentDateTime())  : BasicType(DateTime())
	BasicValue(Decimal(i))         : BasicType(Decimal())
	BasicValue(Integer(i))         : BasicType(Int())
	// BasicValue(String(i))          : BasicType(Password())
	BasicValue(String(i))          : BasicType(String())
	BasicValue(CurrentTime())      : BasicType(Time())
	
	Null()                         : Null()

type rules // BinRel, BinOp, UnOp

  BinRel(l, op@Equal(), r)
+ BinRel(l, op@NotEqual(), r)
+ BinRel(l, op@In(), r)
+ BinRel(l, op@NotIn(), r) 
+ BinRel(l, op@Subset(), r) 
+ BinRel(l, op@SubsetEquals(), r) 
+ BinRel(l, op@Superset(), r) 
+ BinRel(l, op@SupersetEquals(), r) : BasicType(Boolean())
	where	l	: l-ty
		and	r	: r-ty
		and	(r-ty == l-ty or r-ty <sub: l-ty) 
		      else error $[Type mismatch: expected [l-ty] got [r-ty] in [op]] on r

  BinRel(l, op@LessThan(), r)
+ BinRel(l, op@LessThanEquals(), r)
+ BinRel(l, op@GreaterThan(), r)
+ BinRel(l, op@GreaterThanEquals(), r) : BasicType(Boolean())
	where	l	: l-ty
		and	r	: r-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [l-ty] in [op]] on l
		and	(r-ty == l-ty or r-ty <sub: l-ty or l-ty <sub: r-ty) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty] in [op]] on r

  BinOp(l, op@Plus(), r)
+ BinOp(l, op@Minus(), r)
+ BinOp(l, op@Times(), r)
+ BinOp(l, op@Divide(), r) 
+ BinOp(l, op@Maximum(), r) 
+ BinOp(l, op@Minimum(), r) : op-ty
	where	l	: l-ty
		and	r	: r-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [l-ty] in [op]] on l
		and	((r-ty ==    l-ty and l-ty => op-ty) or
		     (r-ty <sub: l-ty and l-ty => op-ty) or
				 (l-ty <sub: r-ty and r-ty => op-ty)) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty] in [op]] on r
	
	// Note r is a newly defined variable with the type of l so r-ty == l-ty (but it is defined at the level at BinOpDefRightInput, so we cannot query it)
  BinOpDefRightInput(l, op@Plus(), r)
+ BinOpDefRightInput(l, op@Minus(), r)
+ BinOpDefRightInput(l, op@Times(), r)
+ BinOpDefRightInput(l, op@Divide(), r)
+ BinOpDefRightInput(l, op@Maximum(), r)
+ BinOpDefRightInput(l, op@Minimum(), r): l-ty
	where l : l-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [l-ty] in [op]] on l

  BinOp(l, op@Intersection(), r)
+ BinOp(l, op@Union(), r)
+ BinOp(l, op@Concat(), r) : l-ty
	where	l	: l-ty
		and	r	: r-ty
		and	r-ty == l-ty else error $[Type mismatch: expected [l-ty] got [r-ty] in [op]] on r
	
	UnOp(Head(), e)	
+ UnOp(Tail(), e): e-ty
	where e : e-ty
	
  UnOp(Cardinality(), e): BasicType(Int())
  
  UnOp(op@Negative(), e): e-ty
	where e : e-ty
    and	(e-ty == BasicType(Decimal()) or 
		     e-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [e-ty] in [op]] on e
