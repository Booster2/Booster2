module Workflows where
import Formulas
import Misc
import Data.List
import Data.Set (Set,empty,insert,union,foldl)

-- ------------------------------------------------------------------------------------------------
-- Definition of guarded actions ------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

-- A Guard can be a normal formula or a delayed formula. Delayed guards should no be used by the user.
-- They are only ment to be constructed by the precondition calculations.
data Guard =
     Normal Formula    
   | Delayed Formula
   deriving (Eq,Ord)

-- Constructing a usual atom as guard
natom :: String -> Guard
natom s = Normal (Atom s)

-- check whether a guard is delayed
delayed :: Guard -> Bool
delayed (Delayed f) = True
delayed _ = False

-- get the formula of a normal guard
get:: Guard -> Formula
get (Normal f) = f

instance Show Guard where
  show (Delayed f) = "<" ++ show f ++ ">" 
  show (Normal f) = show f

-- a guarded action consists of a guard expressed as a formula and a string representing the action's name
type GuardedAction = (Guard,String)

-- check whether a guarded action is delayed
delayedGA :: GuardedAction -> Bool
delayedGA (g,a) = delayed g

-- guarded actions (sometimes) need to be delayed in the calculation of preconditions of concurrent workflows
-- if independent guarded actions are considered; later they need to be undelayed again
undelayGA :: GuardedAction -> GuardedAction
undelayGA (Delayed g,a) = (Normal g,a)
undelayGA ga = ga

-- -----------------------------------------------------------------------------------------------------
-- Definition of sequential workflows ------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------

-- Our language of sequential workflows is very simple: A workflow can either successfully terminate
-- or can branch according to two guarded actions reaching the correponding subsequent workflow
data SeqWf = Skip
           | Choice GuardedAction SeqWf
                    GuardedAction SeqWf
  deriving (Eq,Ord)

-- explicit selectors for choice nodes
sel_ga1 (Choice (wg1,wa1) wf1
                (wg2,wa2) wf2) = (wg1,wa1)
sel_g1 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wg1
sel_a1 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wa1
sel_w1 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wf1
sel_ga2 (Choice (wg1,wa1) wf1
                (wg2,wa2) wf2) = (wg2,wa2)
sel_g2 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wg2
sel_a2 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wa2
sel_w2 (Choice (wg1,wa1) wf1
               (wg2,wa2) wf2) = wf2

-- Syntactic sugar: If the worflow should not be branching, we can declare the second guard of the
-- choice as "false"
prefix :: GuardedAction -> SeqWf -> SeqWf
prefix ga w = Choice ga                      w
                     (Normal (Atom "false"),"skip") Skip

-- In the later precondition calculation, only initial actions of a (sequential) workflow can be delayed.
-- Therefore, we do not need to recurse when undelaying them. The assumption is thus that only inital
-- guards are delayed
undelaySeq:: SeqWf -> SeqWf
undelaySeq Skip = Skip
undelaySeq (Choice ga11 w11
                   ga12 w12) = Choice (undelayGA ga11) w11 
                                      (undelayGA ga12) w12

-- Calculate all possible subsequent guarded-action pairs of a sequential workflow
subseqActionsSeq :: SeqWf -> Set (GuardedAction,GuardedAction)
subseqActionsSeq Skip = Data.Set.empty
subseqActionsSeq (Choice ga1 wf1
                         ga2 wf2) = Data.Set.insert (ga1,ga2) 
                                    (Data.Set.union (subseqActionsSeq wf1) (subseqActionsSeq wf2))
                                                   

-- printing sequential workflows
mshow :: SeqWf -> Int -> (String,Int)
mshow Skip offset = ("Skip",offset+4)
  -- for prefix
mshow (Choice (g11,a11)                    w11
              (Normal (Atom "false"), a12) w12) offset = 
                      let g1s = show g11
                          start1 = (length g1s) + (length a11) + 8
                          (s1,o1) = mshow w11 (offset + start1)
                       in ("(" ++ g1s ++ " & " ++ a11 ++ " -> " ++ s1 ++ ")",o1+1)
  -- the general Choice case
