#!/usr/bin/env bash
# Smoke test for the rust-binary class. $1 is the staged-binaries
# directory, $2 the target triple. Every leg runs on native hardware, so
# the binary is simply executed and must say its own version.
set -euo pipefail
dir="$1"
target="$2"
out=$("${dir}/lab-cli")
echo "${target}: ${out}"
[[ ${out} == lab-cli\ *answer:\ 42* ]] || {
  echo "unexpected output: ${out}" >&2
  exit 1
}
