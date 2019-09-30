import htmlgen
import htmlcc

echo:
  htmlcc html:
    htmlcc head:
      title:
        "Kyoto University Nim Club"
    htmlcc body:
      "test"
      h1:
        "Kyoto University Nim Club"
      "This is body"
      a "http://example.com":
        "this is a link"
