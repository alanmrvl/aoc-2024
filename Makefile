# Makefile for RISC-V Ubuntu development container

# Configuration
DOCKER = podman
IMAGE_NAME = aoc-image
AS = riscv64-linux-gnu-as
LD = riscv64-linux-gnu-ld
SRC_DIR = .
OUT_DIR = out
SRC = $(SRC_DIR)/app.s
OBJ = $(OUT_DIR)/app.o
BIN = $(OUT_DIR)/app.out

# Default target
all: build

# Build the Docker image
image-build:
	$(DOCKER) build -t $(IMAGE_NAME) .

# Remove the image
image-clean:
	$(DOCKER) rmi $(IMAGE_NAME)

# Build the binary inside the docker container
container-build:
	mkdir -p ./out
	$(DOCKER) unshare chown 0:0 -R ./out
	$(DOCKER) run --platform linux/riscv64 --rm -v $(PWD):/app:Z localhost/$(IMAGE_NAME) /bin/bash -c 'riscv64-linux-gnu-as -march=rv64imac app.s -o out/app.o'
	$(DOCKER) run --platform linux/riscv64 --rm -v $(PWD):/app:Z localhost/$(IMAGE_NAME) /bin/bash -c 'riscv64-linux-gnu-ld out/app.o -o out/app'

build: $(BIN)

$(BIN): $(OBJ)
	$(LD) $(OBJ) -o $(BIN)

$(OBJ): $(SRC) | $(OUT_DIR)
	$(AS) $(SRC) -o $(OBJ)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

clean:
	rm -r $(OUT_DIR)

# Phony targets
.PHONY: clean image-build image-clean container-build build run
