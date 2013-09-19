module Misc where

import Data.List
import Data.Map (Map,keys,(!))

-- ---------------------------------------------------------------------
-- List-related functions ----------------------------------------------
-- ---------------------------------------------------------------------

-- A function that generates a string with the given number
-- of whitespaces. Empty string if number less or equal 0.
ostring :: Int -> String
ostring n = replicate n ' '

-- check whether all elements in a list are distinct
distinct :: Eq a => [a] -> Bool
distinct [] = True
distinct (x:xs) = if elem x xs then False
                               else distinct xs

-- calculate the equivalence classes in a list with respect to an equivalence relation
duplicates :: (a -> a -> Bool) -> [a] -> [[a]]
duplicates eq [] = []
duplicates eq (x:xs) = let ecx = [y | y <- (x:xs) , eq x y] 
                        in ecx : duplicates eq [y | y <- (x:xs) , not (eq x y)] 


-- update a list at a certain position; it is assumed that the given index is greater or equal 0 and
-- that it is less then the length of the list
listUpdate :: [a] -> Int -> a -> [a]
listUpdate (x:xs) i e = if i==0 then e:xs
                                else x : (listUpdate xs (i-1) e)

-- remove the element at a given position in a list; it is assumed that the given index is greater or equal 0 and
-- that it is less then the length of the list
removeIndex :: [a] -> Int -> [a]
removeIndex (x:xs) 0 = xs
removeIndex (x:xs) n = x : removeIndex xs (n-1)

-- check whether two lists are permutations of each other
permut :: Eq a => [a] -> [a] -> Bool
permut [] [] = True
permut xs [] = False
permut [] ys = False
permut (x:xs) ys = if (elem x ys) then permut xs (delete x ys) 
                                  else False 

-- ---------------------------------------------------------------------
-- (Ordered) Map-related functions -------------------------------------
-- ---------------------------------------------------------------------

-- check whether all keys in an ordered Map are distinct
-- (this should be the case if constructed using the basic constructors of Map)
validM :: Eq k => Map k v -> Bool
validM m = distinct (keys m)

-- new printing function for (ordered) Maps
printMap :: (Ord k,Show k,Show v) => Map k v -> String
printMap m = "**************************************************** \n" ++
             printMap_help m (keys m) ++
             "\n**************************************************** \n"

printMap_help m ([])  = ""
printMap_help m ([k]) = (show k)   ++ "      --> \n\n" ++
                        (show (m!k))
printMap_help m (k:ks) = (show k)   ++ "      --> \n\n" ++
                         (show (m!k)) ++ "\n---------------------------------------------------- \n" ++
                         (printMap_help m ks)


