{-# LANGUAGE RankNTypes #-}

module Lib (
    LightMode(..),
    Coordinate(..),
    Instruction(..),
    MutationName(..),
    turnedOffGridOfLights,
    transformGridWithInstructions,
) where

import Control.Monad
import qualified Control.Monad.ST as ST
import qualified Data.Array.Unboxed as U
import qualified Data.Array.ST as S
import Data.Ix

type Light = Int
type Grid = U.UArray Coordinate Light
type STGrid s = S.STUArray s Coordinate Light
type Mutation = forall s. STGrid s -> Coordinate -> ST.ST s ()

data MutationName = TurnOn | TurnOff | Toggle
data LightMode = Boolean | Incremental
data Coordinate = Coordinate { x :: Int, y :: Int } deriving (Eq, Ord, Ix, Show)
data Instruction = Instruction
    { name             :: String
    , mutationName     :: MutationName
    , firstCoordinate  :: Coordinate
    , secondCoordinate :: Coordinate
    }

instance Show Instruction where show = name

turnedOffGridOfLights :: Int -> Grid
turnedOffGridOfLights gridSize =
    U.listArray (Coordinate 0 0, Coordinate (gridSize - 1) (gridSize - 1)) (repeat 0)

transformGridWithInstructions :: LightMode -> Grid -> [Instruction] -> Grid
transformGridWithInstructions mode origGrid instructions = S.runSTUArray $ do
    mutableGrid <- S.thaw origGrid

    let coordinatesToMutate instruction =
            rectangleOfCoordinates (firstCoordinate instruction) (secondCoordinate instruction)
        mutationToApply instruction = mutationNameToMutation mode (mutationName instruction)

    forM_ instructions (\i ->
        mapM_ ((mutationToApply i) mutableGrid) (coordinatesToMutate i)
        )

    return mutableGrid

turnOn :: Mutation
turnOn mutableGrid coordinate = S.writeArray mutableGrid coordinate 1

turnOff :: Mutation
turnOff mutableGrid coordinate = S.writeArray mutableGrid coordinate 0

toggle :: Mutation
toggle mutableGrid coordinate = do
    light <- S.readArray mutableGrid coordinate
    S.writeArray mutableGrid coordinate (if light == 0 then 1 else 0)

increment :: Mutation
increment mutableGrid coordinate = do
    light <- S.readArray mutableGrid coordinate
    S.writeArray mutableGrid coordinate (light + 1)

incrementTwice :: Mutation
incrementTwice mutableGrid coordinate = do
    light <- S.readArray mutableGrid coordinate
    S.writeArray mutableGrid coordinate (light + 2)

decrement :: Mutation
decrement mutableGrid coordinate = do
    light <- S.readArray mutableGrid coordinate
    S.writeArray mutableGrid coordinate (if light > 0 then light - 1 else light)

mutationNameToMutation :: LightMode -> MutationName -> Mutation
mutationNameToMutation Boolean     TurnOn  = turnOn
mutationNameToMutation Boolean     TurnOff = turnOff
mutationNameToMutation Boolean     Toggle  = toggle
mutationNameToMutation Incremental TurnOn  = increment
mutationNameToMutation Incremental TurnOff = decrement
mutationNameToMutation Incremental Toggle  = incrementTwice

rectangleOfCoordinates :: Coordinate -> Coordinate -> [Coordinate]
rectangleOfCoordinates ca cb = [ Coordinate { x = cx, y = cy }
                               | cx <- [(x ca)..(x cb)]
                               , cy <- [(y ca)..(y cb)]
                               ]
