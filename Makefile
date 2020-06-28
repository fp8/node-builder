#!/bin/bash

# ===========================================================
# Author:   Marcos Lin
# Created:  28 Jun 2020
#
# Makefile used to setup node-builder
#
# ===========================================================

PROJ_DIR             := $(shell pwd)
SSH_DIR              := $(PROJ_DIR)/ssh

IMAGE_PREFIX   := farport
INST_NAME      := node-builder
IMAGE_VERSION  := 10.20.0
IMAGE_NAME     := $(IMAGE_PREFIX)/$(INST_NAME):$(IMAGE_VERSION)

# ------------------
# USAGE: First target called if no target specified
man :
	@cat README.md

# ------------------
# Check dependencies
.PHONY : init
init :
ifeq ($(shell which docker),)
	$(error docker command needed to be installed.)
endif

.PHONY : alpine buster
alpine buster :
	docker build -f Dockerfile.$@ -t $(IMAGE_NAME)-$@ .
	@echo "Docker image $(IMAGE_NAME)-$@ built"

.PHONY : setup
setup : alpine buster

.PHONE : clean clean-alpine clean-buster
clean-alpine :
	@echo "### Removing docker image $(IMAGE_NAME)-alpine"
	@docker rmi $(IMAGE_NAME)-alpine
clean-buster :
	@echo "### Removing docker image $(IMAGE_NAME)-buster"
	@docker rmi $(IMAGE_NAME)-buster
clean : clean-alpine clean-buster
