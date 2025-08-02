defmodule AdventOfCode2015.Day7Test do
  use ExUnit.Case
  require ExUnitProperties

  alias AdventOfCode2015.Day7

  describe "circuit_description_to_circuit/1" do
    test "parses a circuit and returns a map with wire name and output" do
      lines =
        """
        123 -> x
        456 -> y
        x AND y -> d
        x OR y -> e
        x LSHIFT 2 -> f
        y RSHIFT 2 -> g
        NOT x -> h
        NOT y -> i
        """
        |> String.split("\n", trim: true)

      assert Day7.circuit_description_to_circuit(lines) ==
               %{
                 "d" => {:and, "x", "y"},
                 "e" => {:or, "x", "y"},
                 "f" => {:lshift, "x", "2"},
                 "g" => {:rshift, "y", "2"},
                 "h" => {:not, "x"},
                 "i" => {:not, "y"},
                 "x" => {:literal, "123"},
                 "y" => {:literal, "456"}
               }
    end
  end

  describe "part_1/1" do
    test "parses a circuit, then follows wire 'a'" do
      lines =
        """
        123 -> a
        456 -> y
        a AND y -> d
        a OR y -> e
        a LSHIFT 2 -> f
        y RSHIFT 2 -> g
        NOT a -> h
        NOT y -> i
        """
        |> String.split("\n", trim: true)

      assert Day7.part_1(lines) == 123
    end
  end
end
