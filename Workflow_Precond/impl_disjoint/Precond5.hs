import Misc
import Formulas
import Workflows
import UMap
import Data.Set (Set,empty,elems,singleton,insert,toList,union,foldl,null)
import Data.List

-- Two cuncurrent workflows are equal if the lists of sequential workflows are
-- just permutations
instance Eq ParWf where
  Par ws1 == Par ws2 = ws1==ws2	--permut xs ys	 -- TODO: I'm not sure whether permut can cause problems because we rely to a certain degree on the ordering of workflows.
						 --       This makes only a difference if (partly) identical workflows are running. Is this likely?

-- delays all initial actions from wfi until wft that are mutually independent from ga, gb;
-- it is assumed that i>=0 and t<length ws; 
-- it is assumed that wj|=Skip 
-- it is assumed that all gj1, gj2 are not delayed for all i<=j<=t
indepIter:: ParWf -> GuardedAction -> GuardedAction -> Int -> Int -> ParWf
indepIter (Par ws) ga gb i t = if i>t then Par ws
                               else let wi  = ws!!i
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
                                     in indepIter (Par (listUpdate ws i win)) ga gb (i+1) t

-- calculate preconditions of all concurrent workflows that are constructed by replacing the ith sequential
-- workflow wi by w1(wi) and w2(wi) respectively for all indexes up to t and save them in the given
-- lookup table, as a second result calculate the corresponding subformulas; 
-- it is assumed that i>=0 and t<length ws;
-- it is assumed that for all gi1, gi2: gi1 is delayed iff gi2 is delayed
preIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> (UMap ParWf Formula, Set Formula)
preIter (Par ws) i t lut = 
	if i > t then (lut,Data.Set.empty)
	else let
		wi = ws!!i
		gi1 = sel_g1(wi)
		ai1 = sel_a1(wi)
		wi1 = sel_w1(wi)
		gi2 = sel_g2(wi)
		ai2 = sel_a2(wi)
		wi2 = sel_w2(wi)
		
		-- TODO: This could be done more intelligently!
		par1 = unskip (indepIter (undelay (Par (listUpdate ws i wi1))) (gi1,ai1) (gi2,ai2) 0 (i-1))
		par2 = unskip (indepIter (undelay (Par (listUpdate ws i wi2))) (gi1,ai1) (gi2,ai2) 0 (i-1))

		lut1 = if gi1 == natom "false" || delayed gi1 then lut 
		       else pre par1 lut
		lut2 = if gi2 == natom "false" || delayed gi2 then lut1 
		       else pre par2 lut1

		loc_cond = if delayed gi1 && delayed gi2                   		then Atom "itrue" else	
			   if gi1 == natom "false" && gi2 == natom "false" 		then Atom "false" else
			   if gi1 == natom "false"			     		then if lut2!par2 == Atom "itrue" then Atom "itrue" 
											     else And (get gi2) (Wp ai2 (lut2!par2)) else
			   if gi2 == natom "false"			     		then if lut2!par1 == Atom "itrue" then Atom "itrue"
											     else And (get gi1) (Wp ai1 (lut2!par1)) else
			   if lut2!par1 == Atom "itrue" && lut2!par2 == Atom "itrue"	then Atom "itrue" else	-- In this case gi1 /\ wp(ai1,true) \/ gi2 /\ wp(ai2,true)
         													-- is implied by another path because "itrue" can only be introduced
														-- by the situation that all subsequent gj1 and gj2 are delayed.
														-- A similar argumentation holds above.
			Orn ( And (get gi1) (Wp ai1 (lut2!par1)) )
			    ( And (get gi2) (Wp ai2 (lut2!par2)) )
 
		(lutn,fs) = preIter (Par ws) (i+1) t lut2

		fsn = if loc_cond == Atom "itrue" then fs else Data.Set.insert loc_cond fs
	     in (lutn,fsn)

-- prioritise the actions of workflow wi and calculate the corresponding look-up table
-- i is assumed to be between 0 and (length ws)-1;
-- it is assumed that all wi |= Skip
-- it is assumed that gi1 and gi2 are not delayed;
prioritise :: ParWf -> Int -> UMap ParWf Formula -> UMap ParWf Formula
prioritise (Par ws) i lut =
                    let wi = ws!!i
                        gi1 = sel_g1(wi)
                        ai1 = sel_a1(wi)
                        wi1 = sel_w1(wi)
                        gi2 = sel_g2(wi)
                        ai2 = sel_a2(wi)
                        wi2 = sel_w2(wi)
                    
			-- TODO: This could be done more intelligently!
                        par1 = unskip (undelay (Par (listUpdate ws i wi1)))
                        par2 = unskip (undelay (Par (listUpdate ws i wi2)))

                        lut1 = if gi1 == natom "false" then lut  else pre par1 lut
                        lutn = if gi1 == natom "false" then lut1 else pre par2 lut1

                        form = if gi1 == natom "false" && gi2 == natom "false" then Atom "false" else
                               if gi1 == natom "false" then And (get gi2) (Wp ai2 (lutn!par2)) else
                               if gi2 == natom "false" then And (get gi1) (Wp ai1 (lutn!par1)) else
                                 Orn (And (get gi1) (Wp ai1 (lutn!par1)) )
                                     (And (get gi2) (Wp ai2 (lutn!par2)) )
                     in def lutn (Par ws,form)

-- calculate the precondition of a concurrent workflow and save it in the given lookup table;
-- it is assumed that all wi |= Skip
pre :: ParWf -> UMap ParWf Formula -> UMap ParWf Formula
pre (Par []) lut = lut
pre (Par xs) lut = if lut ? (Par xs) then lut
                                     else
                   let i = indep (Par xs) 0 ((length xs) -1) 	-- Find i such that ai1,ai2 are independent to ALL 
                                                  		-- possible subsequent actions of the other workflows.
                                                  		-- Returns -1 is there is no such i
                    in if i == -1 then let -- the standard case
                                         (lutn,formset) = preIter (Par xs) 0 ((length xs) -1) lut
                                         form = if Data.Set.null formset then Atom "itrue"
                                                else foldr1 (Andn) (toList formset)
                                        in def lutn ((Par xs),form)
                                  else prioritise (Par xs) i lut -- If ai1 and ai2 are independent from all actions of the other workflows, 
                                                                 -- we can prioritise their execution over all other initial actions.
                      
-- The main program ---------------------------------------------------------------------

initLut = def UMap.empty (Par [],Atom "I")

main = putStr (show ((pre exParWfHuge initLut) ! exParWfHuge))

