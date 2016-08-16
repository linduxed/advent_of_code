import One

main :: IO ()
main = do
    line <- getLine
    let finalFloorNumber = unlines $ map (show . finalFloor) $ lines line
    let basementCharNumber = unlines $ map (show . basementChar) $ lines line
    putStrLn ("Final floor: " ++ finalFloorNumber)
    putStrLn ("Basement at char: " ++ basementCharNumber)
