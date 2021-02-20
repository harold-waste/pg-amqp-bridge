FROM rust:slim AS builder

RUN apt-get update && apt-get -y install libssl-dev pkg-config

WORKDIR /usr/src/pg-amqp-bridge
COPY . .
RUN cargo install --path .


FROM debian:buster-slim

RUN apt-get update && apt-get -y install libssl-dev pkg-config

COPY --from=builder /usr/local/cargo/bin/pg-amqp-bridge /usr/local/bin/pg-amqp-bridge

CMD ["pg-amqp-bridge"]
