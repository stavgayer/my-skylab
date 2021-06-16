VERSION=1.0.0
NAME ?= pinotspark
REPOSITORY?=asia.gcr.io/unext-recommender-system/dsml

IMAGE ?= $(REPOSITORY)/$(NAME):$(VERSION)
IMAGE_LATEST ?= $(REPOSITORY)/$(NAME):latest

build:
	docker build -t $(IMAGE) -t $(IMAGE_LATEST) .
	
push:
	echo $(REPOSITORY)
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)	

install:
