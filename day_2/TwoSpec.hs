import Test.Hspec
import Two

main :: IO ()
main = hspec $ do
    describe "boxPaper" $ do
        it "returns 58 for a '2x3x4' box" $ do
            boxPaper "2x3x4" `shouldBe` 58

        it "returns 43 for a '1x1x10' box" $ do
            boxPaper "1x1x10" `shouldBe` 43

    describe "boxRibbon" $ do
        it "returns 34 for '2x3x4'" $ do
            boxRibbon "2x3x4" `shouldBe` 34

        it "returns 14 for '1x1x10'" $ do
            boxRibbon "1x1x10" `shouldBe` 14
