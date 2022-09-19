defmodule SsbBfeTypesTest do
  use ExUnit.Case

  test "get_blob_type_matches_classic" do
    blob_id = "&S7+CwHM6dZ9si5Vn4ftpk/l/ldbRMqzzJos+spZbWf4=.sha256"
    blob_type = SsbBfe.Types.get_blob_type(blob_id)
    assert blob_type == <<2, 0>>
  end

  test "get_blob_type_matches_unknown" do
    blob_id = "&what.is_this"
    blob_type = SsbBfe.Types.get_blob_type(blob_id)
    assert blob_type == nil
  end
end
