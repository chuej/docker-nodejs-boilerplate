
mongoose = require 'mongoose'

async = require 'async'
_ = require 'lodash'
options =
  db:
    safe: true

mongoose.connect process.env.TEST_MONGO_URI
connection = mongoose.connection

before (done) ->
  connection.on 'open', =>
    connection.db.dropDatabase done

after (done) ->
  connection.db.dropDatabase ->
    mongoose.disconnect()
    connection.close done

clearCollections = (done) ->
  collections = _.keys(connection.collections)
  async.forEach collections, (collectionName, cb) ->
    collection = mongoose.connection.collections[collectionName]
    collection.drop (err) ->
      if err and err.message != 'ns not found'
        cb err
      else
        cb null
  , done

module.exports = ->
  afterEach (done) ->
    connection.db.dropDatabase () ->
      mongoose.disconnect()
      return done()
