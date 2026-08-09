#!/usr/bin/env bash
# Reproduce the edtf#132 canary stall point under one variable at a time.
#
# canary.sh's first cargo invocation is `cargo new`, and the first surviving
# production log (run 31271812619, finish job) shows the step emitting ZERO
# bytes across 2m56s — so it stalls at or before that call. This script does
# the same three things canary.sh does before it, in the same order, with a
# heartbeat and a bound on every one.
#
# LAB DIVERGENCE: probes the already-published 1.2.0 crates. Nothing here
# publishes, and no release is touched.

# NOT `set -e`: a stalled probe must still reach the diagnostics below.
set -uo pipefail

beat() { echo "[$(date -u +%H:%M:%S)Z] $*"; }

beat "=== environment as mise-action left it ==="
echo "  cargo resolves to : $(command -v cargo || echo '(not on PATH)')"
echo "  RUSTUP_TOOLCHAIN  : ${RUSTUP_TOOLCHAIN:-unset}"
echo "  RUSTUP_HOME       : ${RUSTUP_HOME:-unset}"
echo "  CARGO_HOME        : ${CARGO_HOME:-unset}"
echo "  installed toolchains:"
find "${RUSTUP_HOME:-${HOME}/.rustup}/toolchains" -maxdepth 1 -mindepth 1 \
  -printf '    %f\n' 2> /dev/null || echo "    (no toolchains directory)"

beat "cargo --version (bounded, before any CARGO_HOME change)"
timeout 60 cargo --version
echo "  rc=$?"

scratch=$(mktemp -d)
trap 'rm -rf "${scratch}"' EXIT

if [[ ${UNSET_RUSTUP_ENV} == "yes" ]]; then
  beat "unsetting RUSTUP_TOOLCHAIN and RUSTUP_HOME"
  unset RUSTUP_TOOLCHAIN RUSTUP_HOME
fi

if [[ ${REPOINT_CARGO_HOME} == "yes" ]]; then
  # Exactly what canary.sh does: an empty CARGO_HOME, with RUSTUP_HOME
  # (if still set) pointing at the real, populated install.
  export CARGO_HOME="${scratch}/cargo"
  beat "CARGO_HOME repointed at an empty dir: ${CARGO_HOME}"
else
  beat "CARGO_HOME left as-is: ${CARGO_HOME:-unset}"
fi

beat ">>> cargo new --lib  (THE PRODUCTION STALL POINT)"
rc=0
timeout 180 cargo new --lib "${scratch}/probe" || rc=$?
beat "<<< cargo new returned rc=${rc}"

if [[ ${rc} -ne 0 ]]; then
  echo "::error::cargo new did not complete (rc=${rc}; 124 means the bound fired)"
  beat "post-mortem"
  # shellcheck disable=SC2012 # human-readable diagnostics, not parsed
  {
    echo "  CARGO_HOME contents:"
    ls -la "${CARGO_HOME:-/nonexistent}" 2> /dev/null | sed 's/^/    /' \
      || echo "    (absent or unreadable)"
    echo "  scratch contents:"
    ls -la "${scratch}" 2> /dev/null | sed 's/^/    /'
  }
  exit 1
fi

beat "cargo new completed — continuing to the registry probe"
rc=0
timeout 300 cargo add --manifest-path "${scratch}/probe/Cargo.toml" \
  "edtf-core@=1.2.0" || rc=$?
beat "cargo add returned rc=${rc}"
[[ ${rc} -eq 0 ]] || exit 1

beat "ALL PROBES PASSED"
