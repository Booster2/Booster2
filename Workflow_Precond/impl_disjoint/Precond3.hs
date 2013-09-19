import Misc
import Formulas
import Workflows
import UMap
import Data.Set (Set,empty,elems,singleton,insert,toList,union,foldl)
import Data.List

-- Two cuncurrent workflows are equal if the lists of sequential workflows are
-- just permutations
instance Eq ParWf where
  Par xs == Par ys = xs == ys

-- calculate preconditions of all concurrent workflows that are constructed by replacing the ith sequential
-- workflow wi by w1(wi) and w2(wi) respectively for all indexes up to t and save them in the given
-- lookup table
preIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> UMap ParWf Formula
preIter (Par xs) i t lut = if i > t then lut
                           else let
                                  w = xs!!i
                                  gi1 = sel_g1(w)
                                  wi1 = sel_w1(w)
                                  gi2 = sel_g2(w)
                                  wi2 = sel_w2(w)
                                  lut1 = if gi1 == natom("false") then lut  else pre (  unskip(Par (listUpdate xs i wi1))  ) lut
                                  lut2 = if gi2 == natom("false") then lut1 else pre (  unskip(Par (listUpdate xs i wi2))  ) lut1
                                in preIter (Par xs) (i+1) t lut2

-- calculate the formula that represent the precondition for executing a1(w) or a2(w) at position i,
-- do that for all indexes up to t and return all thes formulas in a set; it is assumed
-- that all preconditions of the subsequent concurrent workflows are present in the lookup table
-- (this is exactly what is done in preIter)
predIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> Set Formula
predIter (Par xs) i t lut = let w = xs!!i
                                ai1 = sel_a1(w)
                                gi1 = sel_g1(w)
                                wi1 = sel_w1(w)
                                ai2 = sel_a2(w)
                                gi2 = sel_g2(w)
                                wi2 = sel_w2(w)

                                loc_cond = if      gi1 == natom("false") && gi2 == natom("false") then Atom("false")
                                           else if gi1 == natom("false")			  then And (get gi2) (Wp ai2 (lut!unskip(Par (listUpdate xs i wi2))))
                                           else if gi2 == natom("false")			  then And (get gi1) (Wp ai1 (lut!unskip(Par (listUpdate xs i wi1))))
                                           else  Orn ( And (get gi1) (Wp ai1 (lut!unskip(Par (listUpdate xs i wi1)))) )
                                                     ( And (get gi2) (Wp ai2 (lut!unskip(Par (listUpdate xs i wi2)))) )                                                    
                            in
                                if i==t then singleton loc_cond
                                        else Data.Set.insert loc_cond (predIter (Par xs) (i+1) t lut)

-- calculate the precondition of a concurrent workflow and save it in the given lookup table                            
pre :: ParWf -> UMap ParWf Formula -> UMap ParWf Formula
pre (Par []) lut = lut
pre (Par xs) lut = if lut ? (Par xs) then lut
                                     else
                   let i = indep (Par xs) 0 ((length xs) -1) 	-- Find i such that ai1,ai2 are independent to ALL 
                                                  		-- possible subsequent actions of the other workflows.
                                                 		-- Returns -1 is there is no such i
                    in if i == -1 then let -- the standard case
                                         lutn = preIter (Par xs) 0 ((length xs) -1) lut
                                         formset = predIter (Par xs) 0 ((length xs) -1) lutn
                                         form = foldr1 (Andn) (toList formset)
                                        in def lutn ((Par xs),form)
                                  else let -- the case where there are independent actions
                                         lutn = preIter (Par xs) i i lut
                                         formset = predIter (Par xs) i i lutn
                                         form = head (elems formset)
                                        in def lutn ((Par xs),form)


-- The main program ---------------------------------------------------------------------

initLut = def UMap.empty (Par [],Atom "I")

main = putStr (show ((pre exParWfHuge initLut) ! exParWfHuge))

