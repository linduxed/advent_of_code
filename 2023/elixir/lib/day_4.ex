defmodule AdventOfCode2023.Day4 do
  defmodule Card do
    defstruct [:card_index, :selected_numbers, :winning_numbers]
  end

  alias __MODULE__.Card

  def part_1(lines) do
    lines
    |> Enum.map(&line_to_card/1)
    |> Enum.map(&card_to_points/1)
    |> Enum.sum()
  end

  def part_2(lines) do
    lines
    |> Enum.map(&line_to_card/1)
    |> cards_to_copies_for_winning_numbers()
    |> Enum.count()
  end

  defp cards_to_copies_for_winning_numbers(cards) do
    iterate_cards_to_copies(%{
      card_pool: cards,
      cards_to_check: cards,

      # The final count of cards include the original cards that one starts
      # with, meaning that all of the copies that get recursively generated
      # should be added to the original ones.
      generated_copies: cards
    })
  end

  defp iterate_cards_to_copies(%{
         card_pool: _card_pool,
         cards_to_check: [],
         generated_copies: generated_copies
       }) do
    generated_copies
  end

  defp iterate_cards_to_copies(%{
         card_pool: card_pool,
         cards_to_check: cards_to_check,
         generated_copies: generated_copies
       }) do
    copies = Enum.flat_map(cards_to_check, &card_to_copies(&1, card_pool))

    iterate_cards_to_copies(%{
      card_pool: card_pool,
      cards_to_check: copies,
      generated_copies: generated_copies ++ copies
    })
  end

  defp card_to_copies(card = %Card{}, card_pool) do
    matching_number_count = matching_numbers(card)

    if matching_number_count == 0 do
      []
    else
      copy_card_indexes = 1..matching_number_count |> Range.shift(card.card_index)
      Enum.map(copy_card_indexes, &card_from_pool_by_index(&1, card_pool))
    end
  end

  defp card_from_pool_by_index(index, card_pool) do
    Enum.at(card_pool, index - 1)
  end

  def card_to_points(card = %Card{}) do
    matching_number_count = matching_numbers(card)

    if matching_number_count == 0 do
      0
    else
      # Subtracting by 1 to ensure that one match results in the exponent of 0,
      # to get the result of 1.
      Integer.pow(2, matching_number_count - 1)
    end
  end

  defp matching_numbers(card = %Card{}) do
    Enum.count(card.selected_numbers, &(&1 in card.winning_numbers))
  end

  def line_to_card(line) do
    [card_index_header_and_winning_numbers_string, selected_numbers_string] =
      String.split(line, "|")

    [card_index_header, winning_numbers_string] =
      String.split(card_index_header_and_winning_numbers_string, ":")

    ["Card", card_index_string] = String.split(card_index_header, " ", trim: true)
    card_index = String.to_integer(card_index_string)

    winning_numbers = numbers_string_to_integers(winning_numbers_string)
    selected_numbers = numbers_string_to_integers(selected_numbers_string)

    %Card{
      card_index: card_index,
      selected_numbers: selected_numbers,
      winning_numbers: winning_numbers
    }
  end

  defp numbers_string_to_integers(numbers_string) do
    numbers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