mshow (Choice (g11,a11) w11
              (g12,a12) w12) offset =
                      let g1s = show g11
                          start1 = (length g1s) + (length a11) + 8
                          (s1,o1) = mshow w11 (offset + start1)
                          g2s = show g12
                          start2 = (length g2s) + (length a11) + 8
                          (s2,o2) = mshow w12 (offset + start2)
                       in ("(" ++ g1s ++ " & " ++ a11 ++ " -> " ++ s1 ++ "\n" ++
                           ostring offset ++ "[] \n" ++
                           ostring offset ++ " " ++ g2s ++ " & " ++ a12 ++ " -> " ++ s2  , o2)

instance Show SeqWf where
  show w = let (s,o) = mshow w 0
            in s


-- Definition of concurrent workflows ------------------------------------------------------------------

-- A concurrent workflow is simply a list of sequential workflows
data ParWf = Par [SeqWf]

-- selector for concurrent workflows
list:: ParWf -> [SeqWf]
list (Par xs) = xs

-- To undelay a concurrent workflow, we need to undelay all contained sequential workflows
undelay :: ParWf -> ParWf
undelay (Par ws) = Par (map undelaySeq ws)

-- Get rid of all top-level "Skips" in a concurrent workflow
unskip :: ParWf -> ParWf
unskip (Par xs) = Par [ x | x <- xs, x /= Skip]

-- calculate the possible initial guarded-action-pairs of a concurrent workflow;
-- it is assumed that none of the sequential workflows is "Skip"; <currently not used>
initials :: ParWf -> [(GuardedAction, GuardedAction)]
initials (Par []) = []
initials (Par (w:ws)) = (sel_ga1 w,sel_ga2 w) : initials (Par ws)

-- calculate all possible subsequent guarded actions of a concurrent workflow
subseqActionsPar :: ParWf -> Set (GuardedAction,GuardedAction)
subseqActionsPar (Par xs) = foldr (Data.Set.union) (Data.Set.empty) (map subseqActionsSeq xs)

instance Show ParWf where
  show (Par []) = "Skip"
  show (Par [w]) = show w
  show (Par (w:ws)) = show w ++ "\n\n ||| \n\n" ++ show (Par ws)



-- ---------------------------------------------------------------------------------------
-- Concerning independent actions --------------------------------------------------------
-- ---------------------------------------------------------------------------------------

-- check whether an guarded-action-pair pair is independent from all action
-- pairs in the given set
indepPair :: (GuardedAction,GuardedAction) -> Set (GuardedAction,GuardedAction) -> Bool
indepPair (ga1,ga2) gas = Data.Set.foldl (\c (gb1,gb2) -> c && indepActions (ga1,ga2) (gb1,gb2)) (True) gas

-- calculate the first index of a guarded-action-pair that is (not delayed and) independent from all guarded-action-pairs from the other workflows 
indep:: ParWf -> Int -> Int -> Int
indep (Par ws) i t = if i > t then -1 
                              else let wi = ws!!i
                                       gai1 = sel_ga1 wi
                                       gai2 = sel_ga2 wi 
                                    in if delayedGA gai1 || delayedGA gai2 then indep (Par ws) (i+1) t else
                                       if indepPair (gai1,gai2) (subseqActionsPar (Par (removeIndex ws i))) then i
                                       else indep (Par ws) (i+1) t

