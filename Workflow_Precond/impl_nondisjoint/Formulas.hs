module Formulas where

import Misc

-- We provide a datatype for condtions that can occur in the calculation
-- of preconditions for concurrent guarded workflows. We currently abstract
-- from atomic formulas in the sense that only strings are used to represent them.
-- Additionally, we currently do not actually calculate the weakest precondition
-- of some elementary action (also abstractly represented as string) with respect
-- to some condition. Furthermore, we include representations Andn and Orn to allow 
-- for a better printing of these formulas. Semantically, they have no other meansing 
-- than And and Or.

data Formula =
    Atom String
  | Wp String Formula
  | And Formula Formula
  | Andn Formula Formula
  | Or Formula Formula
  | Orn Formula Formula
  | Not Formula
  | Imp Formula Formula
  deriving (Eq,Ord)

-- The function fshow generates a string representing a formula. It uses
-- an offset to keep track of the position at the end of the last line.
-- The offset is basically used to be able to print formulas containing
-- Andn and Orn more nicely.
fshow :: Formula -> Int -> (String,Int)
fshow (Atom a) offset = (a,offset + (length a))
fshow (Wp a f) offset = let (s1,o1) = (fshow f (offset + (length a) + 4))
                         in ("wp("++ a ++ "," ++ s1 ++ ")",o1+1)

fshow (And f1 f2) offset = let (s1,o1) = fshow f1 offset
                               (s2,o2) = fshow f2 (o1+4)
                            in (s1 ++ " /\\ " ++ s2 , o2) 

fshow (Andn f1 f2) offset = let (s1,o1) = fshow f1 offset
                                (s2,o2) = fshow f2 offset
                             in                   (s1 ++ "\n" ++
                                ostring(offset) ++ "/\\" ++ "\n" ++
                                ostring(offset) ++ s2,o2)

fshow (Or f1 f2) offset = let (s1,o1) = fshow f1 (offset+1)
                              (s2,o2) = fshow f2 (o1+4)
                            in ("(" ++ s1 ++ " \\/ " ++ s2 ++ ")", o2+1) 

fshow (Orn f1 f2) offset = let (s1,o1) = fshow f1 (offset+1)
                               (s2,o2) = fshow f2 (offset+1)
                             in                   ("(" ++ s1 ++ "\n" ++
                                ostring(offset+1) ++ "\\/" ++ "\n" ++
                                ostring(offset+1) ++ s2 ++ ")",o2+1)

fshow (Not f) offset = let (s1,o1) = fshow f (offset + 5)
                        in ("not (" ++ s1 ++ ")",o1+1)

fshow (Imp f1 f2) offset = let (s1,o1) = fshow f1 (offset+1)
                               (s2,o2) = fshow f2 (o1+5)
                            in ("(" ++ s1 ++ " --> " ++ s2 ++ ")", o2+1) 

-- Using the fshow function above, we are able to instantiate the Show-class for Formula.
instance Show Formula where
  show f = let (s,o) = fshow f 0
            in s




