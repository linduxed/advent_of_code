import Three (regularSantaDelivery, duoSantaDelivery)

main :: IO ()
main = do
    input <- getLine
    putStrLn ("Houses with presents (Santa): " ++ show (regularSantaDelivery input))
    putStrLn ("Houses with presents (Duo): " ++ show (duoSantaDelivery input))
