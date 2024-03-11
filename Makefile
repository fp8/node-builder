#!/bin/bash

# ===========================================================
# Author:   Marcos Lin
# Created:  28 Jun 2020
#
# Makefile used to setup node-builder
#
# ===========================================================

IMAGE_PREFIX   := farport
INST_NAME      := node-builder
IMAGE_VERSION  := 18.19.1

IMAGE_NAME     := $(IMAGE_PREFIX)/$(INST_NAME):$(IMAGE_VERSION)



# ------------------
# USAGE: First target called if no target specified
.PHONY : man
man :
	@cat README.md



# ------------------
# Check dependencies
.PHONY : init
init :
ifeq ($(shell which docker),)
	$(error docker command needed to be installed.)
endif



# ------------------
# Build Docker Image
.PHONY : build alpine buster

alpine buster bookworm : init
	docker build --rm --platform linux/amd64 -f Dockerfile.$@ -t $(IMAGE_NAME)-$@ .
	@echo "Docker image $(IMAGE_NAME)-$@ built"

build : alpine buster bookworm



# ------------------
# Push Docker Image
.PHONY : push push-alpine push-buster push-bookworm

push-alpine push-buster push-bookworm :
	docker push $(IMAGE_NAME)-$(patsubst push-%,%,$@)

push : push-alpine push-buster push-bookworm



# ------------------
# Connect Docker Image
.PHONY : connect-alpine connect-buster connect-bookworm

connect-alpine connect-buster connect-bookworm :
	docker run --rm -it $(IMAGE_NAME)-$(patsubst connect-%,%,$@) /bin/sh

push : connect-alpine connect-buster connect-bookworm



# ------------------
# Clean Docker Image
.PHONE : clean clean-alpine clean-buster clean-bookworm

clean-alpine clean-buster clean-bookworm :
	docker rmi $(IMAGE_NAME)-$(patsubst clean-%,%,$@)

clean : clean-alpine clean-buster clean-bookworm
