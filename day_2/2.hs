import Two

main :: IO ()
main = do
    input <- getContents
    let totalPaper = show $ sum $ map boxPaper $ lines input
    let totalRibbon = show $ sum $ map boxRibbon $ lines input
    putStrLn ("Total area of paper: " ++ totalPaper)
    putStrLn ("Total length of ribbon: " ++ totalRibbon)
