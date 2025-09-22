defmodule AdventOfCode2015.Day8 do
  def character_count(string) do
    {evaluated_string, _binding} = Code.eval_string(string)

    evaluated_string
    |> String.graphemes()
    |> Enum.count()
  end

  def code_character_count(string) do
    string
    |> String.graphemes()
    |> Enum.count()
  end

  def encode(string) do
    string
    |> String.replace("\\", "\\\\")
    |> String.replace("\"", "\\\"")
    |> then(& "\"" <> &1 <> "\"")
  end

  def part_1(lines) do
    code_character_count_sum =
      lines
      |> Enum.map(&code_character_count/1)
      |> Enum.sum()

    character_count_sum =
      lines
      |> Enum.map(&character_count/1)
      |> Enum.sum()

    code_character_count_sum - character_count_sum
  end

  def part_2(lines) do
    original_character_count_sum =
      lines
      |> Enum.map(&code_character_count/1)
      |> Enum.sum()

    encoded_character_count_sum =
      lines
      |> Enum.map(&encode/1)
      |> Enum.map(&code_character_count/1)
      |> Enum.sum()

    encoded_character_count_sum - original_character_count_sum
  end
end
