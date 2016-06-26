module trans/types

imports

	signatures/-
	trans/desugar
	src-gen/names/names
	trans/names-manual
  	trans/types-manual
	
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
	
	Param(a) : ty
	where definition of a : ty

type rules // model refs

	UniDirectional(s) : ty
	where definition of s : ty

	BiDirectional(class, attr): ty
	where definition of class : ty
	
	Optional(s) : ty
	where s : ty
	
	Set(s, mult) : Set(ty)
	where s : ty
	
	TypeExtent(ty) : Set(BasicType(ty))
	
	SetExtent([a]) : Set(a-ty)
	where a : a-ty
	
type rules // helpers

	TypeIsASet(a) : ty
	where a : a-ty
	  and(   (a-ty => Set(a-elem-ty) and a-ty => ty)
	      or (Set(a-ty) => ty)
	  )

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
	SetExtent([])                  : Null()

type rules // BinRel, BinOp, UnOp


	Equal(l,r)
+ Assign(l,r)
+ NotEqual(l,r)
+ Subset(l,r)
+ SubsetEquals(l,r)
+ Superset(l,r)
+ SupersetEquals(l,r) : BasicType(Boolean())
	where	l	: l-ty
		and	r	: r-ty
		and	(r-ty == l-ty or r-ty <sub: l-ty) 
		      else error $[Type mismatch: expected [l-ty] got [r-ty]] on r

	// Note v is a newly defined variable with the type of e so v-ty == e-ty (but it is defined at the level at BinOpDefRightInput, so we cannot query it)
  Def(v, e, Equal(), leftright, inout, setext)
+ Def(v, e, Assign(), leftright, inout, setext)
+ Def(v, e, NotEqual(), leftright, inout, setext): BasicType(Boolean())
	where e : e-ty

  Def(v, e, Subset(), leftright, inout, setext) 
+ Def(v, e, SubsetEquals(), leftright, inout, setext)
+ Def(v, e, Superset(), leftright, inout, setext)
+ Def(v, e, SupersetEquals(), leftright, inout, setext) : BasicType(Boolean())
	where e : e-ty
	and (e-ty => Set(a-ty))
		else error $[Type mismatch: expected set type, got [e-ty]] on e

		      
  In(l, r)
+ NotIn(l, r) : BasicType(Boolean())
	where	l	: l-ty
		and	r	: r-set-ty
		and r-set-ty => Set(r-ty)
		and	(r-ty == l-ty or r-ty <sub: l-ty) 
		      else error $[Type mismatch: expected [Set(l-ty)] got [r-ty]] on r

  Def(v, e, In(), Left(), inout, setext) 
+ Def(v, e, NotIn(), Left(), inout, setext) : BasicType(Boolean())
	where e : e-ty
	and (e-ty => Set(a-ty))
		else error $[Type mismatch: expected set type, got [e-ty]] on e

  Def(v, e, In(), Right(), inout, setext) 
+ Def(v, e, NotIn(), Right(), inout, setext) : BasicType(Boolean())
	where e : e-ty
	and not(e-ty => Set(a-ty))
		else error $[Type mismatch: expected non-set type, got [e-ty]] on e


  LessThan(l, r)
+ LessThanEquals(l, r)
+ GreaterThan(l, r)
+ GreaterThanEquals(l, r) : BasicType(Boolean())
	where	l	: l-ty
		and	r	: r-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [l-ty]] on l
		and	(r-ty == l-ty or r-ty <sub: l-ty or l-ty <sub: r-ty) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty]] on r


  Def(v, e, LessThan(), leftright, inout, setext) 
+ Def(v, e, LessThanEquals(), leftright, inout, setext) 
+ Def(v, e, GreaterThan(), leftright, inout, setext)
+ Def(v, e, GreaterThanEquals(), leftright, inout, setext) : BasicType(Boolean())
	where e : e-ty
	and (e-ty == BasicType(Decimal()) or
			(e-ty == BasicType(Int())))
		else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [e-ty]] on e



  Plus(l, r)
