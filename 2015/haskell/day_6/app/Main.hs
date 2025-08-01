module Main where

import qualified Lib as L
import qualified InstructionParser

import Data.List (intercalate)
import qualified Data.Array.Unboxed as U
import qualified Data.Either as E

main :: IO ()
main = do
    input <- getContents

    let startingGridOfLights = L.turnedOffGridOfLights 1000
        parsedInstructions = map InstructionParser.instruction $ lines input
        (leftInstructions, rightInstructions) = E.partitionEithers parsedInstructions

    if not $ null leftInstructions
       then error $ intercalate " | " $ map show leftInstructions
       else do
        let resultBooleanGrid =
                L.transformGridWithInstructions L.Boolean startingGridOfLights rightInstructions
            resultIncrementalGrid =
                L.transformGridWithInstructions L.Incremental startingGridOfLights rightInstructions
            totalTurnedOnLights = sum $ U.elems resultBooleanGrid
            totalBrightness     = sum $ U.elems resultIncrementalGrid

        putStrLn ("Turned on lights: " ++ show totalTurnedOnLights)
        putStrLn ("Brightness: " ++ show totalBrightness)
