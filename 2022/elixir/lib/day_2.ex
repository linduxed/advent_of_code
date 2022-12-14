defmodule AdventOfCode2022.Day2 do
  def part_1(lines) do
    lines
    |> Enum.map(&line_to_shapes(&1, _second_column_strategy = :shape))
    |> Enum.map(&shape_pairs_to_score/1)
    |> Enum.sum()
  end

  def part_2(lines) do
    lines
    |> Enum.map(&line_to_shapes(&1, _second_column_strategy = :target))
    |> Enum.map(&shape_pairs_to_score/1)
    |> Enum.sum()
  end

  defp line_to_shapes(line, second_column_strategy) do
    [opponent_letter, player_letter] = String.split(line)

    opponent_shape = letter_to_shape(opponent_letter)

    player_shape =
      player_letter_to_shape(
        player_letter,
        opponent_shape,
        second_column_strategy
      )

    {opponent_shape, player_shape}
  end

  defp player_letter_to_shape(letter, _opponent_shape, _strategy = :shape) do
    letter_to_shape(letter)
  end

  defp player_letter_to_shape(letter, opponent_shape, _strategy = :target) do
    target_outcome = letter_to_target_outcome(letter)
    shape_and_target_outcome_to_shape(opponent_shape, target_outcome)
  end

  defp shape_pairs_to_score({opponent_shape, player_shape}) do
    shape_score = shape_to_score(player_shape)

    match_outcome_score =
      shapes_to_outcome(player_shape, opponent_shape)
      |> outcome_to_score()

    shape_score + match_outcome_score
  end

  defp letter_to_shape("A"), do: :rock
  defp letter_to_shape("B"), do: :paper
  defp letter_to_shape("C"), do: :scissors
  defp letter_to_shape("X"), do: :rock
  defp letter_to_shape("Y"), do: :paper
  defp letter_to_shape("Z"), do: :scissors

  defp letter_to_target_outcome("X"), do: :loss
  defp letter_to_target_outcome("Y"), do: :draw
  defp letter_to_target_outcome("Z"), do: :win

  defp shape_and_target_outcome_to_shape(:rock, :loss), do: :scissors
  defp shape_and_target_outcome_to_shape(:rock, :draw), do: :rock
  defp shape_and_target_outcome_to_shape(:rock, :win), do: :paper
  defp shape_and_target_outcome_to_shape(:paper, :loss), do: :rock
  defp shape_and_target_outcome_to_shape(:paper, :draw), do: :paper
  defp shape_and_target_outcome_to_shape(:paper, :win), do: :scissors
  defp shape_and_target_outcome_to_shape(:scissors, :loss), do: :paper
  defp shape_and_target_outcome_to_shape(:scissors, :draw), do: :scissors
  defp shape_and_target_outcome_to_shape(:scissors, :win), do: :rock

  defp shapes_to_outcome(:rock, :rock), do: :draw
  defp shapes_to_outcome(:rock, :paper), do: :loss
  defp shapes_to_outcome(:rock, :scissors), do: :win
  defp shapes_to_outcome(:paper, :rock), do: :win
  defp shapes_to_outcome(:paper, :paper), do: :draw
  defp shapes_to_outcome(:paper, :scissors), do: :loss
  defp shapes_to_outcome(:scissors, :rock), do: :loss
  defp shapes_to_outcome(:scissors, :paper), do: :win
  defp shapes_to_outcome(:scissors, :scissors), do: :draw

  defp shape_to_score(:rock), do: 1
  defp shape_to_score(:paper), do: 2
  defp shape_to_score(:scissors), do: 3

  defp outcome_to_score(:loss), do: 0
  defp outcome_to_score(:draw), do: 3
  defp outcome_to_score(:win), do: 6
end
