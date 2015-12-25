import Five (isNiceString, isBetterNiceString)

main :: IO ()
main = do
    input <- getContents
    let totalNiceStrings = length $ filter id $ map isNiceString $ lines input
    let totalBetterNiceStrings = length $ filter id $ map isBetterNiceString $ lines input
    putStrLn ("Number of nice strings: " ++ show totalNiceStrings)
    putStrLn ("Number of even nicer strings: " ++ show totalBetterNiceStrings)
