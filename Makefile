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
IMAGE_VERSION  := 16.13.0

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

alpine buster : init
	docker build --rm -f Dockerfile.$@ -t $(IMAGE_NAME)-$@ .
	@echo "Docker image $(IMAGE_NAME)-$@ built"

build : alpine buster



# ------------------
# Build Docker Image
.PHONY : push push-alpine push-buster

push-alpine push-buster :
	docker push $(IMAGE_NAME)-$(patsubst push-%,%,$@)

push : push-alpine push-buster



# ------------------
# Clean Docker Image
.PHONE : clean clean-alpine clean-buster

clean-alpine clean-buster :
	docker rmi $(IMAGE_NAME)-$(patsubst clean-%,%,$@)

clean : clean-alpine clean-buster
