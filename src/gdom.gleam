import gleam/io
import gleam/list as l
import gleam/string as s
import gleam/result as r

pub fn main() {
  let ps = {
    use h1 <- r.try(
      new()
      |> select("div")
      |> first(),
    )
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

pub type Element

pub type QueryProblem {
  NotFound
  InvalidSelector
}

pub type Query {
  Query(context: Element, selector: String)
}

pub fn new() -> Query {
  new_from(document())
}

pub fn select(using query: Query, where selector: String) -> Query {
  Query(..query, selector: selector)
}

pub fn from(using query: Query, from context: Element) -> Query {
  Query(..query, context: context)
}

pub fn new_from(from context: Element) -> Query {
  Query(context: context, selector: "")
}

pub fn first(query: Query) -> Result(Element, QueryProblem) {
  query_selector(query.context, query.selector)
}

pub fn all(query: Query) -> Result(List(Element), QueryProblem) {
  query_selector_all(query.context, query.selector)
}

@external(javascript, "./selector_ffi.mjs", "query_selector")
pub fn query_selector(
  element: Element,
  selector: string,
) -> Result(Element, QueryProblem)

@external(javascript, "./selector_ffi.mjs", "query_selector_all")
pub fn query_selector_all(
  element: Element,
  selector: string,
) -> Result(List(Element), QueryProblem)

@external(javascript, "./selector_ffi.mjs", "get_document")
pub fn document() -> Element

@external(javascript, "./selector_ffi.mjs", "get_text_content")
pub fn text_content(element: Element) -> String

@external(javascript, "./selector_ffi.mjs", "get_get_inner_html")
pub fn inner_html(element: Element) -> String

@external(javascript, "./selector_ffi.mjs", "get_get_inner_text")
pub fn inner_text(element: Element) -> String