-- user given independent actions
-- It is assumed that independence of guarded actions ((g1,a1),(g2,a2)), ((h1,b1),(h2,b2)) can be decided in the
-- following sense: indepActions ((g1,a1),(g2,a2)) ((h1,b1),(h2,b2)) expresses the following (I know it's horrible) 
-- - g1/\ng2&a1 ; h1/\nh2&b1  \subseteq  h1/\nh2&b1 ; g1/\ng2&a1
-- - g1/\ng2&a1 ; nh1/\h2&b1  \subseteq  nh1/\h2&b1 ; g1/\ng2&a1
-- - g1/\ng2&a1 ; h1/\h2&b1   \subseteq  h1/\h2&b1  ; g1/\ng2&a1
-- - g1/\ng2&a1 ; h1/\h2&b2   \subseteq  h1/\h2&b2  ; g1/\ng2&a1
--
-- - ng1/\g2&a1 ; h1/\nh2&b1  \subseteq  h1/\nh2&b1 ; ng1/\g2&a1
-- - ng1/\g2&a1 ; nh1/\h2&b1  \subseteq  nh1/\h2&b1 ; ng1/\g2&a1
-- - ng1/\g2&a1 ; h1/\h2&b1   \subseteq  h1/\h2&b1  ; ng1/\g2&a1
-- - ng1/\g2&a1 ; h1/\h2&b2   \subseteq  h1/\h2&b2  ; ng1/\g2&a1
--
-- - g1/\g2&a1 ; h1/\nh2&b1   \subseteq  h1/\nh2&b1 ; g1/\g2&a1
-- - g1/\g2&a1 ; nh1/\h2&b1   \subseteq  nh1/\h2&b1 ; g1/\g2&a1
-- - g1/\g2&a1 ; h1/\h2&b1    \subseteq  h1/\h2&b1  ; g1/\g2&a1
-- - g1/\g2&a1 ; h1/\h2&b2    \subseteq  h1/\h2&b2  ; g1/\g2&a1
--
-- - g1/\g2&a2 ; h1/\nh2&b1   \subseteq  h1/\nh2&b1 ; g1/\g2&a2
-- - g1/\g2&a2 ; nh1/\h2&b1   \subseteq  nh1/\h2&b1 ; g1/\g2&a2
-- - g1/\g2&a2 ; h1/\h2&b1    \subseteq  h1/\h2&b1  ; g1/\g2&a2
-- - g1/\g2&a2 ; h1/\h2&b2    \subseteq  h1/\h2&b2  ; g1/\g2&a2
indepActions :: (GuardedAction,GuardedAction) -> (GuardedAction,GuardedAction) -> Bool
indepActions (ga1,ga2) ((Delayed h1,b1),(Delayed h2,b2)) = indepActions (ga1,ga2) ((Normal h1,b1),(Normal h2,b2))

-- ---------------------------------------------------------------------------------------
-- Example Workflows ---------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------
indepActions ((g1,"a1"),(g2,"a2")) ((h1,"b1"),(h2,"b2")) = True
--indepActions (g1,"a2") (h1,x) = elem x ["b1","b2"]
--indepActions (g1,"b2") (h1,x) = elem x ["a2","c2"]
--indepActions (g1,"b1") (h1,x) = elem x ["c2"]
--indepActions (g1,"a2") (h1,x) = elem x ["c1"]
--indepActions (g1,"c1") (h1,x) = elem x ["a1","a2"]
--indepActions (g1,"b1") (h1,x) = elem x ["a2"]
--indepActions (g1,"a2") (h1,x) = elem x ["b2", "skip"]
--indepActions (g1,"b1") (h1,x) = elem x ["c1"]
indepActions (ga1,ga2) (gb1,gb2) = False
--indepActions "skip"  x = True
--indepActions "a1"    x = elem x ["a1","b1","b2","a2","a3","skip"]
--indepActions "a2"    x = elem x ["a2","b1","b2","a1","a3","skip"]
--indepActions "a3"    x = elem x ["a3","b1","b2","a1","a2","skip"]
--indepActions "b1"    x = elem x ["b1","a1","a2","a3","skip"]
--indepActions "b2"    x = elem x ["b2","a1","a2","a3","skip"]
--indepActions "a11"   x = elem x ["a11",  "skip"]
--indepActions "a12"   x = elem x ["a11",  "skip"]
--indepActions "a21"   x = elem x ["a21",  "skip"]
--indepActions "a22"   x = elem x ["a22",  "skip"]
--indepActions "a11'"  x = elem x ["a11'", "skip"]
--indepActions "a12'"  x = elem x ["a12'", "skip"]
--indepActions "a21'"  x = elem x ["a21'", "skip"]
--indepActions "a22'"  x = elem x ["a22'", "skip"]
--indepActions "a11''" x = elem x ["a11''","skip"]
--indepActions "a12''" x = elem x ["a12''","skip"]
--indepActions "a21''" x = elem x ["a21''","skip"]
--indepActions "a22''" x = elem x ["a22''","skip"]
--indepActions n       x = elem x [n,"skip"]

exSeqWfSingle11 = prefix (natom "g2","a2") Skip
exSeqWfSingle12 = prefix (natom "h2","b2") Skip
exSeqWfSingle13 = prefix (natom "i2","c2") Skip
exSeqWfSingle14 = prefix (natom "j1","d1") Skip

exSeqWfSingle21 = prefix (natom "g1","a1") exSeqWfSingle11
exSeqWfSingle22 = prefix (natom "h1","b1") exSeqWfSingle12
exSeqWfSingle23 = prefix (natom "i1","c1") exSeqWfSingle13

exSeqWfSingle31 = prefix (natom "g1","a1") (prefix (natom "g2","a2") (prefix (natom "g3","a3") Skip))


exSeqWfChoice11 = Choice (natom "g1","a1") Skip
                         (natom "g2","a2") Skip
                                   
exSeqWfChoice12 = Choice (natom "h1","b1") Skip
                         (natom "h2","b2") Skip

exSeqWfChoice21 = Choice (natom "g1","a1") (Choice (natom "g11","a11") Skip
                                                   (natom "g12","a12") Skip)
                         (natom "g2","a2") (Choice (natom "g21","a21") Skip
                                                   (natom "g22","a22") Skip)

exSeqWfChoice22 = Choice (natom "h1","b1") (Choice (natom "h11","b11") Skip
                                                   (natom "h12","b12") Skip)
                         (natom "h2","b2") (Choice (natom "h21","b21") Skip
                                                   (natom "h22","b22") Skip)

exSeqWfChoice23 = Choice (natom "g1'","a1'") (Choice (natom "g11'","a11'") Skip
                                                     (natom "g12'","a12'") Skip)
                         (natom "g2'","a2'") (Choice (natom "g21'","a21'") Skip
                                                     (natom "g22'","a22'") Skip)

exSeqWfChoice24 = Choice (natom "g1''","a1''") (Choice (natom "g11''","a11''") Skip
                                                       (natom "g12''","a12''") Skip)
                         (natom "g2''","a2''") (Choice (natom "g21''","a21''") Skip
                                                       (natom "g22''","a22''") Skip)

exSeqWfMixed21 = Choice (natom "g1","a1") (prefix (natom "g3","a3") Skip)
                        (natom "g2","a2") Skip

exSeqWfMixed22 = Choice (natom "h1","b1") (prefix (natom "h3","b3") Skip)
                        (natom "h2","b2") Skip

exSeqStrange = Choice (natom "i1","c") (Skip)
                      (natom "false","d") (prefix (natom "i2","e") Skip)


exSeqWf_test = Choice (natom "g1","a1") (prefix (natom "h1","b1") (prefix (natom "h2","b2") exSeqWfSingle13))
                      (natom "g2","a2") (prefix (natom "h3","b3") exSeqWfSingle13)

exParWf1    = Par [exSeqWfSingle11,exSeqWfSingle12,exSeqWfSingle13,exSeqWfSingle14]
exParWf2    = Par [exSeqWfSingle21,exSeqWfSingle22,exSeqWfSingle23]
exParWf3    = Par [exSeqWfChoice11,exSeqWfChoice12]
exParWf4    = Par [exSeqWfChoice21,exSeqWfChoice22,exSeqWfChoice23]

exParWf5    = Par [exSeqWfSingle21,exSeqWfSingle22,exSeqWfSingle13]

exParWf6    = Par [exSeqWfSingle12,exSeqWfMixed21]

exParWf7    = Par [exSeqWfSingle11,exSeqWfSingle22,exSeqWfSingle13]

exParWf8    = Par [exSeqWfChoice11,exSeqWfMixed22]

exParWf9    = Par [exSeqWfChoice11,exSeqWfChoice22]

exParWfHuge = Par [exSeqWfChoice21 , exSeqWfChoice22 , exSeqWfChoice23, exSeqWfChoice21 , exSeqWfChoice22]

