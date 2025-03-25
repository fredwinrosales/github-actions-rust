# Etapa 1: builder
FROM rust:1.75 as builder

WORKDIR /app

# 👇 Copiamos solo lo necesario para compilar dependencias primero
# Ahora:
COPY Cargo.toml ./
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release
RUN rm -r src

# 👇 Ahora copiamos el código real
COPY . .
RUN cargo build --release

# Etapa 2: runtime
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/target/release/rust-api .

EXPOSE 8080
CMD ["./rust-api"]