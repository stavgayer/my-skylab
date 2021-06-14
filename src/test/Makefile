VERSION=1.0.0
NAME ?= test
REPOSITORY?=asia.gcr.io/unext-recommender-system/dsml

IMAGE ?= $(REPOSITORY)/$(NAME):$(VERSION)
IMAGE_LATEST ?= $(REPOSITORY)/$(NAME):latest

FROM=nvidia/cuda:9.2-devel

build:
	docker build --build-arg FROM=$(FROM) -t $(IMAGE) -t $(IMAGE_LATEST) .
	
push:
	echo $(REPOSITORY)
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)	

install:
