defmodule AdventOfCode2020.Day3Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2022.Day3

  @lines [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",
    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw"
  ]

  describe "part_1/1" do
    test "calculates sum of the priorities of items present in " <>
           "both compartments" do
      assert Day3.part_1(@lines) == 157
    end
  end

  describe "part_2/1" do
    test "calculates the sum of the priorities of the three-line shared " <>
           "item priorities" do
      assert Day3.part_2(@lines) == 70
    end
  end
end
