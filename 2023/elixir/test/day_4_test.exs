defmodule AdventOfCode2020.Day4Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2023.Day4
  alias AdventOfCode2023.Day4.Card

  describe "line_to_card/1" do
    test "convert line to card struct" do
      line = "Card  10: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

      assert Day4.line_to_card(line) == %Card{
               card_index: 10,
               selected_numbers: [83, 86, 6, 31, 17, 9, 48, 53],
               winning_numbers: [41, 48, 83, 86, 17]
             }
    end
  end

  describe "card_to_points/1" do
    test "returns 2 to the power of the amount of matching numbers" do
      card = %Card{
        card_index: 1,
        selected_numbers: [83, 86, 6, 31, 17, 9, 48, 53],
        winning_numbers: [41, 48, 83, 86, 17]
      }

      assert Day4.card_to_points(card) == 8

      card = %Card{
        card_index: 2,
        selected_numbers: [61, 68, 82, 32],
        winning_numbers: [13, 32, 61]
      }

      assert Day4.card_to_points(card) == 2

      card = %Card{
        card_index: 6,
        selected_numbers: [74, 77, 10, 23, 35, 67, 36, 11],
        winning_numbers: [31, 18, 13, 56, 72, 12, 13, 14]
      }

      assert Day4.card_to_points(card) == 0
    end
  end

  describe "part_1/1" do
    test "returns sum of points for winning numbers for all cards" do
      lines =
        """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """
        |> String.split("\n", trim: true)

      assert Day4.part_1(lines) == 13
    end
  end

  describe "part_2/1" do
    test "returns sum of all recursively accumulated scratchcards" do
      lines =
        """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """
        |> String.split("\n", trim: true)

      assert Day4.part_2(lines) == 30
    end
  end
end
