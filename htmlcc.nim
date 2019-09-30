import htmlgen
import macros

export htmlgen

macro htmlcc*(head:untyped, body: untyped): untyped =
  body.expectKind(nnkStmtList)
  when defined(htmlccdebug):
    echo body.lispRepr
  var html_val = newStrLitNode("")
  for clause in body:
    html_val = infix(html_val, "&", clause)

  if head.kind in {nnkBracketExpr}:
    result = newCall(head[0], head[1], html_val)
  elif head.kind in {nnkIdent, nnkAccQuoted}:
    result = newCall(head, html_val)
