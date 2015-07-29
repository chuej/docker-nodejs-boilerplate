routes =
  test:
    get: (req, res, next)->
      return res.send 'hello world!'

module.exports = routes
