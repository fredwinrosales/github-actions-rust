# Build stage
FROM rust:1.74 as builder

WORKDIR /app
COPY . .

# Limpieza explícita por si el archivo persiste
RUN rm -f Cargo.lock

# Esto generará automáticamente el Cargo.lock correcto
RUN cargo build --release

# Runtime stage
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/target/release/rust-api .

EXPOSE 8080
CMD ["./rust-api"]
