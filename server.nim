import asynchttpserver, asyncdispatch
import json
import os
import strutils
import uri

var server = newAsyncHttpServer()

proc handler(req: Request) {.async.} =
  if "http" in req.headers.getOrDefault("X-Forwarded-Proto"):
    let httpsUri = parseUri("https://" & req.headers["host"]) / req.url.path
    let headers = newHttpHeaders([
      ("Location", $httpsUri),
      ("Strict-Transport-Security", "max-age=31536000"),
      ])
    await req.respond(Http301, "", headers)
    return

  if req.url.path == "/":
    let msg = %* {"message": "Hello World"}
    let headers = newHttpHeaders([("Content-Type", "application/json")])
    await req.respond(Http200, $msg, headers)
  else:
    await req.respond(Http404, "Not Found !!!!")

waitFor server.serve(Port(parseInt(os.getEnv("PORT", "8080"))), handler)
