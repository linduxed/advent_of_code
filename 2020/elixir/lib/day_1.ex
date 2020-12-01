defmodule AdventOfCode2020.Day1 do
  def part_one(numbers, sum) do
    numbers
    |> Enum.flat_map(fn num ->
      Enum.map(numbers, &{num, &1})
    end)
    |> Enum.reject(fn {a, b} -> a == b end)
    |> Enum.find(fn {a, b} -> a + b == sum end)
    |> case do
      {a, b} -> a * b
      nil -> nil
    end
  end

  def part_two(numbers, sum) do
    for a <- numbers,
        b <- numbers,
        c <- numbers,
        a != b,
        b != c,
        a != c,
        a + b + c == sum do
      Enum.sort([a, b, c])
    end
    |> Enum.uniq()
    |> case do
      [[a, b, c]] -> a * b * c
      d -> d
    end
  end
end
