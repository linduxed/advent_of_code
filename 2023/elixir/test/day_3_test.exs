defmodule AdventOfCode2020.Day3Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2023.Day3

  describe "part_1/1" do
    test "returns sum of numbers adjacent to symbols in a 2d-matrix" do
      lines =
        """
          467..114..
          ...*......
          ..35..633.
          ......#...
          617*......
          .....+.58.
          ..592.....
          ......755.
          ...$.*....
          .664.598..
        """
        |> String.split()

      assert Day3.part_1(lines) == 4361
    end
  end

  describe "part_2/1" do
    test "returns sum of all products of gear-pair-numbers (2 numbers " <>
           "adjacent to the same *) in a 2d-matrix" do
      lines =
        """
          467..114..
          ...*......
          ..35..633.
          ......#...
          617*......
          .....+.58.
          ..592.....
          ......755.
          ...$.*....
          .664.598..
        """
        |> String.split()

      assert Day3.part_2(lines) == 467835
    end
  end
end
