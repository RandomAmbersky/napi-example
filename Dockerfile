FROM node:18-alpine

# Install system dependencies for napi-rs and Rust
RUN apk add --no-cache \
    curl \
    build-base \
    python3 \
    git \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && source $HOME/.cargo/env

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Install napi-rs/cli globally
RUN npm install -g @napi-rs/cli

# Copy the rest of the application code
COPY . .

# Default command (can be overridden in docker-compose)
CMD ["npm", "run", "build"]
