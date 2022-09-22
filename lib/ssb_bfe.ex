defmodule SsbBfe do
  @moduledoc """
  Documentation for `SsbBfe`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SsbBfe.hello()
      :world

  """
  def hello do
    :world
  end

  # ENCODE

  def encode(value) when is_list(value) do
    Enum.map(value, fn x -> encode(x) end)
  end

  def encode(value) when is_map(value) do
    Enum.reduce(
      value,
      %{},
      fn {k, v}, acc ->
        Map.put(acc, k, SsbBfe.encode(v))
      end
    )
  end

  def encode(value) when is_tuple(value) do
    Enum.map(Tuple.to_list(value), fn x -> encode(x) end) |>
    List.to_tuple()
  end

  def encode(value) when is_bitstring(value) do
    cond do
      String.starts_with?(value, "@") ->
        SsbBfe.Encoder.encode_feed(value)

      String.starts_with?(value, "%") ->
        SsbBfe.Encoder.encode_msg(value)

      String.starts_with?(value, "&") ->
        SsbBfe.Encoder.encode_blob(value)

      String.ends_with?(value, ".sig.ed25519") ->
        SsbBfe.Encoder.encode_sig(value)

      String.ends_with?(value, [".box", ".box2"]) ->
        SsbBfe.Encoder.encode_box(value)

      true ->
        SsbBfe.Encoder.encode_str(value)
    end
  end

  def encode(value) when is_boolean(value), do: SsbBfe.Encoder.encode_bool(value)

  def encode(value) when is_number(value), do: value

  def encode(value) when is_nil(value), do: SsbBfe.Encoder.encode_nil()

  # DECODE

  def decode(value) when is_binary(value) do
    first_byte = :binary.first(value)

    cond do
      0 == first_byte ->
        SsbBfe.Decoder.decode_feed(value)

      1 == first_byte ->
        SsbBfe.Decoder.decode_msg(value)

      2 == first_byte ->
        SsbBfe.Decoder.decode_blob(value)

      4 == first_byte ->
        SsbBfe.Decoder.decode_sig(value)

      5 == first_byte ->
        SsbBfe.Decoder.decode_box(value)

      6 == first_byte ->
        SsbBfe.Decoder.decode_generic(value)

      nil ->
        true
    end
  end

  def decode(value) when is_number(value), do: value

  def decode(value) when is_list(value) do
    Enum.map(value, fn x -> decode(x) end)
  end

  def decode(value) when is_map(value) do
    Enum.reduce(
      value,
      %{},
      fn {k, v}, acc ->
        Map.put(acc, k, SsbBfe.decode(v))
      end
    )
  end

  def decode(value) when is_tuple(value) do
    Enum.map(Tuple.to_list(value), fn x -> decode(x) end) |>
    List.to_tuple()
  end
end
