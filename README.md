# release-lab

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/monumental-archive/release-lab/badge)](https://scorecard.dev/viewer/?uri=github.com/monumental-archive/release-lab)
[![SLSA 3](https://img.shields.io/badge/SLSA-Build%20L3-2ea44f)](https://github.com/monumental-archive/.github/blob/main/docs/runbook.md#verifying-as-a-consumer-would)

<!-- Deferred shields, each behind a human step (.github#88):
Best Practices — form binds a logged-in account; fill from the canon's docs/best-practices.md, then:
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/BP_ID/badge)](https://www.bestpractices.dev/projects/BP_ID)
REUSE — register the repo at api.reuse.software (FSFE login), then:
[![REUSE status](https://api.reuse.software/badge/github.com/monumental-archive/release-lab)](https://api.reuse.software/info/github.com/monumental-archive/release-lab)
-->

[![ghcr](https://img.shields.io/badge/ghcr.io-monumental--archive-blue)](https://github.com/orgs/monumental-archive/packages)
The org's release lab: where risky release machinery is proven before any
production repository runs it. Fixture crates, **real GitHub APIs, real
credentials, real rulesets**, no registry publishes.

Nothing here ships, and since the repro gate (.github#118) nothing anywhere ships without a bit-for-bit rebuild agreeing first — this repository is where that gate was proven, red before green. The crates have no consumers, no registry is ever
published to, and every release cut here is disposable. The canon it proves
lives in
[monumental-archive/.github](https://github.com/monumental-archive/.github)
— `docs/release.md`. Repositories conform to that canon; this is where the
canon is exercised first.

This repo piloted the SLSA v1.2 source track (org `.github#120`):
signed source provenance + VSAs under this repo's own workflow identity,
stored in `refs/notes/commits` and stranger-verified. The pilot proved
the pipeline and surfaced four upstream defects in
`slsa-framework/source-tool`; the machinery is parked until upstream is
stable on org-level rulesets. The genesis attestations remain in the
notes ref as the record.

## Why a separate repository

A reusable workflow cannot run on its own — it needs a caller, and the
caller has to be a repository. Letting `.github` call its own workflows is
not enough, and that is not a theory: the shared gate carried a
`github.workflow_sha` bug precisely because its only exerciser lived in the
same repository, where the caller's SHA and the reusable workflow's SHA
happen to be identical. It broke the moment a different repository called
it.

So the lab is three things at once:

- **A foreign caller.** The only way to exercise the cross-repository path
  — `job_workflow_sha`, permission downgrades, secrets forwarding, App
  tokens crossing a repository boundary.
- **Fixtures.** The shared workflows are generic, but they still need real
  inputs to execute their real code paths.
- **A cheap blast radius.** Release failures are mostly irreversible:
  crates.io is yank-only, a published GHCR digest exists forever, an
  immutable release cannot be repaired. Here they cost nothing.

The standing job is the last one. `uses:` accepts no expressions, so a
caller's SHA pin is frozen into whatever ref it ran from — **a bug in a
shared workflow is permanent for every tag already pinned to it.** Every
change to a shared workflow needs a foreign caller to prove it before any
production repository bumps its pin.

## Phase 1 canon: proven here

`release.yml` is the caller stub for the shared phase-1 workflow
(`monumental-archive/.github/.github/workflows/release.yml`, SHA-pinned).
This repository holds no release logic of its own — it is the first
conforming consumer.

Proving it live caught four defects before any production repository was
touched:

| Defect | How it presented | Fix |
| --- | --- | --- |
| Canon checkout used `github.workflow_sha` | `upload-pack: not our ref` — the entry-point workflow's SHA is the *caller's* commit | `github.job_workflow_sha` |
| Same bug latent in the shared CI gate | never failed: its only caller lives in the same repo, where both SHAs coincide | fixed together |
| `git-cliff` absent from the toolbelt | `git: 'cliff' is not a git command` | belt standup |
| Tag-mint App lacked `pull_requests: write` | `The permissions requested are not granted to this installation` | App permission + install approval |

## The `v*` tag-creation lock

Canon: humans never push release tags; only the pipeline's App mints them.
The ruleset restricts `v*` **creation** with the tag-mint App as sole bypass
actor.

Both halves are proven here under `enforcement: active` — note that
`evaluate` proves *neither*, since it enforces nothing and bypass actors
record no evaluation, so an empty rule-suite list looks identical whether
the lock works perfectly or does not exist:

| Half | Repro | Expected |
| --- | --- | --- |
| Negative | `git tag -a v9.9.9-x -m x && git push origin v9.9.9-x` as a human | `GH013 ... Cannot create ref due to creations being restricted.` |
| Positive | merge a release PR; the tag job mints the tag via the App | annotated tag + draft release appear |

`current_user_can_bypass: never` is the check that the org owner is bound
too.

## Phase 2: not yet

Phase-2 canon (build, publish, prove, sign) is not designed. When it is,
this repository grows **class-representative fixtures** — one per artifact
class, each minimal but structurally honest enough to make the shared build
workflows execute their real code paths and reach their real network
endpoints. Toy crates cannot do that: an egress allowlist derived from a
fixture that never pulls a real toolchain is correct for nothing.

The previous generation of scenarios drove one project's legacy pipeline
and has been removed, along with the one-off repros that diagnosed past
failures. What they found is recorded in `docs/slsa-reference.md` and the
hardening lessons in the canon repository; git history keeps the rest.

## Housekeeping

Immutable releases are ON (the draft-then-publish shape depends on it). Old
lab releases and tags are disposable; delete them freely between runs —
this repository has no consumers.

## Source attestation

This repository's source chain was founded at `ea49b2f0` (2026-08-12) by
`.github/workflows/source-attest.yml`, the reserved signing identity.
Every revision on `main` since carries signed source provenance and a
source VSA in `refs/notes/commits`. Verify any of them with nothing but
the published root of trust (`docs/source-assessment.md` in the canon):

```bash
san="https://github.com/monumental-archive/release-lab"
san="${san}/.github/workflows/source-attest.yml@refs/heads/main"
cosign verify-blob --bundle <bundle> --certificate-identity "${san}" \
  --certificate-oidc-issuer \
  https://token.actions.githubusercontent.com <statement>
```

Unlike releases, the notes chain is **not** disposable: each link verifies
its predecessor, so deleting notes breaks verification for everything after.

## v1.13.0 verdict width

This release exists to prove the canon v1.13.0 verdict machinery at
full width: post-publish VSAs for every class this repository ships —
release-asset pull-back for binaries and extension tarballs, tag→digest
binding plus oci:// verification for the image and the per-major
extension images, and the npm registry leg. The measured facts land in
the canon issue tracker, per the run-sheet.
