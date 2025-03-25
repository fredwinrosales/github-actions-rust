# Build stage
FROM rust:1.74 as builder

WORKDIR /app
COPY . .

# Esto generará automáticamente el Cargo.lock correcto
RUN cargo build --release

# Runtime stage
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/target/release/rust-api .

EXPOSE 8080
CMD ["./rust-api"]
