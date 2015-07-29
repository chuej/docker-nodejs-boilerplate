request = require 'request'
assert = require 'assert'
describe 'Test Route', ()->
  before (done)->
    opts =
      method: 'GET'
      url: "http://localhost:5000/test"
    request opts, (err, resp, @respBody)=>
      return done err if err
      return done()
  it 'should respond', ()->
    assert.equal @respBody, 'hello world!'
