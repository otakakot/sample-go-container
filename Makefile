SHELL := /bin/bash
include .env
export
export APP_NAME := $(basename $(notdir $(shell pwd)))

.PHONY: help
help: ## display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: build
build: ## go build
	@go build -v ./... && go clean

.PHONY: fmt
fmt: ## go format
	@go fmt ./...

.PHONY: login
login: ## login ko
	@ko login --username ${USERNAME} --password ${PASSWORD} index.docker.io

.PHONY: container
container: ## build docker image container with ko. need ko login --username ${USERNAME} --password ${PASSWORD} index.docker.io
	@KO_DOCKER_REPO=otakakot/sample-go-container \
     SOURCE_DATE_EPOCH=$(date +%s) \
     ko build --sbom=none --bare --tags=latest ./ --platform=linux/amd64
