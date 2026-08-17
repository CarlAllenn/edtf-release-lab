#!/usr/bin/env bash
# Smoke test for the go-binary class. $1 is the staged-binaries
# directory, $2 the target (<goos>-<goarch>). Every leg runs on native
# hardware, so the binary is simply executed — and it must say both its
# own answer and the platform it was built for, which is how the leg
# proves it is holding the binary for its own target rather than one
# that arrived by cross-compilation.
set -euo pipefail
dir="$1"
target="$2"
out=$("${dir}/lab-go")
echo "${target}: ${out}"
[[ ${out} == lab-go\ *answer:\ 42* ]] || {
  echo "unexpected output: ${out}" >&2
  exit 1
}
# The class names targets <goos>-<goarch>; the binary reports the pair
# Go itself sees. A disagreement means the wrong bytes reached this leg.
[[ ${out} == *" ${target/-//} "* ]] || {
  echo "binary reports a different platform than the ${target} leg it ran on: ${out}" >&2
  exit 1
}
