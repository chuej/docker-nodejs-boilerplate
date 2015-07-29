Router = require('express').Router
routes = require './routes'
initializeRouter = ()->
  router = new Router()
  router.route '/test'
    .get routes.test.get
  return router

module.exports = initializeRouter()
