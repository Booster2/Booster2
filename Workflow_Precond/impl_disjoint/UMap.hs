module UMap where

import Misc

-- For test reasons, we define an Unordered-Map datatype. It is basically used to check
-- whether processes in the precondition calculation are inserted into the map several times.

-- A simple datatype for unordered maps based on lists of pairs.
data UMap k v = UMap [(k,v)]
                           
-- The empty map
empty :: UMap k v
empty = UMap []

-- !!!for test reasons, values to the same key are currently not overwritten!!!
def :: UMap k v -> (k,v) -> UMap k v
def (UMap l) (k,v) = UMap ((k,v) : l)

-- Check whether a key is defined in a map
(?) :: Eq k => UMap k v -> k -> Bool
(?) (UMap []) k = False
(?) (UMap ((k1,v):xs)) k = if k==k1 then True
                           else (UMap xs) ? k

-- Get the value to a defined(!) key
(!) :: Eq k => UMap k v -> k -> v
(!) (UMap ((k,v):xs)) sk = if k==sk then v
                           else (UMap xs) ! sk

-- Are all keys of a map distinct?
valid :: Eq k => UMap k v -> Bool
valid (UMap xs) = distinct (map (\(k,v) -> k) xs)

-- How many entries does the map have?
size :: UMap k v -> Int
size (UMap xs) = length xs 

-- printing maps
instance (Show k , Show v) => Show (UMap k v) where
  show (UMap []) = "empty"
  show (UMap [(k,v)]) = (show k) ++ "   |-->    " ++ (show v)
  show (UMap ((k,v):xs)) = show (UMap xs) ++ "\n ------------------------------------- \n" ++
                           (show k) ++ "   |-->    \n" ++ (show v) 

