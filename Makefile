SHELL := /usr/bin/env bash

##@ General
.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[%a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development Environment
build-devenv: ## Builds the development environment.
	docker compose build eci-genai-devenv

connect-devenv: ## Connect to the development environment.
	docker compose up -d eci-genai-devenv
	docker exec -it eci-genai-devenv bash
