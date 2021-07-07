VERSION=1.0.0
NAME ?= pinotspark
REPOSITORY?=938175221734.dkr.ecr.ap-northeast-1.amazonaws.com/datascience-dev

IMAGE ?= $(REPOSITORY)/$(NAME):$(VERSION)
IMAGE_LATEST ?= $(REPOSITORY)/$(NAME):latest

build:
	docker build -t $(IMAGE) -t $(IMAGE_LATEST) .
	
push:
	echo $(REPOSITORY)
	docker push $(IMAGE)
	docker push $(IMAGE_LATEST)	

install:
