express = require 'express'
bodyParser = require 'body-parser'
apiTest = require './apiTest/router'

create = ->
  app = express()

  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended:true)

  ###
  Mount your own routes here.
  ###
  app.use apiTest

  app.use (req, res, next) ->
    err = new Error("Not Found")
    err.status = 404
    next err
  if app.get("env") is "development"
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.json
        msg: err.message
        stack: err.stack
        status: err.status

  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.json
      msg: err.message


module.exports = create()
