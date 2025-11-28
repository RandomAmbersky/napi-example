FROM node:18-alpine

# Install system dependencies for napi-rs and Rust
RUN apk add --no-cache \
    curl \
    build-base \
    python3 \
    git \
    musl-dev \
    libc-dev \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source $HOME/.cargo/env

ENV PATH="/root/.cargo/bin:${PATH}"
ENV RUSTFLAGS="-C link-arg=-Wl,--compress-debug-sections=none"

WORKDIR /app

# Copy package files first for better caching
# COPY package*.json ./

# Install Node.js dependencies
# RUN npm install

# Install napi-rs/cli globally
RUN npm install -g @napi-rs/cli

RUN rustup target add x86_64-unknown-linux-gnu

# Copy the rest of the application code
COPY . .

# Default command (can be overridden in docker-compose)
CMD ["npm", "run", "build"]
