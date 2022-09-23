defmodule SsbBfe.Encoder do
  # Extract the base64 substring from a sigil-link and decode it.
  defp extract_base64_data(str) do
    base64_data = String.slice(str, 1..44)
    Base.decode64(base64_data)
  end

  # Provide a pattern with which to split a string and base64 decode the first part.
  defp extract_base64_data(str, pattern) do
    [base64_data | _] = String.split(str, pattern)
    Base.decode64(base64_data)
  end

  @doc """
  Take a blob ID as a string, match on the type-format tag, extract and decode the base64 data and return the encoded bytes representing the TFD.
  """
  def encode_blob(blob_id) do
    blob_tf_tag = SsbBfe.Types.get_blob_type(blob_id)
    {:ok, decoded_base64_data} = extract_base64_data(blob_id)
    blob_tf_tag <> decoded_base64_data
  end

  @doc """
  Take a boolean value and return the encoded bytes representing the TFD.
  """
  def encode_bool(true), do: <<6, 1, 1>>

  def encode_bool(false), do: <<6, 1, 0>>

  @doc """
  Take an encrypted box as a string, match on the type-format tag, extract and decode the base64 data and return the encoded bytes representing the TFD.
  """
  def encode_box(box_str) do
    box_tf_tag = SsbBfe.Types.get_box_type(box_str)
    {:ok, decoded_base64_data} = extract_base64_data(box_str, ".")
    box_tf_tag <> decoded_base64_data
  end

  @doc """
  Take a feed ID as a string, match on the type-format tag, extract and decode the base64 data and return the encoded bytes representing the TFD.
  """
  def encode_feed(feed_id) do
    feed_tf_tag = SsbBfe.Types.get_feed_type(feed_id)
    {:ok, decoded_base64_data} = extract_base64_data(feed_id)
    feed_tf_tag <> decoded_base64_data
  end

  @doc """
  Take a message ID as a string, match on the type-format tag, extract and decode the base64 data and return the encoded bytes representing the TFD.
  """
  def encode_msg(msg_id) do
    msg_tf_tag = SsbBfe.Types.get_msg_type(msg_id)
    {:ok, decoded_base64_data} = extract_base64_data(msg_id)
    msg_tf_tag <> decoded_base64_data
  end

  @doc """
  Take a `nil` value and return the encoded bytes representing the TFD.
  """
  def encode_nil(), do: <<6, 2>>

  @doc """
  Take a signature ID as a string, match on the type-format tag, extract and decode the base64 data and return the encoded bytes representing the TFD.
  """
  def encode_sig(sig_id) do
    sig_tf_tag = SsbBfe.Types.get_sig_type(sig_id)
    {:ok, decoded_base64_data} = extract_base64_data(sig_id, ".sig.ed25519")
    sig_tf_tag <> decoded_base64_data
  end

  @doc """
  Take a string value and return the encoded bytes representing the TFD.
  """
  def encode_str(str), do: <<6, 0>> <> str
end
