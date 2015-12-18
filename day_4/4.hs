import Four

main :: IO ()
main = do
    input <- getLine
    putStrLn ("Lowest 5-zero number: "
             ++ show (lowestSaltWithLeadingZeroes 5 input))
    putStrLn ("Lowest 6-zero number: "
             ++ show (lowestSaltWithLeadingZeroes 6 input))
