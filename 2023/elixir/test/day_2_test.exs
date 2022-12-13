defmodule AdventOfCode2020.Day2Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2023.Day2

  @lines [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

  describe "part_1/1" do
    test "sums the game numbers of games that contain less-than-or-equal to " <>
           "12 red cubes, 13 green cubes, and 14 blue cubes" do
      assert Day2.part_1(@lines) == 8
    end
  end

  describe "part_2/1" do
    test "sums for each game the products of the minimum required amounts of " <>
           "dice from each color" do
      assert Day2.part_2(@lines) == 2286
    end
  end
end
