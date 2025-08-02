defmodule AdventOfCode2015.Day7 do
  def circuit_description_to_circuit(lines) do
    lines
    |> Enum.map(&line_to_operation_and_target/1)
    |> Enum.reduce(%{}, fn {operation, target}, acc ->
      put_in(acc[target], operation)
    end)
  end

  def line_to_operation_and_target(line) do
    [raw_operation, target] =
      line
      |> String.split("->", trim: true)
      |> Enum.map(&String.trim/1)

    operation =
      raw_operation
      |> String.split(" ")
      |> parse_operation()

    {operation, target}
  end

  def parse_operation([a]), do: {:literal, a}
  def parse_operation(["NOT", a]), do: {:not, a}
  def parse_operation([a, "AND", b]), do: {:and, a, b}
  def parse_operation([a, "OR", b]), do: {:or, a, b}
  def parse_operation([a, "LSHIFT", b]), do: {:lshift, a, b}
  def parse_operation([a, "RSHIFT", b]), do: {:rshift, a, b}

  def num_or_apply(a, context) do
    try do
      String.to_integer(a)
    rescue
      ArgumentError -> access_and_apply(a, context)
    else
      number -> {ensure_unsigned_16bit(number), context}
    end
  end

  def access_and_apply(target, context) do
    if memoized = context.memo[target] do
      {memoized, context}
    else
      target_value = context.circuit[target]
      {value, recursive_context} = operation_apply(target_value, context)
      new_context = put_in(recursive_context, [:memo, target], value)

      {value, new_context}
    end
  end

  def unary(fun, a, context) do
    {a_val, new_context} = num_or_apply(a, context)
    value = fun.(a_val)

    {value, new_context}
  end

  def binary(fun, a, b, context) do
    {a_val, new_context} = num_or_apply(a, context)
    {b_val, new_context} = num_or_apply(b, new_context)

    value = fun.(a_val, b_val)

    {value, new_context}
  end

  def operation_apply({:literal, a}, context) do
    num_or_apply(a, context)
  end

  def operation_apply({:not, a}, context) do
    unary(&Bitwise.bnot/1, a, context)
  end

  def operation_apply({:and, a, b}, context) do
    binary(&Bitwise.band/2, a, b, context)
  end

  def operation_apply({:or, a, b}, context) do
    binary(&Bitwise.bor/2, a, b, context)
  end

  def operation_apply({:lshift, a, b}, context) do
    binary(&Bitwise.bsl/2, a, b, context)
  end

  def operation_apply({:rshift, a, b}, context) do
    binary(&Bitwise.bsr/2, a, b, context)
  end

  def ensure_unsigned_16bit(number) do
    Bitwise.band(number, 0xFFFF)
  end

  def part_1(lines) do
    circuit = circuit_description_to_circuit(lines)

    {value, _memo} =
      access_and_apply(
        _start = "a",
        _context = %{
          circuit: circuit,
          memo: %{}
        }
      )

    value
  end

  def part_2(lines) do
    circuit = circuit_description_to_circuit(lines)
    wire_a_result = part_1(lines)

    modified_circuit =
      put_in(
        circuit["b"],
        {:literal, Integer.to_string(wire_a_result)}
      )

    {value, _memo} =
      access_and_apply(
        _start = "a",
        _context = %{
          circuit: modified_circuit,
          memo: %{}
        }
      )

    value
  end
end
