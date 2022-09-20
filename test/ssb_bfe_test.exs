defmodule SsbBfeTest do
  use ExUnit.Case
  doctest SsbBfe

  setup do
    [
      blob: "&S7+CwHM6dZ9si5Vn4ftpk/l/ldbRMqzzJos+spZbWf4=.sha256",
      box1: "bG92ZSBjb2xsYXBzZXMgc3BhY2V0aW1l.box",
      box2: "bG92ZSBjb2xsYXBzZXMgc3BhY2V0aW1l.box2",
      feed_classic: "@d/zDvFswFbQaYJc03i47C9CgDev+/A8QQSfG5l/SEfw=.ed25519",
      msg_classic: "%R8heq/tQoxEIPkWf0Kxn1nCm/CsxG2CDpUYnAvdbXY8=.sha256",
      sig: "nkY4Wsn9feosxvX7bpLK7OxjdSrw6gSL8sun1n2TMLXKySYK9L5itVQnV2nQUctFsrUOa2istD2vDk1B0uAMBQ==.sig.ed25519",
      str: "golden ripples in the meshwork",
    ]
  end
  
  test "classic feed is encoded correctly", context do
    encoded_feed = SsbBfe.encode(context.feed_classic)
    
    assert encoded_feed == <<0, 0, 119, 252, 195, 188, 91, 48, 21, 180, 26, 96, 151, 52, 222, 46, 59, 11, 208, 160, 13, 235, 254, 252, 15, 16, 65, 39, 198, 230, 95, 210, 17, 252>>
  end

  test "classic msg is encoded correctly", context do
    encoded_msg = SsbBfe.encode(context.msg_classic)

    assert encoded_msg == <<1, 0, 71, 200, 94, 171, 251, 80, 163, 17, 8, 62, 69, 159, 208, 172, 103, 214, 112, 166, 252, 43, 49, 27, 96, 131, 165, 70, 39, 2, 247, 91, 93, 143>>
  end

  test "blob is encoded correctly", context do
    encoded_blob = SsbBfe.encode(context.blob)

    assert encoded_blob == <<2, 0, 75, 191, 130, 192, 115, 58, 117, 159, 108, 139, 149, 103, 225, 251, 105, 147, 249, 127, 149, 214, 209, 50, 172, 243, 38, 139, 62, 178, 150, 91, 89, 254>>
  end

  test "signature is encoded correctly", context do
    encoded_sig = SsbBfe.encode(context.sig)

    assert encoded_sig == <<4, 0, 158, 70, 56, 90, 201, 253, 125, 234, 44, 198, 245, 251, 110, 146, 202, 236, 236, 99, 117, 42, 240, 234, 4, 139, 242, 203, 167, 214, 125, 147, 48, 181, 202, 201, 38, 10, 244, 190, 98, 181, 84, 39, 87, 105, 208, 81, 203, 69, 178, 181, 14, 107, 104, 172, 180, 61, 175, 14, 77, 65, 210, 224, 12, 5>>
  end

  test "box is encoded correctly", context do
    encoded_box = SsbBfe.encode(context.box1)

    assert encoded_box == <<5, 0, 108, 111, 118, 101, 32, 99, 111, 108, 108, 97, 112, 115, 101, 115, 32, 115, 112, 97, 99, 101, 116, 105, 109, 101>>
  end

  test "box2 is encoded correctly", context do
    encoded_box2 = SsbBfe.encode(context.box2)

    assert encoded_box2 == <<5, 1, 108, 111, 118, 101, 32, 99, 111, 108, 108, 97, 112, 115, 101, 115, 32, 115, 112, 97, 99, 101, 116, 105, 109, 101>>
  end
end
