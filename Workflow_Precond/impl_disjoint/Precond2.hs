import Data.Map
import Formulas
import Workflows
import Misc

instance Eq ParWf where
  Par xs == Par ys = xs == ys
instance Ord ParWf where
  Par xs <= Par ys = xs <= ys

preIter :: ParWf -> Int -> Int -> Map ParWf Formula -> Map ParWf Formula
preIter (Par xs) i t lut = if i > t then lut
                           else let
                                  wi1 = w1(xs !! i)
                                  wi2 = w2(xs !! i)
                                  lut1 = pre (  unskip(Par (listUpdate xs i wi1))  ) lut
                                  lut2 = pre (  unskip(Par (listUpdate xs i wi2))  ) lut1
                                in preIter (Par xs) (i+1) t lut2

predIter :: ParWf -> Int -> Int -> Map ParWf Formula -> Formula
predIter (Par xs) i t lut = if i>t then (Atom "true") else
                            let w = xs!!i
                                ai1 = a1(w)
                                gi1 = g1(w)
                                wi1 = w1(w)
                                ai2 = a2(w)
                                gi2 = g2(w)
                                wi2 = w2(w)

                                loc_cond = Orn ( And gi1 (Wp ai1 (lut!unskip(Par (listUpdate xs i wi1)))) )
                                               ( And gi2 (Wp ai2 (lut!unskip(Par (listUpdate xs i wi2)))) )
                             in
                                if i==t then loc_cond
                                        else Andn loc_cond (predIter (Par xs) (i+1) t lut)
                            


pre :: ParWf -> Map ParWf Formula -> Map ParWf Formula
pre (Par []) lut = lut
pre (Par xs) lut = if member (Par xs) lut then lut
                                          else
                   let lutn = preIter (Par xs) 0 ((length xs) -1) lut
                       str = predIter (Par xs) 0 ((length xs) -1) lutn
                    in insert (Par xs) str lutn


-- The main program ---------------------------------------------------------------------

init = insert (Par []) (Atom "I") empty 

main = putStr (show ((pre exParWfHuge Main.init) ! exParWfHuge ))

