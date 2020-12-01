defmodule AdventOfCode2020.Day1Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2020.Day1

  describe "part_one/2" do
    test "finds two numbers with a provided sum and returns their product" do
      numbers = [1, 20, 300, 4000]

      assert Day1.part_one(numbers, 4001) == 4000
      assert Day1.part_one(numbers, 4020) == 80_000
    end
  end

  describe "part_two/2" do
    test "finds three numbers with a provided sum and returns their product" do
      numbers = [1, 20, 300, 4000]

      assert Day1.part_two(numbers, 4301) == 1_200_000
      assert Day1.part_two(numbers, 4021) == 80_000
    end
  end
end
