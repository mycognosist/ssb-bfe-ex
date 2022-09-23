defmodule SsbBfe.Types do
  @doc """
  Take a blob ID as a string and return the encoded bytes representing the blob
  type-format. Throw an error if the ID does not end with `.sha256`.
  """
  def get_blob_type(blob_id) do
    cond do
      String.ends_with?(blob_id, ".sha256") ->
        <<2, 0>>

      true ->
        throw({:unknown_format, blob_id})
    end
  end

  @doc """
  Take a box as a string and return the encoded bytes representing the box
  type-format. Throw an error if the ID does not end with `.box` or `.box2`.
  """
  def get_box_type(boxed_str) do
    cond do
      String.ends_with?(boxed_str, ".box") ->
        <<5, 0>>

      String.ends_with?(boxed_str, ".box2") ->
        <<5, 1>>

      true ->
        throw({:unknown_format, boxed_str})
    end
  end

  @doc """
  Take a feed ID (key) as a string and return the encoded bytes representing
  the feed type-format. Throw an error if the ID does not end with `.ed25519`.
  """
  def get_feed_type(feed_id) do
    cond do
      String.ends_with?(feed_id, ".ed25519") ->
        <<0, 0>>

      true ->
        throw({:unknown_format, feed_id})
    end
  end

  @doc """
  Take a message ID as a string and return the encoded bytes representing
  the message type-format. Throw an error if the ID does not end with `.sha256`
  or `.cloaked`.
  """
  def get_msg_type(msg_id) do
    cond do
      String.ends_with?(msg_id, ".sha256") ->
        <<1, 0>>

      String.ends_with?(msg_id, ".cloaked") ->
        <<1, 2>>

      true ->
        throw({:unknown_format, msg_id})
    end
  end

  @doc """
  Take a signature ID as a string and return the encoded bytes representing
  the signature type-format. Throw an error if the ID does not end with `.sig.ed25519`.
  """
  def get_sig_type(sig_id) do
    cond do
      String.ends_with?(sig_id, ".sig.ed25519") ->
        <<4, 0>>

      true ->
        throw({:unknown_format, sig_id})
    end
  end
end
