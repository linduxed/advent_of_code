defmodule AdventOfCode2020.Day4Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2022.Day4

  @lines [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8"
  ]

  describe "part_1/1" do
    test "calculate how many range pairs have one of the two fully contained" do
      assert Day4.part_1(@lines) == 2
    end
  end

  describe "part_2/1" do
    test "calculate how many range pairs have any overlap" do
      assert Day4.part_2(@lines) == 4
    end
  end
end
