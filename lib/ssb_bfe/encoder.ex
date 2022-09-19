# might be good to use a multiclause function for the `encode` function
# - use the `where` conditional guard with e.g. `is_number` 

defmodule SsbBfe.Encoder do
  defp extract_base64_data(str) do
    base64_data = String.slice(str, 1, 44)
    Base.decode64(base64_data)
  end

  def encode_blob(blob_id) do
    blob_tf_tag = SsbBfe.Types.get_blob_type(blob_id)
    {:ok, decoded_base64_data} = extract_base64_data(blob_id)
    blob_tf_tag <> decoded_base64_data
  end

  def encode_bool(true), do: <<6, 1, 1>>

  def encode_bool(false), do: <<6, 1, 0>>

  def encode_box(box_str) do
    box_tf_tag = SsbBfe.Types.get_box_type(box_str)
    [base64_data, _] = String.split(box_str, ".")
    {:ok, decoded_base64_data} = Base.decode64(base64_data)
    box_tf_tag <> decoded_base64_data
  end

  def encode_feed(feed_id) do
    feed_tf_tag = SsbBfe.Types.get_feed_type(feed_id)
    {:ok, decoded_base64_data} = extract_base64_data(feed_id)
    feed_tf_tag <> decoded_base64_data
  end

  def encode_msg(msg_id) do
    msg_tf_tag = SsbBfe.Types.get_msg_type(msg_id)
    {:ok, decoded_base64_data} = extract_base64_data(msg_id)
    msg_tf_tag <> decoded_base64_data
  end
end
