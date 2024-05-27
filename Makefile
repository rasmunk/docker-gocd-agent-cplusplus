OWNER=ucphhpc
IMAGE=gocd-agent-cplusplus
# Enable that the builder should use buildkit
# https://docs.docker.com/develop/develop-images/build_enhancements/
DOCKER_BUILDKIT=1
# NOTE: dynamic lookup with docker as default and fallback to podman
DOCKER=$(shell which docker || which podman)
TAG=edge
ARGS=

.PHONY: build

all: clean build test

build:
	${DOCKER} build -t $(OWNER)/$(IMAGE):$(TAG) $(ARGS) .

clean:
	${DOCKER} rmi -f $(OWNER)/$(IMAGE):$(TAG) $(ARGS)

push:
	${DOCKER} push ${OWNER}/${IMAGE}:${TAG} $(ARGS)
