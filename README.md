# COMP0002-Haskell-Coursework

Your task is to design a datatype that represents the mathematical concept of a (finite) set of elements (of the same type).
We have provided you with an interface (do not change this!) but you will need to design the datatype and also support the required functions over sets.
Any functions you write should maintain the following invariant: no duplication of set elements.
There are lots of different ways to implement a set. The easiest is to use a list (as in the example below). Alternatively, one could use an algebraic data
type, or wrap a binary search tree. Extra marks will be awarded for efficient implementations if appropriate. You are NOT allowed to import anything from
the standard library or other libraries. Your edit of this file should be completely self-contained. DO NOT change the type signatures of the functions
below: if you do, we will not be able to test them and you will get 0% for that part. While sets are unordered collections, we have included the Ord
constraint on most signatures: this is to make testing easier.
