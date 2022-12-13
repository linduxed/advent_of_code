defmodule AdventOfCode2020.Day1Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2023.Day1

  describe "part_1/1" do
    test "find the sum of the numbers formed on each line by the first and " <>
           "last digit" do
      lines = ~w(
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
      )

      assert Day1.part_1(lines) == 142
    end
  end

  describe "part_2/1" do
    test "handles lines with overlapping words" do
      lines = ["eightwothree"]

      assert Day1.part_2(lines) == 83
    end

    test "find the sum of the groups of numbers that add up to the top three " <>
           "greatest sums" do
      lines = ~w(
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
      )

      assert Day1.part_2(lines) == 281
    end
  end
end
