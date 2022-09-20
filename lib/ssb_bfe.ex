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
end
