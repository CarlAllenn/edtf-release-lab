#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) the edtf contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
# Produce the stub tarballs the release half consumes.
#
# LAB ONLY. The production pipeline builds real binaries on native runners;
# this repository exists to exercise the RELEASE half — tag creation, draft
# assembly, asset upload, immutability, resume — which is indifferent to
# what the bytes are. Each tarball contains the built lab-cli binary so the
# artifacts are honest executables, but no cross-compilation is attempted:
# both "targets" carry this runner's build. Deliberately NOT reproducible
# across runs (a timestamp file is included) so resume paths face the same
# rebuilt-bytes-differ reality the production pipeline documents.
set -euo pipefail

VERSION="${VERSION:?VERSION must be set}"

CLI_TARGETS=(
  x86_64-unknown-linux-gnu
  aarch64-unknown-linux-gnu
)

cargo build --release -p lab-cli

mkdir -p dist
stage=$(mktemp -d)
trap 'rm -rf "${stage}"' EXIT

for target in "${CLI_TARGETS[@]}"; do
  dir="${stage}/lab-cli-${VERSION}-${target}"
  mkdir -p "${dir}"
  cp target/release/lab-cli "${dir}/lab-cli"
  date -u +%s%N > "${dir}/BUILT_AT"
  tar -czf "dist/lab-cli-${VERSION}-${target}.tar.gz" -C "${stage}" \
    "lab-cli-${VERSION}-${target}"
  echo "::notice::built stub dist/lab-cli-${VERSION}-${target}.tar.gz"
done
