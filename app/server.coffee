app = require("./")
http = require("http")
debug = require("debug")("billing:server")
db = require './config/db'


onError = (port)->
  (error)->
    throw error  if error.syscall isnt "listen"
    db.disconnect()

    bind = (if typeof port is "string" then "Pipe " + port else "Port " + port)

    # handle specific listen errors with friendly messages
    switch error.code
      when "EACCES"
        console.error bind + " requires elevated privileges"
        process.exit 1
      when "EADDRINUSE"
        console.error bind + " is already in use"
        process.exit 1
      else
        throw error
onListening = (server)->
  ->
    addr = server.address()
    bind = (if typeof addr is "string" then "pipe " + addr else "port " + addr.port)
    debug "Listening on " + bind

start = ->
  db.connect process.env.MONGO_URI, (err)->
    throw err if err

  port = process.env.PORT
  app.set "port", port
  app.set "env", process.env.NODE_ENV


  server = http.createServer(app)

  server.listen port
  server.on "error", onError(port)
  server.on "listening", onListening(server)
start()
