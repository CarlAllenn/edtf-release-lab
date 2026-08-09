# LAB ONLY. The smallest possible real image: `scratch` needs no base pull at
# all, so this scenario tests the SIGNING path without dragging in a registry
# fetch, a buildkit bootstrap, or an egress allowlist for either.
#
# The image is never run. It exists to have a digest that attest-oci.yml can
# sign and verify-oci.yml can check.
FROM scratch
COPY docker/PAYLOAD /PAYLOAD
