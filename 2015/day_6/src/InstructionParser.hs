module InstructionParser (
    instruction
) where

import qualified Lib as L
import Text.Parsec
import Text.Parsec.String
import Data.List (isPrefixOf)

instruction :: String -> Either ParseError L.Instruction
instruction = parse parser "instruction"

parser :: Parser L.Instruction
parser = do
    inst <- try (string "turn on") <|> try (string "turn off") <|> string "toggle"
    _    <- space
    cax  <- many1 digit
    _    <- char ','
    cay  <- many1 digit
    _    <- space
    _    <- string "through"
    _    <- space
    cbx  <- many1 digit
    _    <- char ','
    cby  <- many1 digit

    return L.Instruction { L.name = inst
                         , L.mutationName = strToMut inst
                         , L.firstCoordinate = L.Coordinate (int cax) (int cay)
                         , L.secondCoordinate = L.Coordinate (int cbx) (int cby)
                         }
        where int stringInt = read stringInt :: Int

strToMut :: String -> L.MutationName
strToMut xs
    | "turn on"  `isPrefixOf` xs = L.TurnOn
    | "turn off" `isPrefixOf` xs = L.TurnOff
    | "toggle"   `isPrefixOf` xs = L.Toggle
    | otherwise                  = error "Malformed instruction"