+ Times(l, r)
+ Divide(l, r) 
+ Maximum(l, r) 
+ Minimum(l, r) : op-ty
	where	l	: l-ty
		and	r	: r-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [l-ty]] on l
		and	((r-ty ==    l-ty and l-ty => op-ty) or
		     (r-ty <sub: l-ty and l-ty => op-ty) or
				 (l-ty <sub: r-ty and r-ty => op-ty)) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty]] on r

  Def(v, e, Plus(), leftright, inout, setext) 
+ Def(v, e, Time(), leftright, inout, setext) 
+ Def(v, e, Divide(), leftright, inout, setext) 
+ Def(v, e, Maximum(), leftright, inout, setext) 
+ Def(v, e, Minimum(), leftright, inout, setext) : e-ty
	where	e	: e-ty
		and	(e-ty == BasicType(Decimal()) or 
		     e-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [e-ty]] on e
	

  Intersection(l, r)
+ Union(l, r)
+ Concat(l, r) : l-ty
	where	l	: l-ty
		and	r	: r-ty
		and	r-ty == l-ty else error $[Type mismatch: expected [l-ty] got [r-ty]] on r

  Def(v, e, Intersection(), leftright, inout, setext) 
+ Def(v, e, Union(), leftright, inout, setext) : e-ty
	where e : e-ty
	and (e-ty => Set(a-ty))
		else error $[Type mismatch: expected set type, got [e-ty]] on e


  Minus(l, r) : op-ty
	where	l	: l-ty
		and	r	: r-ty
		and	(l-ty == BasicType(Decimal()) or 
		     l-ty == BasicType(Int()) or
		     l-ty => Set(a-ty)) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) or set type got [l-ty]] on l
		and	((r-ty ==    l-ty and l-ty => op-ty) or
		     (r-ty <sub: l-ty and l-ty => op-ty) or
				 (l-ty <sub: r-ty and r-ty => op-ty)) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty]] on r

  Def(v, e, Minus(), leftright, inout, setext) : e-ty
	where	e	: e-ty
		and	(e-ty == BasicType(Decimal()) or 
		     e-ty == BasicType(Int()) or
		     e-ty => Set(a-ty)) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) or set type, got [e-ty]] on e

	

Def(v, e, Concat(), leftright, inout, setext) : e-ty
	where	e	: e-ty
		and	e-ty == BasicType(String()) 
		     else error $[Type mismatch: expected BasicType(String()) got [e-ty]] on e
	
	// Note v is a newly defined variable with the type of e so v-ty == e-ty (but it is defined at the level at BinOpDefRightInput, so we cannot query it)	
  Def(v, lhs, op, _, _, _) : e-ty
	where	lhs	: e-ty

	
	Head(e)	
+ Tail(e): e-ty
	where e : e-ty
	
  Cardinality(e): BasicType(Int())
  
  Negative(e): e-ty
	where e : e-ty
    and	(e-ty == BasicType(Decimal()) or 
		     e-ty == BasicType(Int())) 
		     else error $[Type mismatch: expected BasicType(Decimal()) or BasicType(Int()) got [e-ty]] on e

type rules // method call params should have correct types

	Subst(l, r):-
	where	l	: l-ty
		and	r	: r-ty
		and (r-ty == l-ty or r-ty <sub: l-ty) 
		     else error $[Type mismatch: expected [l-ty] got [r-ty]] on r

type rules // Method references should have a path that refers to a method		     
	
	MethodReference(path, p): BasicType(Boolean())
		where
					path : p-ty
			and p-ty has is-method "true"
			else error $[Expects a method] on path 
		
		
type rules // CurrentUser is a reference to a User object

	CurrentUser(path): ty
		where
				path : ty
		else error $[What is happening?  Where is the 'User' class?] on path
	
type rules // optional or mandatory (not encoded in type but separate property)

	BasicType(ty)       has multiplicity Mandatory()
	UniDirectional(a)   has multiplicity Mandatory()
	BiDirectional(a, b) has multiplicity Mandatory()
	Set(ty, mu)         has multiplicity Set()
	Optional(ty)        has multiplicity Optional()

type rules // store inverse for bidirectional

	BasicType(ty)       has inverse None()
	UniDirectional(a)   has inverse None()
	BiDirectional(a, b) has inverse b
	Set(ty, mu)         has inverse i where ty has inverse i
	Optional(ty)        has inverse i where ty has inverse i

type rules
