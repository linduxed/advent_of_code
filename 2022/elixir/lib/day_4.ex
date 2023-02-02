defmodule AdventOfCode2022.Day4 do
  def part_1(lines) do
    lines
    |> Enum.map(&line_to_group_of_ranges/1)
    |> Enum.map(&ranges_to_sets/1)
    |> Enum.count(&sets_contain_contained_sets?/1)
  end

  def part_2(lines) do
    lines
    |> Enum.map(&line_to_group_of_ranges/1)
    |> Enum.map(&ranges_to_sets/1)
    |> Enum.count(&sets_contain_overlapping_sets?/1)
  end

  defp line_to_group_of_ranges(line) do
    line
    |> String.split(",")
    |> Enum.map(fn range_description ->
      range_description
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> then(fn [first, last] ->
        Range.new(first, last)
      end)
    end)
  end

  defp ranges_to_sets(ranges) do
    Enum.map(ranges, &MapSet.new/1)
  end

  defp sets_contain_contained_sets?(sets) do
    sets_contain_sets_by?(sets, &MapSet.subset?/2)
  end

  defp sets_contain_overlapping_sets?(sets) do
    sets_contain_sets_by?(sets, &(not MapSet.disjoint?(&1, &2)))
  end

  defp sets_contain_sets_by?(sets, filter_fun) do
    sets_with_indices = Enum.with_index(sets)

    subsets =
      for {set_a, a} <- sets_with_indices,
          {set_b, b} <- sets_with_indices,
          a != b,
          filter_fun.(set_a, set_b) do
        set_a
      end

    Enum.count(subsets) > 0
  end
end
