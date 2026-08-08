#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) the edtf contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
# Write SHA256SUMS over the stub tarballs and prove the matrix is whole.
#
# Lab sibling of the production checksum-artifacts.sh: same shape (explicit
# expected-count assertion, sorted stable output, manifest lands in dist/
# beside the artifacts it names), reduced to the lab's two-target CLI
# matrix. The count assertion is the point: a missing matrix cell is
# otherwise invisible and the release would claim N tarballs with N-1
# attached.
set -euo pipefail

VERSION="${VERSION:?VERSION must be set}"

CLI_TARGETS=(
  x86_64-unknown-linux-gnu
  aarch64-unknown-linux-gnu
)

expected=${#CLI_TARGETS[@]}

missing=()
for target in "${CLI_TARGETS[@]}"; do
  name="lab-cli-${VERSION}-${target}.tar.gz"
  if [[ ! -f "dist/${name}" ]]; then
    missing+=("${name}")
  fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "::error::${#missing[@]} of ${expected} tarballs are missing:"
  printf '::error::  %s\n' "${missing[@]}"
  exit 1
fi

# Sorted, so the file is stable across runs regardless of download order.
(cd dist && sha256sum lab-cli-*.tar.gz | sort -k2 > SHA256SUMS)

echo "::notice::${expected} tarballs present and checksummed"
cat dist/SHA256SUMS
