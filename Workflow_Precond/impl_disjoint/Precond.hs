import UMap
import Formulas
import Workflows
import Misc
import Data.Set (Set,singleton,insert,toList)
import Data.List

instance Eq ParWf where
  Par xs == Par ys = permut xs ys


preIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> UMap ParWf Formula
preIter (Par xs) i t lut = if i > t then lut
                           else let
                                  w = xs!!i
                                  gi1 = g1(w)
                                  wi1 = w1(w)
                                  gi2 = g2(w)
                                  wi2 = w2(w)
                                  lut1 = if gi1 == Atom("false") then lut  else pre (  unskip(Par (listUpdate xs i wi1))  ) lut
                                  lut2 = if gi2 == Atom("false") then lut1 else pre (  unskip(Par (listUpdate xs i wi2))  ) lut1
                                in preIter (Par xs) (i+1) t lut2

predIter :: ParWf -> Int -> Int -> UMap ParWf Formula -> Set Formula
predIter (Par xs) i t lut = if i>t then singleton (Atom "true") else
                            let w = xs!!i
                                ai1 = a1(w)
                                gi1 = g1(w)
                                wi1 = w1(w)
                                ai2 = a2(w)
                                gi2 = g2(w)
                                wi2 = w2(w)

                                loc_cond = if      gi1 == Atom("false") && gi2 == Atom("false") then Atom("false")
                                           else if gi1 == Atom("false")				then And gi2 (Wp ai2 (lut!unskip(Par (listUpdate xs i wi2))))
                                           else if gi2 == Atom("false")			 	then And gi1 (Wp ai1 (lut!unskip(Par (listUpdate xs i wi1))))
                                           else  Orn ( And gi1 (Wp ai1 (lut!unskip(Par (listUpdate xs i wi1)))) )
                                                     ( And gi2 (Wp ai2 (lut!unskip(Par (listUpdate xs i wi2)))) )                                                    
                            in
                                if i==t then singleton loc_cond
                                        else Data.Set.insert loc_cond (predIter (Par xs) (i+1) t lut)
                            
pre :: ParWf -> UMap ParWf Formula -> UMap ParWf Formula
pre (Par []) lut = lut
pre (Par xs) lut = if lut ? (Par xs) then lut
                                     else
                   let lutn = preIter (Par xs) 0 ((length xs) -1) lut
                       formset = predIter (Par xs) 0 ((length xs) -1) lutn
                       form = foldr1 (Andn) (toList formset)
                    in def lutn ((Par xs),form)


-- The main program ---------------------------------------------------------------------

init = def UMap.empty (Par [],Atom "I")

main = putStr (show ((pre exParWfHuge Main.init) ! exParWfHuge))

