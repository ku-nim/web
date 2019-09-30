import htmlgen
import macros

macro htmlcc*(head:untyped, body: untyped): untyped =
  body.expectKind(nnkStmtList)
  echo lispRepr(body)
  var html_val = newStrLitNode("")
  for clause in body:
    html_val = infix(html_val, "&", clause)

  if head.kind in {nnkBracketExpr}:
    result = newCall(head[0], head[1], html_val)
  elif head.kind in {nnkIdent}:
    result = newCall(head, html_val)

#htmlcc html:
#  "test"
#  "test2"
#  "test3"
