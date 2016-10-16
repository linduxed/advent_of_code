import Test.Hspec
import Three

main = hspec $ do
    describe "regularSantaDelivery" $ do
        it "returns 2 for '>'" $ do
            regularSantaDelivery ">" `shouldBe` 2
        it "returns 4 for '^>v<'" $ do
            regularSantaDelivery "^>v<" `shouldBe` 4
        it "returns 2 for '^v^v^v^v'" $ do
            regularSantaDelivery "^v^v^v^v" `shouldBe` 2

    describe "duoSantaDelivery" $ do
        it "returns 3 for '^v'" $ do
            duoSantaDelivery "^v" `shouldBe` 3
        it "returns 3 for '^>v<'" $ do
            duoSantaDelivery "^>v<" `shouldBe` 3
        it "returns 11 for '^v^v^v^v^v'" $ do
            duoSantaDelivery "^v^v^v^v^v" `shouldBe` 11
