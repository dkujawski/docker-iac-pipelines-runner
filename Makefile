IMAGE_NAME=dave_kujawski/iac-pipeline-runner
IMAGE_VERSION=0.1.3
DOCKERFILE=Dockerfile
REPOSITORY=quay.io

export DOCKERFILE REPOSITORY

.PHONY: help
	.DEFAULT_GOAL := help

help: ## show this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build:
	docker build -f ${DOCKERFILE} -t ${REGISTRY}/$${IMAGE_NAME}:$${IMAGE_VERSION} .

push:
	docker push ${DOCKERFILE} -t ${REGISTRY}/$${IMAGE_NAME}:$${IMAGE_VERSION}
