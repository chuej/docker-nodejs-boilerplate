mongoose = require 'mongoose'
debug = require('debug') 'connectDB'

connect = (connectString, next)->
  options =
    db:
      safe: true
  mongoose.connect connectString, options, (err, res) ->
    if err
      debug
        err: err
      , "ERROR connecting to #{connectString}."
    else
      debug "Mongoose connected to #{connectString}"

    if process.env.ENV != 'production'
      mongoose.set('debug', true)

    return next(err) if next?

disconnect = (next)->
  mongoose.connection.close next

module.exports =
  connect: connect
  disconnect: disconnect
