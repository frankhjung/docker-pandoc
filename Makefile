#!/usr/bin/make

.PHONY: build-image help version

.DEFAULT_GOAL := version

PROJECT_NAME    := pandoc
PANDOC_VERSION := $(shell awk -F= '/^ARG PANDOC_VERSION=/{print $$2; exit}' Dockerfile)
DOCKER         ?= docker

help: ## Show this help message
	@echo Available targets:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | awk 'BEGIN {FS = ":.*?## "}; \
	         {printf "  %-20s %s\n", $$1, $$2}'

build-image: ## Build the Docker image
	@$(DOCKER) buildx build --load \
	  --build-arg PANDOC_VERSION=$(PANDOC_VERSION) \
	  --tag $(PROJECT_NAME):$(PANDOC_VERSION) \
	  --tag $(PROJECT_NAME):latest \
	  .

images: ## List local images for this project
	@$(DOCKER) image ls $(PROJECT_NAME)

doctor: ## Show Docker context, builder, and project images
	@echo "== Docker context =="
	@$(DOCKER) context show
	@echo
	@echo "== Docker contexts =="
	@$(DOCKER) context ls
	@echo
	@echo "== Buildx builders =="
	@$(DOCKER) buildx ls
	@echo
	@echo "== Project images =="
	@$(DOCKER) image ls $(PROJECT_NAME)

version: build-image ## Show container version
	@$(DOCKER) run --rm $(PROJECT_NAME):latest
