# gdom

[![Package Version](https://img.shields.io/hexpm/v/js_test)](https://hex.pm/packages/js_test)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/js_test/)

```sh
gleam add gdom
```
```gleam
import gdom

pub fn main() {
  let ps = {
    use h1 <- r.try(new() |> select("div") |> first())
    h1
    |> new_from()
    |> select("#id.class >")
    |> all()
  }

  case ps {
    Ok(list) -> {
      io.debug(
        list
        |> l.map(text_content)
        |> s.join(", "),
      )
      Nil
    }
    Error(InvalidSelector) -> {
      io.debug("Invalid selector")
      Nil
    }
    Error(NotFound) -> {
      io.debug("Not found")
      Nil
    }
  }
}
```

Further documentation can be found at <https://hexdocs.pm/gdom>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
gleam shell # Run an Erlang shell
```
