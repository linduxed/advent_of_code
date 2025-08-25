defmodule AdventOfCode2015.Day8Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2015.Day8

  describe "code_character_count/1" do
    for {string, expected} <- [
          {~S(""), 2},
          {~S("aaa"), 5},
          {~S("aaa\"aaa"), 10},
          {~S("\x27"), 6}
        ] do
      test "#{string}" do
        assert Day8.code_character_count(unquote(string)) == unquote(expected)
      end
    end
  end

  describe "character_count/1" do
    for {string, expected} <- [
          {~S(""), 0},
          {~S("aaa"), 3},
          {~S("aaa\"aaa"), 7},
          {~S("\x27"), 1}
        ] do
      test "#{string}" do
        assert Day8.character_count(unquote(string)) == unquote(expected)
      end
    end
  end

  describe "part_1/1" do
    test "returns total amount of code characters minus characters in text" do
      lines =
        [
          ~S(""),
          ~S("aaa"),
          ~S("aaa\"aaa"),
          ~S("\x27")
        ]

      assert Day8.part_1(lines) == 12
    end
  end
end
