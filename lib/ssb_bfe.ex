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
    Enum.map(Tuple.to_list(value), fn x -> encode(x) end)
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
end
