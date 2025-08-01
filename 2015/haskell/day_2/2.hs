import Two

main :: IO ()
main = do
    input <- getContents
    let totalPaper = getTotal boxPaper input
    let totalRibbon = getTotal boxRibbon input
    putStrLn ("Total area of paper: " ++ totalPaper)
    putStrLn ("Total length of ribbon: " ++ totalRibbon)
    where
        getTotal f input = show $ sum $ map f $ lines input
