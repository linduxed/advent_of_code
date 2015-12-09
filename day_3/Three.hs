module Three where

import Data.List (nub, partition)
import Prelude hiding (Left, Right)

data Coordinate = Coordinate Int Int deriving (Eq)
data Direction = Left | Right | Up | Down deriving (Show)

regularSantaDelivery :: String -> Int
regularSantaDelivery xs = length $ nub $ delivery allDirections where
    allDirections = map charToDir xs

duoSantaDelivery :: String -> Int
duoSantaDelivery xs = length $ nub $ ((delivery santaDirs) ++ (delivery roboDirs)) where
    dirs = map charToDir xs
    (santaDirs, roboDirs) = splitOnEverySecond dirs

delivery :: [Direction] -> [Coordinate]
delivery dirs = scanl move startingCoord dirs where
    startingCoord = Coordinate 0 0

charToDir :: Char -> Direction
charToDir char = case char of
    '<' -> Left
    '>' -> Right
    '^' -> Up
    'v' -> Down

move :: Coordinate -> Direction -> Coordinate
move (Coordinate x y) dir = case dir of
    Left  -> Coordinate (x-1) y
    Right -> Coordinate (x+1) y
    Up    -> Coordinate x (y+1)
    Down  -> Coordinate x (y-1)

splitOnEverySecond :: [a] -> ([a], [a])
splitOnEverySecond xs = (map snd as, map snd bs) where
    zipped = zip (cycle [True, False]) xs
    (as, bs) = partition fst zipped
