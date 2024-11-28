FROM --platform=linux/riscv64 docker.io/ubuntu:latest

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    binutils-riscv64-linux-gnu \
    gcc-riscv64-linux-gnu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy your assembly files (if any)
# COPY . .

# Set the default command
CMD ["/bin/bash"]

