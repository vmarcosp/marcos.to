@module("./NextHelpers.js")
external withCustomLayout: ('props => React.element, React.element => React.element) => unit =
  "withCustomLayout"

@module("./NextHelpers.js")
external getLayout: React.component<'props> => option<React.element => React.element> = "getLayout"
