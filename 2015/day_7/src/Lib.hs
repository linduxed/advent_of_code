module Lib (run) where

import Data.Word (Word16(..))
import Data.Char (isDigit)
import qualified Text.ParserCombinators.ReadP as RP

type Identifer = String
data Gate = Literal Word16
type Circuit = Map Identifer Gate
type Wire = (Gate, Identifier)

run :: String -> String
run = eval . parse

eval = undefined

parse :: String -> Circuit
parse _ = undefined

parseDigit :: ReadP Char
parseDigit = RP.satisfy isDigit

parseWord16 :: ReadP Word16
parseWord16 = fmap read $ RP.some parseDigit

parseLiteral :: ReadP Gate
parseLiteral = fmap Literal parseWord16
