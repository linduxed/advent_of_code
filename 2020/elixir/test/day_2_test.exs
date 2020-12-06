defmodule AdventOfCode2020.Day2Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2020.Day2

  describe "password_valid_by_letter_count?/1" do
    test "returns whether a password is valid by indicated letter count" do
      assert Day2.password_valid_by_letter_count?("1-3 a: abcde") == true
      assert Day2.password_valid_by_letter_count?("1-3 b: cdefg") == false
      assert Day2.password_valid_by_letter_count?("2-9 c: ccccccccc") == true
    end
  end

  describe "password_valid_by_letter_position?/1" do
    test "returns whether a password is valid by letters on positions" do
      assert Day2.password_valid_by_letter_positions?("1-3 a: abcde") == true
      assert Day2.password_valid_by_letter_positions?("1-3 b: cdefg") == false
      assert Day2.password_valid_by_letter_positions?("2-9 c: ccccccccc") == false
    end
  end

  describe "part_one/2" do
    test "returns how many passwords are valid according to their policies" do
      input_lines = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-9 c: ccccccccc"
      ]

      assert Day2.part_one(input_lines) == 2
    end
  end

  describe "part_two/2" do
    test "returns how many passwords are valid according to their policies" do
      input_lines = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-3 c: accb",
        "3-4 c: abcd"
      ]

      assert Day2.part_one(input_lines) == 2
    end
  end
end
