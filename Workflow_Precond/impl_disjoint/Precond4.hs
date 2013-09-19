import Misc
import Formulas
import Workflows
import UMap
import Data.Set (Set,empty,elems,singleton,insert,toList,union,foldl,null)
import Data.List

-- Two cuncurrent workflows are equal if the lists of sequential workflows are
-- just permutations
instance Eq ParWf where
  Par xs == Par ys = xs==ys	--permut xs ys	 -- TODO: I'm not sure whether permut can cause problems because we rely to a certain degree on the ordering of workflows.
						 --       This makes only a difference if (partly) identical workflows are running. Is this likely?

-- delays all initial actions from wfi until wft that are independent from ga, gb;
-- it is assumed that length xs >= t; it is assumed that wj|=Skip and that all gj1, gj2 are not delayed for all i<=j<=t
indepIter:: ParWf -> GuardedAction -> GuardedAction -> Int -> Int -> ParWf
indepIter (Par xs) ga gb i t = if i>t then Par xs
                               else let wi  = xs!!i
                                        gi1 = sel_g1(wi)
                                        ai1 = sel_a1(wi)
                                        wi1 = sel_w1(wi)
                                        gi2 = sel_g2(wi)
                                        ai2 = sel_a2(wi)
                                        wi2 = sel_w2(wi)
                                     
                                        win = if indepActions (gi1,ai1) ga && indepActions (gi2,ai2) ga &&
                                                 indepActions (gi1,ai1) gb && indepActions (gi2,ai2) gb
                                              then
                                                 Choice (Delayed (get gi1),ai1) wi1
                                                        (Delayed (get gi2),ai2) wi2
                                              else wi
                                     in indepIter (Par (listUpdate xs i win)) ga gb (i+1) t

-- calculate preconditions of all concurrent workflows that are constructed by replacing the ith sequential
-- workflow wi by w1(wi) and w2(wi) respectively for all indexes up to t and save them in the given
-- lookup table; we assume that i>=0
preIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> UMap ParWf Formula
preIter (Par xs) i t lut = if i > t then lut
                           else let
                                  wi = xs!!i
                                  gi1 = sel_g1(wi)
                                  ai1 = sel_a1(wi)
                                  wi1 = sel_w1(wi)
                                  gi2 = sel_g2(wi)
                                  ai2 = sel_a2(wi)
                                  wi2 = sel_w2(wi)

                                  lut1 = if gi1 == natom("false") then lut else
                                         if delayed gi1           then lut else
                                              pre (unskip (indepIter (undelay (Par (listUpdate xs i wi1))) (gi1,ai1) (gi2,ai2) 0 (i-1))) lut
                                  lut2 = if gi2 == natom("false") then lut1 else
                                         if delayed gi2           then lut1 else
                                              pre (unskip (indepIter (undelay (Par (listUpdate xs i wi2))) (gi2,ai2) (gi2,ai2) 0 (i-1))) lut1

                                in preIter (Par xs) (i+1) t lut2

-- calculate the formula that represent the precondition for executing a1(wi) or a2(wi),
-- do that for all indexes up to t and return all thes formulas in a set; it is assumed
-- that all preconditions of the subsequent concurrent workflows are present in the lookup table
-- (this is exactly what is done in preIter); furthermore, it is assumed that for all gi1, gi2
-- gi1 is delayed iff gi2 is delayed
predIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> Set Formula
predIter (Par xs) i t lut = if i>t then Data.Set.empty else
                            let wi = xs!!i
                                ai1 = sel_a1(wi)
                                gi1 = sel_g1(wi)
                                wi1 = sel_w1(wi)
                                ai2 = sel_a2(wi)
                                gi2 = sel_g2(wi)
                                wi2 = sel_w2(wi)

                                loc_cond = if      delayed gi1 && delayed gi2                   then Atom "true" 	-- TODO: I'm a bit unsure here - look at 13.08.2013 (1)
                                           else if gi1 == natom "false" && gi2 == natom "false" then Atom "false"
                                           else if gi1 == natom "false"			  	then
                                                 let right = lut!unskip (indepIter (undelay (Par (listUpdate xs i wi2))) (gi1,ai1) (gi2,ai2) 0 (i-1))
                                                  in And (get gi2) (Wp ai2 right)
                                           else if gi2 == natom "false" 			then
                                                 let left = lut!unskip (indepIter (undelay (Par (listUpdate xs i wi1))) (gi1,ai1) (gi2,ai2) 0 (i-1))
                                                  in And (get gi1) (Wp ai1 left)
                                           else  let left  = lut!unskip (indepIter (undelay (Par (listUpdate xs i wi1))) (gi1,ai1) (gi2,ai2) 0 (i-1))
                                                     right = lut!unskip (indepIter (undelay (Par (listUpdate xs i wi2))) (gi2,ai2) (gi2,ai2) 0 (i-1))
                                                  in Orn ( And (get gi1) (Wp ai1 (left)) )
                                                         ( And (get gi2) (Wp ai2 (right)) )
                             in
                               if loc_cond == Atom "true" then predIter (Par xs) (i+1) t lut
                                                          else Data.Set.insert loc_cond (predIter (Par xs) (i+1) t lut)

-- TODO: preIter and predIter should be combined!!


-- calculate the precondition of a concurrent workflow and save it in the given lookup table;
-- it is assumed that all wi |= Skip
pre :: ParWf -> UMap ParWf Formula -> UMap ParWf Formula
pre (Par []) lut = lut
pre (Par xs) lut = if lut ? (Par xs) then lut
                                     else
                       let -- the standard case
                         lutn = preIter (Par xs) 0 ((length xs) -1) lut
                         formset = predIter (Par xs) 0 ((length xs) -1) lutn
                         form = if Data.Set.null formset then Atom "true"
                                                 else foldr1 (Andn) (toList formset)
                       in def lutn ((Par xs),form)

-- The main program ---------------------------------------------------------------------

initLut = def UMap.empty (Par [],Atom "I")

main = putStr (show ((pre exParWfHuge initLut) ! exParWfHuge))

