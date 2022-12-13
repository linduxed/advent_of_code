defmodule AdventOfCode2020.Day1Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2022.Day1

  @lines [
        "1000",
        "2000",
        "3000",
        "",
        "4000",
        "",
        "5000",
        "6000",
        "",
        "7000",
        "8000",
        "9000",
        "",
        "10000"
      ]

  describe "part_one/1" do
    test "find the sum of the group of numbers that adds up to the " <>
           "greatest sum" do
      assert Day1.part_one(@lines) == 24000
    end
  end

  describe "part_two/1" do
    test "find the sum of the groups of numbers that add up to the top " <>
           "three greatest sums" do
      assert Day1.part_two(@lines) == 45000
    end
  end
end
