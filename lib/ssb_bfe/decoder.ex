defmodule SsbBfe.Decoder do
  defp extract_base64_data(bin, tf_tag) do
    [_, base64_data] = :binary.split(bin, tf_tag)
    Base.encode64(base64_data)
  end

  def decode_blob(blob) do
    encoded_base64_data = extract_base64_data(blob, <<2, 0>>)
    "&" <> encoded_base64_data <> ".sha256"
  end

  def decode_box(box) do
    tf_tag = binary_part(box, 0, 2)
    decode_box(box, tf_tag)
  end

  # Matches box.
  def decode_box(box, <<5, 0>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 0>>)
    encoded_base64_data <> ".box"
  end

  # Matches box2.
  def decode_box(box, <<5, 1>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 1>>)
    encoded_base64_data <> ".box2"
  end

  def decode_feed(feed) do
    tf_tag = binary_part(feed, 0, 2)
    decode_feed(feed, tf_tag)
  end

  # Matches classic feed.
  def decode_feed(feed, <<0, 0>>) do
    encoded_base64_data = extract_base64_data(feed, <<0, 0>>)
    "@" <> encoded_base64_data <> ".ed25519"
  end

  def decode_generic(<<6, 1, 1>>), do: true

  def decode_generic(<<6, 1, 0>>), do: false

  def decode_generic(<<6, 2>>), do: nil

  def decode_generic(generic) do
    tf_tag = binary_part(generic, 0, 2)
    decode_generic(generic, tf_tag)
  end

  # Matches generic string.
  def decode_generic(str, <<6, 0>>) do
    [_, str_data] = :binary.split(str, <<6, 0>>)
    str_data
  end

  # Matches generic bytes.
  def decode_generic(bytes, <<6, 3>>), do: bytes

  def decode_msg(msg) do
    tf_tag = binary_part(msg, 0, 2)
    decode_msg(msg, tf_tag)
  end

  # Matches classic message.
  def decode_msg(msg, <<1, 0>>) do
    encoded_base64_data = extract_base64_data(msg, <<1, 0>>)
    "%" <> encoded_base64_data <> ".sha256"
  end

  def decode_sig(sig) do
    encoded_base64_data = extract_base64_data(sig, <<4, 0>>)
    encoded_base64_data <> ".sig.ed25519"
  end
end
