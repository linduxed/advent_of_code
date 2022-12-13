defmodule AdventOfCode2022 do
  def read_input_for_day(day_number, opts \\ []) do
    "input/day_#{day_number}.txt"
    |> File.read!()
    |> String.split("\n", trim: opts[:trim])
  end
end
