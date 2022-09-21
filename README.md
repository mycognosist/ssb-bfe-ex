# SsbBfe

Binary Field Encodings (BFE) for Secure Scuttlebutt (SSB).

See the [SSB Binary Field Encodings Specification](https://github.com/ssbc/ssb-bfe-spec) for details.

## Encoding

```elixir
SsbBfe.encode(value)
```

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

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ssb_bfe>.

## License

LGPL-3.0.
