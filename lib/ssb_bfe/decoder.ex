defmodule SsbBfe.Decoder do
  # Split the TF tag from the data bytes and base64 encode them.
  defp extract_base64_data(bin, tf_tag) do
    [_, base64_data] = :binary.split(bin, tf_tag)
    Base.encode64(base64_data)
  end

  @doc """
  Take a blob ID as an encoded binary and return the dedoded string representing the TFD.
  """
  def decode_blob(blob_id) do
    encoded_base64_data = extract_base64_data(blob_id, <<2, 0>>)
    "&" <> encoded_base64_data <> ".sha256"
  end

  @doc """
  Take an encrypted box as an encoded binary and return the decoded string representind the TFD.

  `decode_box/1` calls the appropriate `decode_box/2` clause based on the value of the TF tag extracted from the encoded box.
  """
  def decode_box(box) do
    tf_tag = binary_part(box, 0, 2)
    decode_box(box, tf_tag)
  end

  def decode_box(box, <<5, 0>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 0>>)
    encoded_base64_data <> ".box"
  end

  def decode_box(box, <<5, 1>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 1>>)
    encoded_base64_data <> ".box2"
  end

  @doc """
  Take a feed ID as an encoded binary and return the decoded string representing the TFD.

  `decode_feed/1` calls the appropriate `decode_feed/2` clause based on the value of the TF tag extracted from the encoded feed.
  """
  def decode_feed(feed_id) do
    tf_tag = binary_part(feed_id, 0, 2)
    decode_feed(feed_id, tf_tag)
  end

  def decode_feed(feed_id, <<0, 0>>) do
    encoded_base64_data = extract_base64_data(feed_id, <<0, 0>>)
    "@" <> encoded_base64_data <> ".ed25519"
  end

  @doc """
  Take an encoded generic value as an encoded binary and return `true`, `false`, `nil`, plain bytes or a decoded string.
  """
  def decode_generic(<<6, 1, 1>>), do: true

  def decode_generic(<<6, 1, 0>>), do: false

  def decode_generic(<<6, 2>>), do: nil

  def decode_generic(generic) do
    tf_tag = binary_part(generic, 0, 2)
    decode_generic(generic, tf_tag)
  end

  def decode_generic(str, <<6, 0>>) do
    [_, str_data] = :binary.split(str, <<6, 0>>)
    str_data
  end

  def decode_generic(bytes, <<6, 3>>) do
    [_, bytes] = :binary.split(bytes, <<6, 3>>)
    bytes
  end

  @doc """
  Take a message ID as an encoded binary and return the decoded string representing the TFD.

  `decode_msg/1` calls the appropriate `decode_msg/2` clause based on the value of the TF tag extracted from the encoded message.
  """
  def decode_msg(msg_id) do
    tf_tag = binary_part(msg_id, 0, 2)
    decode_msg(msg_id, tf_tag)
  end

  def decode_msg(msg_id, <<1, 0>>) do
    encoded_base64_data = extract_base64_data(msg_id, <<1, 0>>)
    "%" <> encoded_base64_data <> ".sha256"
  end

  @doc """
  Take a signature ID as an encoded binary, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
  def decode_sig(sig_id) do
    encoded_base64_data = extract_base64_data(sig_id, <<4, 0>>)
    encoded_base64_data <> ".sig.ed25519"
  end
end
