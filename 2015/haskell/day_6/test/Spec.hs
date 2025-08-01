import Test.Hspec
import qualified Data.Array.Unboxed as U
import qualified Lib as L

main = hspec $ do
    describe "transformGridWithInstructions" $ do
        context "using the Boolean light mode" $ do
            context "with a 6x6 grid with only turned off lights" $ do
                context "with an instruction to toggle the upper left corner" $ do
                    it "returns a grid with a corner of turned on lights" $ do
                        let cornerCoordinates = (L.Coordinate 0 0, L.Coordinate 5 5)
                            startingGridOfLights =
                                U.listArray cornerCoordinates (repeat 0)
                            cornerTurnedOnGrid =
                                U.listArray cornerCoordinates
                                    [1, 1, 1, 0, 0, 0,
                                     1, 1, 1, 0, 0, 0,
                                     1, 1, 1, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0]
                            instruction = L.Instruction
                                { L.name = "toggle"
                                , L.mutationName = L.Toggle
                                , L.firstCoordinate = L.Coordinate 0 0
                                , L.secondCoordinate = L.Coordinate 2 2
                                }

                        let resultBooleanGrid = L.transformGridWithInstructions
                                L.Boolean
                                startingGridOfLights
                                [instruction]

                        resultBooleanGrid `shouldBe` cornerTurnedOnGrid

        context "using the Incremental light mode" $ do
            context "with a 6x6 grid with only turned off lights" $ do
                context "with two instructions to turn on the upper left corner" $ do
                    it "returns a grid with a corner of 'second level' lights" $ do
                        let cornerCoordinates = (L.Coordinate 0 0, L.Coordinate 5 5)
                            startingGridOfLights =
                                U.listArray cornerCoordinates (repeat 0)
                            cornerTurnedOnGrid =
                                U.listArray cornerCoordinates
                                    [2, 2, 2, 0, 0, 0,
                                     2, 2, 2, 0, 0, 0,
                                     2, 2, 2, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0,
                                     0, 0, 0, 0, 0, 0]
                            instructions =
                                [ L.Instruction { L.name = "turn on"
                                                , L.mutationName = L.TurnOn
                                                , L.firstCoordinate = L.Coordinate 0 0
                                                , L.secondCoordinate = L.Coordinate 2 2
                                                }
                                , L.Instruction { L.name = "turn on"
                                                , L.mutationName = L.TurnOn
                                                , L.firstCoordinate = L.Coordinate 0 0
                                                , L.secondCoordinate = L.Coordinate 2 2
                                                }
                                ]

                        let resultBooleanGrid = L.transformGridWithInstructions
                                L.Incremental
                                startingGridOfLights
                                instructions

                        resultBooleanGrid `shouldBe` cornerTurnedOnGrid
