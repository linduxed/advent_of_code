defmodule AdventOfCode2020.Day2 do
  def password_valid_by_letter_count?(password_string) do
    {minimum, maximum, letter, password} = extract_data_from_password_string(password_string)

    letter_count =
      password
      |> String.graphemes()
      |> Enum.filter(&(&1 == letter))
      |> Enum.count()

    letter_count >= minimum and
      letter_count <= maximum
  end

  def password_valid_by_letter_positions?(password_string) do
    {first_number, second_number, letter, password} =
      extract_data_from_password_string(password_string)

    password_letters = String.graphemes(password)

    letters_present_at_expected_position =
      [first_number, second_number]
      |> Enum.map(&letter_present_at_position?(password_letters, letter, &1))
      |> Enum.count(& &1)

    letters_present_at_expected_position == 1
  end

  def part_one(input_lines) do
    Enum.count(input_lines, &password_valid_by_letter_count?/1)
  end

  def part_two(input_lines) do
    Enum.count(input_lines, &password_valid_by_letter_positions?/1)
  end

  defp extract_data_from_password_string(password_string) do
    [range, letter, password] = String.split(password_string)
    [first_number, second_number] = String.split(range, "-")

    first_number = String.to_integer(first_number)
    second_number = String.to_integer(second_number)

    letter = String.replace(letter, ":", "")

    {first_number, second_number, letter, password}
  end

  defp letter_present_at_position?(password_letters, letter, position) do
    # Account for 1-indexing of input data
    adjusted_position = position - 1

    letter == Enum.at(password_letters, adjusted_position)
  end
end
