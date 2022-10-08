IMAGE_NAME=jannylund/sparsnas_decoder
IMAGE_TAG=latest


.PHONY: build-docker
build-docker:
	docker build --platform linux/amd64 . -t ${IMAGE_NAME}:${IMAGE_TAG}

.PHONY: push-docker
push-docker:
	docker build --platform linux/amd64 . -t ${IMAGE_NAME}:${IMAGE_TAG}