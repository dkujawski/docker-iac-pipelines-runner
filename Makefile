IMAGE_NAME=dave_kujawski/iac-pipelines-runner
IMAGE_VERSION=0.1.6
DOCKERFILE=Dockerfile
REGISTRY=quay.io

.PHONY: help
	.DEFAULT_GOAL := help

help: ## show this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## build docker image
	docker build -f ${DOCKERFILE} -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION} .

push: ## push image to repository
	docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_VERSION}
