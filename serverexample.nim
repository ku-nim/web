import asynchttpserver, asyncdispatch
import json
import os

var server = newAsyncHttpServer()

proc handler(req: Request) {.async.} =
  case req.url.path:
  of "/hello-world":
    let msg = %* {"message": "Hello World"}
    let headers = newHttpHeaders([("Content-Type","application/json")])
    await req.respond(Http200, $msg, headers)
  of "/favicon.ico":
    let f = open("./favicon.ico",FileMode.fmRead)
    defer: f.close()
    let headers = newHttpHeaders([("Content-Type","image/png")])
    await req.respond(Http200,f.readAll(),headers)
  else:
    await req.respond(Http404, "Not Found")

waitFor server.serve(Port(8080), handler)
