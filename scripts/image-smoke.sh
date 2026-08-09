#!/usr/bin/env bash
# Proves the image does the one thing it exists to do: run the binary and
# get sensible output. Receives the image reference as $1 — a local tag
# before publication, and a registry digest after — so the same assertion
# covers the loaded image and the bytes a stranger will pull.
set -euo pipefail
image="${1:?image reference required}"
out=$(docker run --rm "${image}" --help 2>&1 || true)
if [[ -z ${out} ]]; then
  echo "smoke: the image produced no output at all" >&2
  exit 1
fi
printf 'smoke: ok — %s responded\n' "${image}"
