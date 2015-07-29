routes = require './routes'
assert = require 'assert'

describe 'Test Route', ()->
  before (done)->
    req = {}
    res =
      send: (@respBody)=>
        return done()
    routes.test.get req, res, (err)->
       return done err if err

  it 'should respond', ()->
    assert.equal @respBody, 'hello world!'
