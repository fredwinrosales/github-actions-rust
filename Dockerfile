# Build stage
FROM rust:1.74 as builder
WORKDIR /app
COPY . .
RUN cargo build --release

# Runtime stage
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/target/release/rust-api .
CMD ["./rust-api"]
EXPOSE 8080
