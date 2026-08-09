# Class-representative fixture, not a dummy: a real base image, a real
# binary built from this workspace, and a runtime that can be smoke-tested
# by running it. A `FROM scratch` marker file would exercise the workflow's
# plumbing while proving nothing about a build that can actually fail.
#
# It is also conformant, because the org gate scans it like any other
# Dockerfile — a fixture that cannot pass the gate is not representative of
# the repositories it stands in for. trivy's DS-0002 and DS-0026 both fired
# on the first version of this file.
FROM rust:1.97-slim AS build
WORKDIR /src
COPY Cargo.toml Cargo.lock ./
COPY crates ./crates
RUN cargo build --release --locked --bin lab-cli

FROM debian:trixie-slim@sha256:3a39a0592364683e6bab97937b72cad5a8fa6dcbbee90edb3bb48c7f8e94f258
COPY --from=build /src/target/release/lab-cli /usr/local/bin/lab-cli

# DS-0002: never root. A container escape from a root process is a host
# compromise; from an unprivileged one it is much less.
RUN useradd --system --no-create-home --shell /usr/sbin/nologin lab
USER lab

# DS-0026: the binary answering at all is the only meaningful liveness
# signal a CLI image has.
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD ["/usr/local/bin/lab-cli", "--help"]

ENTRYPOINT ["/usr/local/bin/lab-cli"]
