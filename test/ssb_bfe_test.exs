defmodule SsbBfeTest do
  use ExUnit.Case
  doctest SsbBfe

  setup do
    [
      blob: "&S7+CwHM6dZ9si5Vn4ftpk/l/ldbRMqzzJos+spZbWf4=.sha256",
      blob_encoded: <<2, 0, 75, 191, 130, 192, 115, 58, 117, 159, 108, 139, 149, 103, 225, 251, 105, 147, 249, 127, 149, 214, 209, 50, 172, 243, 38, 139, 62, 178, 150, 91, 89, 254>>,
      bool_true_encoded: <<6, 1, 1>>,
      bool_false_encoded: <<6, 1, 0>>,
      box1: "bG92ZSBjb2xsYXBzZXMgc3BhY2V0aW1l.box",
      box1_encoded: <<5, 0, 108, 111, 118, 101, 32, 99, 111, 108, 108, 97, 112, 115, 101, 115, 32, 115, 112, 97, 99, 101, 116, 105, 109, 101>>,
      box2: "bG92ZSBjb2xsYXBzZXMgc3BhY2V0aW1l.box2",
      box2_encoded: <<5, 1, 108, 111, 118, 101, 32, 99, 111, 108, 108, 97, 112, 115, 101, 115, 32, 115, 112, 97, 99, 101, 116, 105, 109, 101>>,
      feed_classic: "@d/zDvFswFbQaYJc03i47C9CgDev+/A8QQSfG5l/SEfw=.ed25519",
      feed_classic_encoded: <<0, 0, 119, 252, 195, 188, 91, 48, 21, 180, 26, 96, 151, 52, 222, 46, 59, 11, 208, 160, 13, 235, 254, 252, 15, 16, 65, 39, 198, 230, 95, 210, 17, 252>>,
      msg_classic: "%R8heq/tQoxEIPkWf0Kxn1nCm/CsxG2CDpUYnAvdbXY8=.sha256",
      msg_classic_encoded: <<1, 0, 71, 200, 94, 171, 251, 80, 163, 17, 8, 62, 69, 159, 208, 172, 103, 214, 112, 166, 252, 43, 49, 27, 96, 131, 165, 70, 39, 2, 247, 91, 93, 143>>,
      nil_encoded: <<6, 2>>,
      sig: "nkY4Wsn9feosxvX7bpLK7OxjdSrw6gSL8sun1n2TMLXKySYK9L5itVQnV2nQUctFsrUOa2istD2vDk1B0uAMBQ==.sig.ed25519",
      sig_encoded: <<4, 0, 158, 70, 56, 90, 201, 253, 125, 234, 44, 198, 245, 251, 110, 146, 202, 236, 236, 99, 117, 42, 240, 234, 4, 139, 242, 203, 167, 214, 125, 147, 48, 181, 202, 201, 38, 10, 244, 190, 98, 181, 84, 39, 87, 105, 208, 81, 203, 69, 178, 181, 14, 107, 104, 172, 180, 61, 175, 14, 77, 65, 210, 224, 12, 5>>,
      str: "golden ripples in the meshwork",
      str_encoded: <<6, 0, 103, 111, 108, 100, 101, 110, 32, 114, 105, 112, 112, 108, 101, 115, 32, 105, 110, 32, 116, 104, 101, 32, 109, 101, 115, 104, 119, 111, 114, 107>>
    ]
  end

  # ENCODING TESTS: HAPPY PATH

  test "classic feed is encoded correctly", context do
    encoded_feed = SsbBfe.encode(context.feed_classic)
    
    assert encoded_feed == context.feed_classic_encoded
  end

  test "classic msg is encoded correctly", context do
    encoded_msg = SsbBfe.encode(context.msg_classic)

    assert encoded_msg == context.msg_classic_encoded
  end

  test "blob is encoded correctly", context do
    encoded_blob = SsbBfe.encode(context.blob)

    assert encoded_blob == context.blob_encoded
  end

  test "signature is encoded correctly", context do
    encoded_sig = SsbBfe.encode(context.sig)

    assert encoded_sig == context.sig_encoded
  end

  test "box is encoded correctly", context do
    encoded_box = SsbBfe.encode(context.box1)

    assert encoded_box == context.box1_encoded
  end

  test "box2 is encoded correctly", context do
    encoded_box2 = SsbBfe.encode(context.box2)

    assert encoded_box2 == context.box2_encoded
  end

  test "plain string is encoded correctly", context do
    encoded_str = SsbBfe.encode(context.str)

    assert encoded_str == context.str_encoded
  end

  test "boolean is encoded correctly", context do
    encoded_bool_true = SsbBfe.encode(true)
    encoded_bool_false = SsbBfe.encode(false)

    assert encoded_bool_true == context.bool_true_encoded
    assert encoded_bool_false == context.bool_false_encoded
  end

  test "nil is encoded correctly", context do
    encoded_nil = SsbBfe.encode(nil)

    assert encoded_nil == context.nil_encoded
  end

  test "list is encoded correctly", context do
    encoded_list = SsbBfe.encode([true, nil, context.str])

    assert encoded_list == [context.bool_true_encoded, context.nil_encoded, context.str_encoded]
  end

  test "map is encoded correctly", context do
    encoded_map = SsbBfe.encode(%{"bool" => false, "feed" => context.feed_classic})

    assert encoded_map == %{"bool" => context.bool_false_encoded, "feed" => context.feed_classic_encoded}
  end

  test "tuple is encoded correctly", context do
    encoded_tuple = SsbBfe.encode({7, context.msg_classic})

    assert encoded_tuple == {7, context.msg_classic_encoded}
  end

  # DECODING TESTS: HAPPY PATH

  test "classic feed is decoded correctly", context do
    decoded_feed = SsbBfe.decode(context.feed_classic_encoded)

    assert decoded_feed == context.feed_classic
  end

  test "classic message is decoded correctly", context do
    decoded_msg = SsbBfe.decode(context.msg_classic_encoded)

    assert decoded_msg == context.msg_classic
  end

  test "blob is decoded correctly", context do
    decoded_blob = SsbBfe.decode(context.blob_encoded)

    assert decoded_blob == context.blob
  end

  test "signature is decoded correctly", context do
    decoded_sig = SsbBfe.decode(context.sig_encoded)

    assert decoded_sig == context.sig
  end

  test "box is decoded correctly", context do
    decoded_box = SsbBfe.decode(context.box1_encoded)

    assert decoded_box == context.box1
  end
  
  test "box2 is decoded correctly", context do
    decoded_box2 = SsbBfe.decode(context.box2_encoded)

    assert decoded_box2 == context.box2
  end

  test "plain string is decoded correctly", context do
    decoded_str = SsbBfe.decode(context.str_encoded)

    assert decoded_str == context.str
  end

  test "boolean is decoded correctly", context do
    decoded_bool_true = SsbBfe.decode(context.bool_true_encoded)
    decoded_bool_false = SsbBfe.decode(context.bool_false_encoded)

    assert decoded_bool_true == true
    assert decoded_bool_false == false
  end

  test "nil string is decoded correctly", context do
    decoded_nil = SsbBfe.decode(context.nil_encoded)

    assert decoded_nil == nil
  end

  test "list is decoded correctly", context do
    decoded_list = SsbBfe.decode([context.bool_true_encoded, context.nil_encoded, context.str_encoded])

    assert decoded_list == [true, nil, context.str]
  end

  test "map is decoded correctly", context do
    decoded_map = SsbBfe.decode(%{"bool" => context.bool_false_encoded, "feed" => context.feed_classic_encoded})

    assert decoded_map == %{"bool" => false, "feed" => context.feed_classic}
  end
  
  test "tuple is decoded correctly", context do
    decoded_tuple = SsbBfe.decode({7, context.msg_classic_encoded})

    assert decoded_tuple == {7, context.msg_classic}
  end
end
