PACKAGE_NAME=gocd-agent-cplusplus
PACKAGE_NAME_FORMATTED=$(subst -,_,$(PACKAGE_NAME))
OWNER=ucphhpc
IMAGE=$(PACKAGE_NAME)
# Enable that the builder should use buildkit
# https://docs.docker.com/develop/develop-images/build_enhancements/
DOCKER_BUILDKIT=1
# NOTE: dynamic lookup with docker as default and fallback to podman
DOCKER=$(shell which docker || which podman)
# if docker compose plugin is not available, try old docker-compose/podman-compose
ifeq (, $(shell ${DOCKER} help|grep compose))
	DOCKER_COMPOSE=$(shell which docker-compose || which podman-compose)
else
	DOCKER_COMPOSE=${DOCKER} compose
endif
$(echo ${DOCKER_COMPOSE} >/dev/null)
TAG=edge
ARGS=

.PHONY: all
all: init dockerbuild

.PHONY: init
init:
ifeq ($(shell test -e defaults.env && echo yes), yes)
ifneq ($(shell test -e .env && echo yes), yes)
		ln -s defaults.env .env
endif
endif

.PHONY: dockerbuild
dockerbuild:
	${DOCKER_COMPOSE} build ${ARGS}

.PHONY: dockerclean
dockerclean:
	${DOCKER} rmi -f ${OWNER}/${IMAGE}:${TAG}

.PHONY: dockerpush
dockerpush:
	${DOCKER} push ${OWNER}/${IMAGE}:${TAG}

.PHONY: clean
clean: dockerclean
	rm -fr .env
	rm -fr .pytest_cache
	rm -fr tests/__pycache__

.PHONY: uninstallinstall
uninstalltest:
### PLACEHOLDER ###

.PHONY: installtest
installtest:
### PLACEHOLDER ###

.PHONY: test
test:
### PLACEHOLDER ###
