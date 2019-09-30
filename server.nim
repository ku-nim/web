import asynchttpserver, asyncdispatch
import json
import os
import strutils

var server = newAsyncHttpServer()

proc handler(req: Request) {.async.} =
  if req.url.path == "/":
    let msg = %* {"message": "Hello World"}
    let headers = newHttpHeaders([("Content-Type", "application/json")])
    await req.respond(Http200, $msg, headers)
  else:
    await req.respond(Http404, "Not Found !!!!")

waitFor server.serve(Port(parseInt(os.getEnv("PORT", "8080"))), handler)
