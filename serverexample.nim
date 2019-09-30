import asynchttpserver, asyncdispatch
import json

var server = newAsyncHttpServer()

proc handler(req: Request) {.async.} =
  if req.url.path == "/hello-world":
    let msg = %* {"message": "Hello World"}
    let headers = newHttpHeaders([("Content-Type","application/json")])
    await req.respond(Http200, $msg, headers)
  else:
    await req.respond(Http404, "Not Found")

waitFor server.serve(Port(8080), handler)
