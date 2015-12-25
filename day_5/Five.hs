module Five (isNiceString, isBetterNiceString) where

isNiceString :: String -> Bool
isNiceString xs = all ($ xs) [ hasThreeVowels
                             , hasDuplicateLetterSequences
                             , doesNotHaveBannedSequences ]

isBetterNiceString :: String -> Bool
isBetterNiceString xs = all ($ xs) [ hasNonOverlappingPairs
                                   , hasSandwichedLetter ]

hasThreeVowels :: String -> Bool
hasThreeVowels xs = 3 <= (length $ foldr isVowel [] xs) where
    isVowel letter acc
        | letter `elem` "aeiou" = letter:acc
        | otherwise             = acc

hasDuplicateLetterSequences :: String -> Bool
hasDuplicateLetterSequences = twoElementMatching (==)

doesNotHaveBannedSequences :: String -> Bool
doesNotHaveBannedSequences xs = not $ twoElementMatching inBannedSequences xs where
    inBannedSequences = (\a b -> any ((a:[b]) ==) ["ab", "cd", "pq", "xy"])

hasNonOverlappingPairs :: String -> Bool
hasNonOverlappingPairs [] = False
hasNonOverlappingPairs [_] = False
hasNonOverlappingPairs (a:b:xs)
    | (a, b) `elem` followingPairs xs = True
    | otherwise = hasNonOverlappingPairs (b:xs)
    where followingPairs xs' = zip xs' (tail xs')

hasSandwichedLetter :: String -> Bool
hasSandwichedLetter []     = False
hasSandwichedLetter [_]    = False
hasSandwichedLetter [_, _] = False
hasSandwichedLetter (a:b:c:xs)
    | a == c    = True
    | otherwise = hasSandwichedLetter (b:c:xs)

twoElementMatching :: (a -> a -> Bool) -> [a] -> Bool
twoElementMatching f xs = go xs where
    go []  = False
    go [_] = False
    go (a:b:cs)
        | f a b     = True
        | otherwise = go (b:cs)
