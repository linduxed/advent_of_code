import Test.Hspec
import Four

main = hspec $ do
    describe "lowestSaltWithLeadingZeroes" $ do
        describe "with 5 zeroes" $ do
            it "returns 609043 for the key 'abcdef'" $ do
                lowestSaltWithLeadingZeroes 5 "abcdef" `shouldBe` 609043
            it "returns 1048970 for the key 'pqrstuv'" $ do
                lowestSaltWithLeadingZeroes 5 "pqrstuv" `shouldBe` 1048970
