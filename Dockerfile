# Build stage
FROM rust:1.74 as builder

# Verificación opcional de versión
RUN rustc --version && cargo --version

WORKDIR /app

# Copiar todo el código de una
COPY . .

# Compilar en modo release
RUN cargo build --release

# Runtime stage (más liviano)
FROM debian:bullseye-slim
WORKDIR /app

# Copiar solo el binario desde el builder
COPY --from=builder /app/target/release/rust-api .

# Exponer el puerto usado por la app
EXPOSE 8080

# Ejecutar el binario
CMD ["./rust-api"]
