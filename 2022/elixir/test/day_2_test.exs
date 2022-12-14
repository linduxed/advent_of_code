defmodule AdventOfCode2020.Day2Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2022.Day2

  @lines [
    "A Y",
    "B X",
    "C Z"
  ]

  describe "part_1/1" do
    test "calculates total score of rock-paper-scissors instructions" do
      assert Day2.part_1(@lines) == 15
    end
  end

  describe "part_2/1" do
    test "calculates total score of rock-paper-scissors instructions" do
      assert Day2.part_2(@lines) == 12
    end
  end
end
