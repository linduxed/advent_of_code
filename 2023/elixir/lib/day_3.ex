defmodule AdventOfCode2023.Day3 do
  defmodule Number do
    defstruct [:number, :indexes, :line_number]
  end

  defmodule Symbol do
    defstruct [:symbol, :index, :line_number]
  end

  alias __MODULE__.{Number, Symbol}

  def lines_to_structs(lines) do
    structs =
      lines
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, line_number} -> line_to_structs(line, line_number) end)

    numbers = for %Number{} = number <- structs, do: number
    symbols = for %Symbol{} = symbol <- structs, do: symbol

    %{numbers: numbers, symbols: symbols}
  end

  defp line_to_structs(line, line_number) when is_integer(line_number) do
    line
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.chunk_by(fn {codepoint, _index} ->
      cond do
        number?(codepoint) -> :number
        symbol?(codepoint) -> :symbol
        period?(codepoint) -> :period
        true -> raise("Unknown codepoint: #{codepoint}")
      end
    end)
    |> Enum.flat_map(fn chunk = [{codepoint, _index} | _chunk_rest] ->
      cond do
        number?(codepoint) -> [number_struct(chunk, line_number)]
        symbol?(codepoint) -> Enum.map(chunk, &symbol_struct(&1, line_number))
        period?(codepoint) -> []
      end
    end)
  end

  @numbers ~w(0 1 2 3 4 5 6 7 8 9)
  @symbols ["*", "#", "+", "$", "/", "@", "&", "=", "-", "%"]

  defp number?(codepoint), do: codepoint in @numbers
  defp symbol?(codepoint), do: codepoint in @symbols
  defp period?(codepoint), do: codepoint == "."

  defp number_struct(number_string_and_index_pairs, line_number) do
    indexes =
      Enum.map(
        number_string_and_index_pairs,
        fn {_number_string, index} -> index end
      )

    number =
      number_string_and_index_pairs
      |> Enum.map(fn {number_string, _index} -> number_string end)
      |> Enum.join()
      |> String.to_integer()

    %Number{
      number: number,
      indexes: indexes,
      line_number: line_number
    }
  end

  defp symbol_struct({symbol_string, index}, line_number) do
    %Symbol{
      symbol: symbol_string,
      index: index,
      line_number: line_number
    }
  end

  def numbers_adjacent_to_symbol(symbol, numbers) do
    Enum.filter(numbers, fn number ->
      symbol_positioned_in_box_around_number?(symbol, number)
    end)
  end

  defp symbol_positioned_in_box_around_number?(
         %Symbol{index: symbol_index, line_number: symbol_line_number},
         %Number{indexes: number_indexes, line_number: number_line_number}
       ) do
    Enum.all?([
      Enum.min(number_indexes) - 1 <= symbol_index,
      symbol_index <= Enum.max(number_indexes) + 1,
      number_line_number - 1 <= symbol_line_number,
      symbol_line_number <= number_line_number + 1
    ])
  end

  def part_1(lines) do
    %{numbers: numbers, symbols: symbols} = lines_to_structs(lines)

    symbols
    |> Enum.flat_map(fn symbol -> numbers_adjacent_to_symbol(symbol, numbers) end)
    |> Enum.uniq()
    |> Enum.map(fn %Number{number: number} -> number end)
    |> Enum.sum()
  end

  def part_2(lines) do
    %{numbers: numbers, symbols: symbols} = lines_to_structs(lines)

    symbols
    |> Enum.map(fn symbol -> numbers_adjacent_to_symbol(symbol, numbers) end)
    |> Enum.filter(fn symbol_numbers -> length(symbol_numbers) == 2 end)
    |> Enum.map(fn number_pair ->
      number_pair
      |> Enum.map(fn %Number{number: number} -> number end)
      |> Enum.product()
    end)
    |> Enum.sum()
  end
end
