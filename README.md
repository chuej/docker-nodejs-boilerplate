#What is it?
Put simply, this is a boilerplate for a Node.js app on Docker. There is some baked-in goodness, like a ```mongoose``` connection and ```mocha``` tests. I've also included a ```docker-compose.yml``` and ```Makefile``` for dev workflows. The boilerplate is configured to expose port ```5000``` internally, which is mapped to ```9000``` on the host.

There are three ```bin``` files which will run in the container:
- ```test```: run mocha tests (any file with extension ".test.coffee")
- ```debug```: run debug server, runs on ```nodemon``` legacy and restarts on change, prints stack traces for 50x, etc.
- ```www```: run production server

#Code Organization
Coming soon...

#Usage
##docker-compose
####Run server
```
docker-compose up
```
####Run tests
```
docker-compose run --rm boilerplate sh bin/test
```
##Make
####Run server
```
make run
```
####Run tests
```
make test
```
####Teardown containers
```
make teardown
```
