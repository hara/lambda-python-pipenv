SHELL := /bin/sh
PY_VERSION := 3.6
PYTHON := $(shell /usr/bin/which python$(PY_VERSION))

BUCKET ?= <<bucket>>
S3_PREFIX ?= sources
STACK_NAME ?= stack-lambda-example

BASE_DIR := $(shell /bin/pwd)

DOCKER_IMAGE := lambci/lambda:build-python3.6

.PHONY: build
build:
	docker run -v $$PWD:/var/task --rm -it $(DOCKER_IMAGE) /bin/bash -c 'make vendor'

.PHONY: rebuild
rebuild:
	docker run -v $$PWD:/var/task --rm -it $(DOCKER_IMAGE) /bin/bash -c 'make clean vendor'

.PHONY: package
package: rebuild
	sam package \
		--template-file template.yaml \
		--s3-bucket $(BUCKET) \
		--s3-prefix $(S3_PREFIX) \
		--output-template-file packaged.yaml

.PHONY: package
deploy:
	sam deploy \
		--template-file packaged.yaml \
		--stack-name $(STACK_NAME) \
		--capabilities CAPABILITY_IAM

.PHONY: clean
clean:
	find $(BASE_DIR)/example/vendor -mindepth 1 -maxdepth 1 -not -name __init__.py | xargs rm -rf
	rm -f $(BASE_DIR)/requirements.txt

.PHONY: init
init:
	$(PYTHON) -m pip --disable-pip-version-check install pipenv

.PHONY: vendor
vendor: init
	pipenv lock --requirements > $(BASE_DIR)/requirements.txt
	pipenv run pip --disable-pip-version-check install --no-binary :all: -U -t $(BASE_DIR)/example/vendor -r $(BASE_DIR)/requirements.txt
