defmodule AdventOfCode2023.Day1 do
  @digits 0..9
  @digit_strings @digits |> Enum.map(&Integer.to_string/1)

  def part_1(lines) do
    lines
    |> Enum.map(fn line ->
      line
      |> String.codepoints()
      |> Enum.filter(&(&1 in @digit_strings))
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(&join_last_and_first_number/1)
    |> Enum.sum()
  end

  def part_2(lines) do
    digit_string_translations = Enum.zip(@digit_strings, @digits) |> Enum.into(%{})

    number_words = ~w(zero one two three four five six seven eight nine)
    number_word_translations = Enum.zip(number_words, @digits) |> Enum.into(%{})

    number_string_translations =
      Map.merge(
        digit_string_translations,
        number_word_translations
      )

    digit_strings_or_number_words = Map.keys(number_string_translations)

    lines
    |> Enum.map(fn line ->
      line
      |> String.codepoints()
      # Reversal of characters in string only because lambda in `scan` does
      # element prepending. Either the reversal is done here, or each of the
      # lists built by the `scan` would need to be reversed.
      |> Enum.reverse()
      # Traverse all of the characters (codepoints) in each line, starting
      # from the end, to create substrings that start from the end and
      # progressively build up to all the characters in the line. This is done
      # to enable matching at the start of each of the substrings, since the
      # number words may be overlapping in the lines.
      |> Enum.scan([], fn character, previous_characters ->
        [character | previous_characters]
      end)
      # Build substrings from the characters.
      |> Enum.map(&Enum.join/1)
      # Reverse again, to have the full line "substring" at the start, so that
      # one can match from the start of the line.
      |> Enum.reverse()
      # Find the substrings that start with one of the string-form digits or
      # number words, and then replace that substring with the number that
      # corresponds to the start of the substring. Reject the other substrings.
      |> Enum.flat_map(fn substring ->
        matching_string =
          Enum.find(digit_strings_or_number_words, fn digit_or_number_word ->
            String.starts_with?(substring, digit_or_number_word)
          end)

        if matching_string do
          [Map.fetch!(number_string_translations, matching_string)]
        else
          []
        end
      end)
    end)
    |> Enum.map(&join_last_and_first_number/1)
    |> Enum.sum()
  end

  defp join_last_and_first_number(numbers) do
    [List.first(numbers), List.last(numbers)]
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> String.to_integer()
  end
end
