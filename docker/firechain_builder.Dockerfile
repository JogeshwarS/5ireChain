FROM rust:1.61.0 AS builder

WORKDIR /5ire

COPY . /5ire

<<<<<<< HEAD
ARG environment

=======
>>>>>>> bb2c735 (updated Docker ga file (#128))
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true

RUN apt-get update && apt-get install -y protobuf-compiler libclang-dev

<<<<<<< HEAD
RUN cargo build --release --features firechain-${environment}

FROM debian:stable-slim

ARG environment
=======
RUN cargo build --release --features firechain-thunder

FROM debian:bullseye-slim
>>>>>>> bb2c735 (updated Docker ga file (#128))

WORKDIR /5ire

COPY --from=builder /5ire/target/release/firechain-node /5ire/firechain-node

<<<<<<< HEAD
COPY --from=builder /5ire/specs/5ire-${environment}-specRaw.json /5ire/specs/5ire-${environment}-specRaw.json
=======

COPY --from=builder /5ire/specs/5ire-thunder-specRaw.json /5ire/specs/5ire-thunder-specRaw.json
>>>>>>> bb2c735 (updated Docker ga file (#128))

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl git openssh-client; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN ldd /5ire/firechain-node
RUN /5ire/firechain-node --version

EXPOSE 30333 9944

VOLUME ["5ire/data"]

ENTRYPOINT ["/5ire/firechain-node"]