SHELL := /bin/sh
PY_VERSION := 3.6
PYTHON := $(shell /usr/bin/which python$(PY_VERSION))

BASE_DIR := $(shell /bin/pwd)
ZIP_FILE := $(BASE_DIR)/bundle.zip

DOCKER_IMAGE := lambci/lambda:build-python3.6

.PHONY: build
build:
	docker run -v $$PWD:/var/task --rm -it $(DOCKER_IMAGE) /bin/bash -c 'make vendor'

.PHONY: rebuild
rebuild:
	docker run -v $$PWD:/var/task --rm -it $(DOCKER_IMAGE) /bin/bash -c 'make clean vendor'

.PHONY: bundle
bundle:
	docker run -v $$PWD:/var/task --rm -it $(DOCKER_IMAGE) /bin/bash -c 'make clean archive'
 
.PHONY: clean
clean:
	rm -f $(ZIP_FILE)
	rm -rf $(BASE_DIR)/vendor
	rm -f $(BASE_DIR)/requirements.txt

.PHONY: init
init:
	$(PYTHON) -m pip --disable-pip-version-check install pipenv

.PHONY: vendor
vendor: init
	pipenv lock --requirements > $(BASE_DIR)/requirements.txt
	pipenv run pip --disable-pip-version-check install --no-binary :all: -U -t $(BASE_DIR)/vendor -r $(BASE_DIR)/requirements.txt

.PHONY: archive
archive: vendor
	zip -r9 $(ZIP_FILE) example
	zip -r9 $(ZIP_FILE) vendor
