module Coursework where

{-
  Your task is to design a datatype that represents the mathematical concept of a (finite) set of elements (of the same type).
  We have provided you with an interface (do not change this!) but you will need to design the datatype and also 
  support the required functions over sets.
  Any functions you write should maintain the following invariant: no duplication of set elements.

  There are lots of different ways to implement a set. The easiest is to use a list
  (as in the example below). Alternatively, one could use an algebraic data type, or 
  wrap a binary search tree.
  Extra marks will be awarded for efficient implementations if appropriate.

  You are NOT allowed to import anything from the standard library or other libraries.
  Your edit of this file should be completely self-contained.

  DO NOT change the type signatures of the functions below: if you do,
  we will not be able to test them and you will get 0% for that part. While sets are unordered collections,
  we have included the Ord constraint on most signatures: this is to make testing easier.

  You may write as many auxiliary functions as you need. Please include everything in this file.
-}

{-
   PART 1.
   You need to define a Set datatype. Below is an example which uses lists internally.
   It is here as a guide, but also to stop ghci complaining when you load the file.
   Free free to change it.
-}

-- you may change this to your own data type
data Set a = Empty | Next(a, Set a)
   deriving (Show, Ord)

{-
   PART 2.
   If you do nothing else, at least get the following two functions working. They
   are required for testing purposes.
-}

-- toList {2,1,4,3} => [1,2,3,4]
-- the output must be sorted.
toList :: Ord a => Set a -> [a]
toList Empty = []
toList (Next(x, xs)) = sort (inner (Next(x, xs)))
   where inner (Next(x, xs)) = x : inner xs
         inner Empty = []

--  some sort of quick (ish) sort   
sort :: Ord a => [a] -> [a]
sort [] = []
sort [x] = [x]
sort (x:xs) = sort (filter (< x) xs) ++ [x] ++ sort (filter (>= x) xs) --for some reason : doesn't work

-- fromList [2,1,1,4,5] => {2,1,4,5}
fromList :: Ord a => [a] -> Set a
fromList [] = Empty
fromList [x] = singleton x
fromList (x:xs) = if member x (fromList xs)
                     then fromList xs
                  else Next(x, fromList xs)

removeDuplicates :: Ord a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates [x] = [x]
removeDuplicates (x:xs) = x : [y | y <- removeDuplicates xs, y /= x]

{-
   PART 3.
   Your Set should contain the following functions.
   DO NOT CHANGE THE TYPE SIGNATURES.
-}

-- test if two sets have the same elements.
instance (Ord a) => Eq (Set a) where
  s1 == s2 = toList s1 == toList s2

-- the empty set
empty :: Set a
empty = Empty

-- Set with one element
singleton :: a -> Set a
singleton a = Next(a, Empty)

-- insert an element of type a into a Set
-- make sure there are no duplicates!
insert :: (Ord a) => a -> Set a -> Set a
insert a Empty = singleton a
insert a (Next(x, xs)) = if not (member a (Next(x, xs)))
                           then Next(a, Next(x, xs))
                        else Next(x, xs)

-- join two Sets together
-- be careful not to introduce duplicates.
union :: (Ord a) => Set a -> Set a -> Set a
union s1 Empty = s1
union s1 (Next(x, xs)) = if not (member x s1)
                           then Next(x, union s1 xs)
                        else union s1 xs

-- return the common elements between two Sets
intersection :: (Ord a) => Set a -> Set a -> Set a
intersection s1 Empty = Empty
intersection Empty s2 = Empty
intersection (Next(x, xs)) s2 =   if member x s2
                                    then fromList (x : [y | y <- toList xs, not (member y s2)])
                                 else fromList [y | y <- toList xs, member y s2]


-- all the elements in Set A *not* in Set B,
-- {1,2,3,4} `difference` {3,4} => {1,2}
-- {} `difference` {0} => {}
difference :: (Ord a) => Set a -> Set a -> Set a
difference s1 Empty = Empty
difference Empty s2 = Empty
difference (Next(x, xs)) s2 =  if member x s2
                                 then fromList [y | y <- toList xs, not (member y s2)]
                              else fromList (x : [y | y <- toList xs, not (member y s2)])

-- is element *a* in the Set?
member :: (Ord a) => a -> Set a -> Bool
member a Empty = False
member a (Next(x, xs))   | x == a = True
                        | otherwise = member a xs


-- how many elements are there in the Set?
cardinality :: Set a -> Int
cardinality = undefined 


setmap :: (Ord b) => (a -> b) -> Set a -> Set b
setmap = undefined


setfoldr :: (a -> b -> b) -> Set a -> b -> b
setfoldr = undefined


-- powerset of a set
-- powerset {1,2} => { {}, {1}, {2}, {1,2} }
powerSet :: Set a -> Set (Set a)
powerSet Empty = Empty

-- cartesian product of two sets
cartesian :: Set a -> Set b -> Set (a, b)
cartesian = undefined


-- partition the set into two sets, with
-- all elements that satisfy the predicate on the left,
-- and the rest on the right
partition :: (a -> Bool) -> Set a -> (Set a, Set a)
partition = undefined



{-
   On Marking:
   Be careful! This coursework will be marked using QuickCheck, against Haskell's own
   Data.Set implementation. Each function will be tested for multiple properties.
   Even one failing test means 0 marks for that function.

   Marks will be lost for too much similarity to the Data.Set implementation.

   Pass: creating the Set type and implementing toList and fromList is enough for a
   passing mark of 40%.

-}
