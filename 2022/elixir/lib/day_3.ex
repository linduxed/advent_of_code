defmodule AdventOfCode2022.Day3.LetterPriorities do
  def priorities(letter_case)
      when letter_case in [:lowercase, :uppercase] do
    letters = letters_for_case(letter_case)
    number_range = number_range_for_case(letter_case)

    Enum.zip(letters, number_range)
  end

  defp letters_for_case(letter_case)
       when letter_case in [:lowercase, :uppercase] do
    letter_case
    |> range_for_letter_case()
    |> char_range_to_letter_strings()
  end

  defp number_range_for_case(:lowercase), do: 1..26
  defp number_range_for_case(:uppercase), do: 27..52

  defp char_range_to_letter_strings(char_range) do
    IO.puts("In MACRO function")

    char_range
    |> Enum.to_list()
    |> List.to_string()
    |> String.codepoints()
  end

  defp range_for_letter_case(:lowercase), do: ?a..?z
  defp range_for_letter_case(:uppercase), do: ?A..?Z

  defmacro priority_map do
    quote do
      alias AdventOfCode2022.Day3.LetterPriorities

      lowercase_priorities = LetterPriorities.priorities(:lowercase)
      uppercase_priorities = LetterPriorities.priorities(:uppercase)

      Enum.into(lowercase_priorities ++ uppercase_priorities, %{})
    end
  end
end

defmodule AdventOfCode2022.Day3 do
  alias __MODULE__.LetterPriorities
  require LetterPriorities

  @priority_map LetterPriorities.priority_map()

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
    Map.fetch!(@priority_map, item)
  end
end
