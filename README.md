# SsbBfe

Binary Field Encodings (BFE) for Secure Scuttlebutt (SSB).

See the [SSB Binary Field Encodings Specification](https://github.com/ssbc/ssb-bfe-spec) for details.

## Encoding

```elixir
SsbBfe.encode("@HEqy940T6uB+T+d9Jaa58aNfRzLx9eRWqkZljBmnkmk=.ed25519")
<<0, 0, 28, 74, 178, 247, 141, 19, 234, 224, 126, 79, 231, 125, 37, 166, 185,
  241, 163, 95, 71, 50, 241, 245, 228, 86, 170, 70, 101, 140, 25, 167, 146,
105>>
```

## Decoding

```elixir
SsbBfe.decode(
  <<0, 0, 28, 74, 178, 247, 141, 19, 234, 224, 126, 79, 231, 125, 37, 166, 185,
    241, 163, 95, 71, 50, 241, 245, 228, 86, 170, 70, 101, 140, 25, 167, 146,
  105>>
)
"@HEqy940T6uB+T+d9Jaa58aNfRzLx9eRWqkZljBmnkmk=.ed25519"
```

## Supported Types

### Elixir Types

Encoding of the following Elixir types is supported:

 - List
 - Map
 - Tuple
 - String
 - Boolean
 - Nil
 - Integer
 - Float

Note: encoding of structs is not supported. You may wish to convert your struct to amap and encode it that way.

### Scuttlebutt Types

Encoding of the following Scuttlebutt types is supported:

 - Feed (classic)
 - Message (classic)
 - Blob
 - Signature
 - Private message (box, box2)

Note: encoding of URIs is not currently supported, nor are other formats such as Gabby Grove and Bendy Butt.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ssb_bfe` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ssb_bfe, "~> 0.1.0"}
  ]
end
```

## License

LGPL-3.0.
