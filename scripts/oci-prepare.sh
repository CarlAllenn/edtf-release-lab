#!/usr/bin/env bash
# The oci-image class's prepare script (#295): build the binary OUTSIDE
# the image, in this repository's mise-pinned toolchain, so the
# Dockerfile stays pure assembly. The repro gate proved the in-container
# cargo build nondeterministic while this exact toolchain built the same
# crates bit-for-bit — the compile belongs where determinism is already
# proven. musl-static so the runtime stage can be `scratch`: no base
# userland, nothing to triage, nothing left in the image that can vary.
# Runs identically on both repro-gate legs; receives the architecture
# as $1 from build-oci-image.yml, which also supplies the
# reproducibility env (CARGO_INCREMENTAL=0, remap-path-prefix, strip
# preserved for cargo-auditable).
set -euo pipefail

arch="${1:?architecture required (amd64|arm64)}"
case "${arch}" in
  amd64) target=x86_64-unknown-linux-musl ;;
  arm64) target=aarch64-unknown-linux-musl ;;
  *)
    echo "::error::oci-prepare: unknown architecture ${arch}" >&2
    exit 1
    ;;
esac

rustup target add "${target}"
# Unconditional, like the rust-binary legs: mimalloc is a real C
# dependency and identical environments beat conditional ones.
sudo apt-get update -qq
sudo apt-get install -y -qq musl-tools

# cargo-auditable is a build input like the toolchain itself, pinned in
# this repository's mise config (cargo:cargo-auditable) — asserted, never
# installed here; an unpinned install on a release leg is a runner
# mutation. The same assertion the rust-binary class makes.
command -v cargo-auditable > /dev/null || {
  echo "::error::cargo-auditable missing — pin cargo:cargo-auditable in this repository's mise config" >&2
  exit 1
}
# `auditable`, matching the rust-binary class: the shipped binary carries
# its dependency tree in the .dep-v0 linker section, so a scanner reading
# the IMAGE sees the Rust surface of the artifact inside it
# (docs/dependency-track.md, the SBOM's image-side closure). The old
# in-container build never did this, so a scratch image was opaque to
# exactly the scanning the org runs against published digests. Stripping
# is already disabled by the class env, which is what keeps the section
# alive.
cargo auditable build --release --locked --target "${target}" --bin lab-cli

# install(1) rather than cp: the mode is asserted, not inherited, so the
# COPY into the image cannot depend on the checkout's umask.
mkdir -p dist
install -m 0755 "target/${target}/release/lab-cli" dist/lab-cli
echo "::notice::oci-prepare: dist/lab-cli built for ${target}"
