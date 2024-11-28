# Makefile for RISC-V Ubuntu development container

# Configuration
DOCKER = podman
IMAGE_NAME = aoc-image
CONTAINER_NAME = aoc-container
RUN_FLAGS = 
COMPILER =

# Default target
# all: build run

# Build the Docker image
image-build:
	$(DOCKER) build -t $(IMAGE_NAME) .

# Remove the image
image-clean:
	$(DOCKER) rmi $(IMAGE_NAME)

build:
	mkdir -p ./out
	$(DOCKER) unshare chown 0:0 -R ./out
	$(DOCKER) run --platform linux/riscv64 --rm -v $(PWD):/app:Z localhost/$(IMAGE_NAME) /bin/bash -c 'riscv64-linux-gnu-as app.s -o out/app.o'
	$(DOCKER) run --platform linux/riscv64 --rm -v $(PWD):/app:Z localhost/$(IMAGE_NAME) /bin/bash -c 'riscv64-linux-gnu-ld out/app.o -o out/app'

# Build and run in one command
# build-run: build run

clean: image-clean container-clean
	rm -rf ./out

# Phony targets
.PHONY: clean image-build image-clean build
