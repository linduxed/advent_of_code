import Test.Hspec
import Five

main = hspec $ do
    describe "isNiceString" $ do
        it "returns True for 'ugknbfddgicrmopn'" $ do
            isNiceString "ugknbfddgicrmopn" `shouldBe` True
        it "returns True for 'aaa'" $ do
            isNiceString "aaa" `shouldBe` True
        it "returns False for 'jchzalrnumimnmhp'" $ do
            isNiceString "jchzalrnumimnmhp" `shouldBe` False
        it "returns False for 'haegwjzuvuyypxyu'" $ do
            isNiceString "haegwjzuvuyypxyu" `shouldBe` False
        it "returns False for 'dvszwmarrgswjxmb'" $ do
            isNiceString "dvszwmarrgswjxmb" `shouldBe` False

    describe "isBetterNiceString" $ do
        it "returns True for 'qjhvhtzxzqqjkmpb'" $ do
            isBetterNiceString "qjhvhtzxzqqjkmpb" `shouldBe` True
        it "returns True for 'xxyxx'" $ do
            isBetterNiceString "xxyxx" `shouldBe` True
        it "returns True for 'uurcxstgymygtbstg'" $ do
            isBetterNiceString "uurcxstgymygtbstg" `shouldBe` True
        it "returns False for 'uurcxstgmygtbstg'" $ do
            isBetterNiceString "uurcxstgmygtbstg" `shouldBe` False
        it "returns False for 'ieodomkazucvgmuy'" $ do
            isBetterNiceString "ieodomkazucvgmuy" `shouldBe` False
        it "returns True for 'sknufchjdvccccta'" $ do
            isBetterNiceString "sknufchjdvccccta" `shouldBe` True
