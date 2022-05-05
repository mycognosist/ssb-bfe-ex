defmodule SsbBfe.Types do
  @doc ~S"""
  Take a blob ID as a string and return the encoded bytes representing the blob
  type-format. Return `nil` if the ID does not end with `.sha256`.
  """
  def get_blob_type(blob_id) do
    if String.ends_with?(blob_id, ".sha256") do
      <<2, 0>>
    end
  end
  
  @doc ~S"""
  Take a feed ID (key) as a string and return the encoded bytes representing
  the feed type-format. Return `nil` if the ID does not end with `.ed25519`.
  """
  def get_feed_type(feed_id) do
    if String.ends_with?(feed_id, ".ed25519") do
      <<0, 0>>
    end
  end
end
