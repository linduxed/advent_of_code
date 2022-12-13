defmodule AdventOfCode2023.Day2 do
  def part_1(lines) do
    lines
    |> Enum.map(&line_to_game_data/1)
    |> Enum.reject(fn _game = %{dice_draws: dice_draws} ->
      max_red = 12
      max_green = 13
      max_blue = 14

      Enum.any?(
        dice_draws,
        fn _dice_draw = %{red: red, green: green, blue: blue} ->
          Enum.any?([
            red > max_red,
            green > max_green,
            blue > max_blue
          ])
        end
      )
    end)
    |> Enum.map(fn game -> game.game_number end)
    |> Enum.sum()
  end

  def part_2(lines) do
    lines
    |> Enum.map(&line_to_game_data/1)
    |> Enum.map(fn _game = %{dice_draws: dice_draws} ->
      %{
        red: minimum_required_red_dice,
        green: minimum_required_green_dice,
        blue: minimum_required_blue_dice
      } =
        Enum.reduce(
          dice_draws,
          fn _dice_draw = %{
               red: draw_red,
               green: draw_green,
               blue: draw_blue
             },
             acc ->
            %{
              red: max(draw_red, acc.red),
              green: max(draw_green, acc.green),
              blue: max(draw_blue, acc.blue)
            }
          end
        )

      [
        minimum_required_red_dice,
        minimum_required_green_dice,
        minimum_required_blue_dice
      ]
      # Eliminate 0-values, for these not to make the following
      # multiplication go to 0 if there were no dice from a particular color.
      |> Enum.map(&max(&1, 1))
      |> Enum.product()
    end)
    |> Enum.sum()
  end

  defp line_to_game_data(line) do
    "Game " <> line_without_prefix = line
    [game_number_string, game_string] = String.split(line_without_prefix, ":", trim: true)
    game_number = String.to_integer(game_number_string)
    dice_draws_strings = String.split(game_string, ";", trim: true)

    dice_draws =
      Enum.map(dice_draws_strings, fn dice_draws_string ->
        dice_draws_string
        |> String.split(", ")
        |> Enum.map(fn count_with_color_string ->
          [count_string, color_string] = String.split(count_with_color_string)
          count = String.to_integer(count_string)
          color = String.to_atom(color_string)

          {color, count}
        end)
        |> Enum.into(%{red: 0, green: 0, blue: 0})
      end)

    %{
      game_number: game_number,
      dice_draws: dice_draws
    }
  end
end
