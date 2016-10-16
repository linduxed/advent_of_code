import Test.Hspec
import One

main :: IO ()
main = hspec $ do
    describe "finalFloor" $ do
        it "returns 0 on an empty string" $ do
            finalFloor "" `shouldBe` 0

        it "returns -1 for one right paren" $ do
            finalFloor ")" `shouldBe` (-1)

        it "returns 1 for one left paren" $ do
            finalFloor "(" `shouldBe` 1

        it "returns 0 for '()'" $ do
            finalFloor "()" `shouldBe` 0

        it "returns 3 for '(()(()('" $ do
            finalFloor "(()(()(" `shouldBe` 3

    describe "basementChar" $ do
        it "returns 1 on ')'" $ do
            basementChar ")" `shouldBe` 1

        it "returns 5 on '()())'" $ do
            basementChar "()())" `shouldBe` 5
