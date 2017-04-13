import Test.Hspec
import Lib

main = hspec $ do
    describe "evaluation of circuit" $ do
        context "integer literal - '123 -> x'" $ do
            it "returns 'x: 123'" $ do
                let inputString = "123 -> x"

                let result = Lib.run inputString

                result `shouldBe` "x: 123"
