defmodule AdventOfCode2022.Day3 do
  def part_1(lines) do
    lines
    |> Enum.map(&string_to_2_compartment_rucksack/1)
    |> Enum.map(&rucksack_to_common_item/1)
    |> Enum.map(&common_item_to_priority/1)
    |> Enum.sum()
  end

  def part_2(lines) do
    lines
    |> Enum.chunk_every(3)
    |> Enum.map(&group_of_rucksacks_to_common_item/1)
    |> Enum.map(&common_item_to_priority/1)
    |> Enum.sum()
  end

  defp string_to_2_compartment_rucksack(string) do
    letters = String.codepoints(string)
    compartment_size = div(length(letters), 2)

    Enum.split(letters, compartment_size)
  end

  defp rucksack_to_common_item(_rucksack = {left_compartment, right_compartment}) do
    left_set = MapSet.new(left_compartment)
    right_set = MapSet.new(right_compartment)

    [item] = MapSet.intersection(left_set, right_set) |> Enum.to_list()
    item
  end

  defp group_of_rucksacks_to_common_item(group_of_rucksacks) do
    [item] =
      group_of_rucksacks
      |> Enum.map(&String.codepoints/1)
      |> Enum.map(&MapSet.new/1)
      |> Enum.reduce(fn rucksack_intersection_acc, rucksack_set ->
        MapSet.intersection(rucksack_intersection_acc, rucksack_set)
      end)
      |> Enum.to_list()

    item
  end

  defp common_item_to_priority(item) do
    Map.fetch!(priority_map(), item)
  end

  defp priority_map() do
    lowercase_letters = char_range_to_letter_strings(?a..?z)
    uppercase_letters = char_range_to_letter_strings(?A..?Z)
    lowercase_priorities = Enum.zip(lowercase_letters, 1..26)
    uppercase_priorities = Enum.zip(uppercase_letters, 27..52)

    Enum.into(lowercase_priorities ++ uppercase_priorities, %{})
  end

  defp char_range_to_letter_strings(char_range) do
    char_range
    |> Enum.to_list()
    |> List.to_string()
    |> String.codepoints()
  end
end
