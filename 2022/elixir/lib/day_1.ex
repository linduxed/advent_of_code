defmodule AdventOfCode2022.Day1 do
  def part_one(lines) do
    lines
    |> number_lines_to_integer_groups()
    |> Enum.max_by(&Enum.sum/1)
    |> Enum.sum()
  end

  def part_two(lines) do
    lines
    |> number_lines_to_integer_groups()
    |> Enum.sort_by(&Enum.sum/1, :desc)
    |> Enum.take(3)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  defp number_lines_to_integer_groups(lines) do
    lines
    |> Enum.map(fn line ->
      if line == "" do
        :separator
      else
        String.to_integer(line)
      end
    end)
    |> Enum.chunk_by(& &1 == :separator)
    |> Enum.reject(& &1 == [:separator])
  end
end
