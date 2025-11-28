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

# ----------- Подготовка к первой инициализации проекта (сейчас закомментарено так как по идее нужно сделать однократно):
# точка монтирования была просто 
#    volumes:
#       - .:/app
#       - /app/node_modules
# Copy package files first for better caching
# COPY package*.json ./

# Install Node.js dependencies
# RUN npm install
# ----------- Подготовка к первой инициализации проекта:


# Install napi-rs/cli globally
RUN npm install -g @napi-rs/cli

RUN rustup target add x86_64-unknown-linux-gnu

# Copy the rest of the application code
# COPY . .

# Runs when the container launches. Migrating, list migration status, start app
CMD ["sh", "startup.sh"]
