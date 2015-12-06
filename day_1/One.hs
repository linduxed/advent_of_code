module One where

finalFloor :: String -> Int
finalFloor "" = 0
finalFloor xs = foldr upOrDown 0 xs

upOrDown :: Char -> Int -> Int
upOrDown ')' floor = floor - 1
upOrDown '(' floor = floor + 1
upOrDown _ _ = error "Not a paren."

basementChar :: String -> Int
basementChar "" = 0
basementChar xs = incrIfNotBasement xs 0 0 where
    incrIfNotBasement [] _ _ = 0
    incrIfNotBasement (paren:parens) currFloor acc
        | move < 0 = acc + 1
        | move >= 0 = incrIfNotBasement parens move (acc + 1)
        where
            move = upOrDown paren currFloor
