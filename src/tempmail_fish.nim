import asyncdispatch, httpclient, json, strutils

const api = "https://mail-api.pineapple-berry.pro"
var headers = newHttpHeaders({
    "Connection": "keep-alive",
    "Host": "mail-api.pineapple-berry.pro",
    "Content-Type": "application/json",
    "accept": "application/json, text/plain, */*",
    "referer":"https://tempmail.fish/",
    "origin":"https://tempmail.fish"
  })

proc create_email*(): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let json = %*{}
    let response = await client.post(api & "/emails/new-email",body= $json)
    let body = await response.body
    let req=parseJson(body)
    headers["Authorization"] = req["authKey"].getStr
    result = req
  finally:
    client.close()

proc delete_email*(email:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.delete(api & "/emails/emails?emailAddress=" & email)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()

proc get_messages*(email:string): Future[JsonNode] {.async.} =
  let client = newAsyncHttpClient()
  try:
    client.headers = headers
    let response = await client.get(api & "/emails/emails?emailAddress=" & email)
    let body = await response.body
    result = parseJson(body)
  finally:
    client.close()
