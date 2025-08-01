module Two where

import Data.List (tails, sort)
import Data.List.Split (wordsBy)

boxPaper :: String -> Int
boxPaper xs = smallestSide + (sum $ map (*2) sides)
  where
    sides = [ x * y | (x:xs) <- tails lengths, y <- xs ]
    lengths = stringToLengths xs
    smallestSide = minimum sides

stringToLengths :: String -> [Int]
stringToLengths xs = map read $ wordsBy (== 'x') xs

boxRibbon :: String -> Int
boxRibbon xs = (sum $ map (*2) twoShortestSides) + (product lengths)
  where
    twoShortestSides = init $ sort lengths
    lengths = stringToLengths xs
