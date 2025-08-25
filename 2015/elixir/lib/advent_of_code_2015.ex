defmodule AdventOfCode2015 do
  def read_input_for_day(day_number, opts \\ []) do
    trim? = opts[:trim] || true

    "input/day_#{day_number}.txt"
    |> File.read!()
    |> String.split("\n", trim: trim?)
  end
end
