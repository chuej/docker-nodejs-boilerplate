NODE_ENV=development
MONGO_URI=172.17.42.1:27010:/boilerplate
TEST_MONGO_URI=172.17.42.1:27010:/boilerplate-test
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
COMMIT=$(shell git rev-parse --short HEAD)
REPO=boilerplate
IMAGE=${REPO}_${BRANCH}
CONTAINER=${REPO}_${COMMIT}
log:
	@echo "REPO:::::${REPO}"
	@echo "BRANCH:::${BRANCH}"
	@echo "COMMMIT::${COMMIT}"
build:
	docker build -t ${IMAGE} .
setup:
	docker run -d -it \
		--name ${CONTAINER} \
		--env NODE_ENV=${NODE_ENV} \
		--env MONGO_URI=${MONGO_URI} \
		--dns 172.17.42.1 \
		-p "9000:5000" \
		-v `pwd`/app:/opt/app/app \
		${IMAGE};
run: build setup
teardown: test_teardown
	-docker rm -f ${CONTAINER}
test: build test_setup run_tests test_teardown
test_setup:
	docker run -d -it \
		--name ${CONTAINER}_test \
		--env NODE_ENV=${NODE_ENV} \
		--env MONGO_URI=${MONGO_URI} \
		--env TEST_MONGO_URI=${TEST_MONGO_URI} \
		--dns 172.17.42.1 \
		--expose 5000 \
		-v `pwd`/app:/opt/app/app \
		${IMAGE};
test_teardown:
	-docker rm -f ${CONTAINER}_test
run_tests:
	docker exec ${CONTAINER}_test sh bin/test
