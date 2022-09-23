defmodule SsbBfe.Decoder do
  # Split the TF tag from the data bytes and base64 encode them.
  defp extract_base64_data(bin, tf_tag) do
    [_, base64_data] = :binary.split(bin, tf_tag)
    Base.encode64(base64_data)
  end

  @doc """
  Take a blob ID as an encoded binary, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
  def decode_blob(blob_id) do
    encoded_base64_data = extract_base64_data(blob_id, <<2, 0>>)
    "&" <> encoded_base64_data <> ".sha256"
  end

  @doc """
  Take an encrypted box as an encoded binary, extract the TF tag and call the appropriate decoder.
  """
  def decode_box(box) do
    tf_tag = binary_part(box, 0, 2)
    decode_box(box, tf_tag)
  end

  @doc """
  Take an encrypted box as an encoded binary and the TF tag of a box, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
  def decode_box(box, <<5, 0>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 0>>)
    encoded_base64_data <> ".box"
  end

  @doc """
  Take an encrypted box as an encoded binary and the TF tag of a box2, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
  def decode_box(box, <<5, 1>>) do
    encoded_base64_data = extract_base64_data(box, <<5, 1>>)
    encoded_base64_data <> ".box2"
  end

  @doc """
  Take a feed ID as an encoded binary, extract the TF tag and call the appropriate decoder.
  """
  def decode_feed(feed_id) do
    tf_tag = binary_part(feed_id, 0, 2)
    decode_feed(feed_id, tf_tag)
  end

  @doc """
  Take a feed ID as an encoded binary and the TF tag of a classic feed, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
  def decode_feed(feed_id, <<0, 0>>) do
    encoded_base64_data = extract_base64_data(feed_id, <<0, 0>>)
    "@" <> encoded_base64_data <> ".ed25519"
  end

  @doc """
  Take a boolean `true` value as an encoded binary and return `true`.
  """
  def decode_generic(<<6, 1, 1>>), do: true

  @doc """
  Take a boolean `false` value as an encoded binary and return `false`.
  """
  def decode_generic(<<6, 1, 0>>), do: false

  @doc """
  Take a `nil` value as an encoded binary and return `nil`.
  """
  def decode_generic(<<6, 2>>), do: nil

  @doc """
  Take a generic value as an encoded binary, extract the TF tag and call the appropriate decoder.
  """
  def decode_generic(generic) do
    tf_tag = binary_part(generic, 0, 2)
    decode_generic(generic, tf_tag)
  end

  @doc """
  Take a generic string as an encoded binary and the TF tag of a generic string, extract the bytes representing the string data and return the decoded string.
  """
  def decode_generic(str, <<6, 0>>) do
    [_, str_data] = :binary.split(str, <<6, 0>>)
    str_data
  end

  @doc """
  Take generic bytes as an encoded binary and the TF tag of generic bytes, extract the bytes representing the data and return them.
  """
  def decode_generic(bytes, <<6, 3>>) do
    [_, bytes] = :binary.split(bytes, <<6, 3>>)
    bytes
  end

  @doc """
  Take a message ID as an encoded binary, extract the TF tag and call the appropriate decoder.
  """
  def decode_msg(msg_id) do
    tf_tag = binary_part(msg_id, 0, 2)
    decode_msg(msg_id, tf_tag)
  end

  @doc """
  Take a message ID as an encoded binary and the TF tag of a classic message, extract and encode the base64 data and return the dedoded string representing the TFD.
  """
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
