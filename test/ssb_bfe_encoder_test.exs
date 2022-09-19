defmodule SsbBfeEncoderTest do
  use ExUnit.Case

  @blob_id "&S7+CwHM6dZ9si5Vn4ftpk/l/ldbRMqzzJos+spZbWf4=.sha256"
  @box1_msg "siZEm1zFx1icq0SrEynGDpNRmJCXMxTB3iEteXFn+IhJH8WhMbT8tp9qOIaFkIYcdOyerSon6RK0l4RE1ZdDh/3lcGZSdP0Ljq59qsdqlf2ngwbIbV9AWdPRrPsoVZBV6RhI+YcVTloWWP5aauu1hZKjcm62ezLBTQ3EmFPYtDuwsOFkx9/7FP97ljhj67CwvlGzuiWp6FNICHbt5kOCxs9H0k6Tr8JJVdaJtJ2pqkX4p0ECMuEuYxCYbh3FpncCqlNZJXb0dj3iSsfsMNWTJLDqfkqJKH1jBVfxDL6+xAXBDS+E4F2hD4y9gRDZEej99uVBQWlbxr5eCRV+VbfBGYxwoAYtqux6rg3jBabImKKinBwHShEP5F/+wlb9IxQn4swyOgyv+UKx/jbx+91Ayso5bnNPZMpwRRX5p5DbpK1BnryeVJhktMgFqgni1g0lHyU8sQ2QzwZgXGw7dfYoamkqK4D24NOLnUoHuVuhd7Q5SxZWSAO6wpDa4nrODePoJdl328pbMwCoQlUNeHINmKxh/o/oCNbgXitn4oN3kSVEg/umdgwwI94gmZUjiYwP1v7HA7dI.box"
  @box2_msg "WQyfhDDHQ1gH34uppHbj8SldRu8hD2764gQ6TAhaVp6R01EMBnJQj5ewD5F+UT5NwvV91uU8q5XCjuvcP4ihCJ0RtX8HjKyN+tDKP5gKB3UZo/eO/rP5CcPGoIG7pcLBsd3DQbZLfTnb/iqECEji9gclNcGENTS2u6aATwbQ4uQ7RzIAKKT2NfC2qk86p/gXC2owDFAazuPlQTT8DMNvO8G52gb48a75CGKsDAevrC//Bz38VFxwUiTKzRWaxCbTK9knj39u3qoCP9VLyyRqITgNwvlGLP7ndchTyBiO0TPNkb9PAOenw5WBjyWhA61hpG+VkKpkaysBVGjXYv8OpV1HGbs87TI79uT7JrNV4wEZiwqGknwmCi5B2gbd7tav8yDXsK5yQgDncHQjZotsBFX2adP7Jli9WmvV3xX5lL3kBNKV0ZiE/DZUgB2m1OXvCjNI4fuZhnpZpEQi9coO+icrirKiH/UA8TS9HI72cIbkEJVxOTnKnsgr3Qc/5HhtRS17a54ymVmBsnpP+KqqCqKLN50TInb7qoUlvQ2nw07xX3Ig9usLb8Ik8U8XMb6SLqACxlZN/qW4EJzxVetoIk84AU1yLInK6v9dzfsewRYBXW8+lYbyxVNuIIK4pKYsx2WbjuJyZHgjgbCdGf/kjqP5rDs4zwqj2lmkO70PoEUrcSi46J2hkqtcrd1yl+F3/BDwFlxAXH+x4+LhmT7g+BSgzRUbWvCyeB+HJaoao6g4K/Fs8HxnbVB1zW761OQJaQnV86ZThkvUjXh2SEBlBd+D94eUCqIJkjI7RLt+D/0gxg/D7u1Zq14UxRijZryB51An7GdXtEc2xhU+Bh/aPmKmMZ9D/ArdglSlnVUD8OIBVVw5jtooGlhxbOFHM4N5SoAO/yWPcbcuQz7t4SPij358rY574DLBGZEPCrS6KPpnrlqlnZK4f6/+9zv3hfzNTXVvJtxZL/rvmNvbgh7LpMnSqjnsXqm86a3GXeVWD83TdCnL1oPqEi/8RItTrjy01DmVhUoV6t12STP4mHb8RjR+/ks+7lowfV3HQ13n6if0g0/u+Bzv6XXOX6iePPOHA3lFv2MSPKf9JZ0uQiqajR03YkNE8YnSTYu0Io1cGPZ/lWBp2tyWtwFmGtqw/9+O165tJhrdU2EXJ4T/XP136WpLD2+vtYsx3Xr5lfeD12/g+I/6jwduqTuHpst2tqvcSWoZ4DAWcpcKJ1mUbJU3/mLAYGwWb3XuqMOgJOLoztAwd5xFzUZD1MnR/iyYoZ2weYTSOz3OKR3cJyCjxBhIGaX5xpAc61K1dXNfERBJr9TS0mL2578dd5AauE6Ksn6YlGxNJIVC3VpdAtRbVHNX1g==.box2"
  @classic_feed "@d/zDvFswFbQaYJc03i47C9CgDev+/A8QQSfG5l/SEfw=.ed25519"
  @classic_msg "%R8heq/tQoxEIPkWf0Kxn1nCm/CsxG2CDpUYnAvdbXY8=.sha256"

  test "encode_blob_works" do
    encoded_blob = SsbBfe.Encoder.encode_blob(@blob_id)
    assert encoded_blob == <<2, 0, 75, 191, 130, 192, 115, 58, 117, 159, 108, 139, 149, 103, 225, 251, 105, 147, 249, 127, 149, 214, 209, 50, 172, 243, 38, 139, 62, 178, 150, 91, 89, 254>>
  end
  
  test "encode_bool_works" do
    assert SsbBfe.Encoder.encode_bool(true) == <<6, 1, 1>>
    assert SsbBfe.Encoder.encode_bool(false) == <<6, 1, 0>>
  end

  test "encode_box1_works" do
    encoded_box1 = SsbBfe.Encoder.encode_box(@box1_msg)
    assert String.starts_with?(encoded_box1, <<5, 0>>)
  end
  
  test "encode_box2_works" do
    encoded_box2 = SsbBfe.Encoder.encode_box(@box2_msg)
    assert String.starts_with?(encoded_box2, <<5, 1>>)
  end

  test "encode_classic_feed_works" do
    encoded_classic_feed = SsbBfe.Encoder.encode_feed(@classic_feed)
    assert String.starts_with?(encoded_classic_feed, <<0, 0>>)
  end

  test "encode_classic_msg_works" do
    encoded_classic_msg = SsbBfe.Encoder.encode_msg(@classic_msg)
    assert encoded_classic_msg == <<1, 0, 71, 200, 94, 171, 251, 80, 163, 17, 8, 62, 69, 159, 208, 172, 103, 214, 112, 166, 252, 43, 49, 27, 96, 131, 165, 70, 39, 2, 247, 91, 93, 143>>
  end

end
