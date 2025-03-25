# Build stage
FROM rust:1.74 as builder
WORKDIR /app

# Cache dependencies
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
RUN rm -r src

# Copiar el resto del código
COPY . .

# Compilar ahora con el código real
RUN cargo build --release

# Runtime stage (más liviano)
FROM debian:bullseye-slim
WORKDIR /app

# Copiar solo el binario desde el builder
COPY --from=builder /app/target/release/rust-api .

# Exponer el puerto usado por el servicio
EXPOSE 8080

# Ejecutar el binario
CMD ["./rust-api"]
