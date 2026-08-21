# Class-representative fixture, not a dummy: a real binary built from
# this workspace by the oci-image class's own build — natively, per architecture,
# in the mise-pinned toolchain — and COPYed in. No build stage and no
# compile in here, by rule (#295): the repro gate proved the
# in-container cargo build nondeterministic while the pinned native
# toolchain built the same crates bit-for-bit, so a Dockerfile that
# compiles is the failure mode. `scratch` because the binary is
# musl-static: no base userland means no base CVEs to triage, and
# nothing left in the image that can vary — the image is a pure
# function of one deterministic artifact.
FROM scratch
COPY dist/lab-cli /usr/local/bin/lab-cli

# DS-0002: never root. scratch has no /etc/passwd to useradd into, so
# the user is numeric — 65534 (nobody), which a static binary needs no
# lookup to run as.
USER 65534:65534

# DS-0026: the binary answering at all is the only meaningful liveness
# signal a CLI image has.
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD ["/usr/local/bin/lab-cli", "--help"]

ENTRYPOINT ["/usr/local/bin/lab-cli"]
