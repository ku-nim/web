import asynchttpserver, asyncdispatch
import json
import os
import pages
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
  if req.url.path.endsWith(".jpg"):
    # NOTE: これがワイのサニタイズや！！
    let f = open("./" & req.url.path.replace("/",""),FileMode.fmRead)
    defer: f.close()
    let headers = newHttpHeaders([("Content-Type","image/jpg")])
    await req.respond(Http200,f.readAll(),headers)
    return
  case req.url.path:
  of "/":
    let headers = newHttpHeaders([("Content-Type","text/html")])
    await req.respond(Http200, pages.index(), headers)
    return
  of "/hello-world":
    let msg = %* {"message": "Hello World"}
    let headers = newHttpHeaders([("Content-Type","application/json")])
    await req.respond(Http200, $msg, headers)
    return
  of "/favicon.ico":
    let f = open("./favicon.ico",FileMode.fmRead)
    defer: f.close()
    let headers = newHttpHeaders([("Content-Type","image/png")])
    await req.respond(Http200,f.readAll(),headers)
    return
  else:
    await req.respond(Http404, "Not Found")

let port = parseInt(os.getEnv("PORT", "8080"))
echo port
waitFor server.serve(Port(port), handler)
