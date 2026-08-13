# release-lab

<!-- badges:begin -->
[![ci](https://github.com/monumental-archive/release-lab/actions/workflows/gate.yml/badge.svg)](https://github.com/monumental-archive/release-lab/actions/workflows/gate.yml)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/monumental-archive/release-lab/badge)](https://scorecard.dev/viewer/?uri=github.com/monumental-archive/release-lab)
[![SLSA Build L3](https://img.shields.io/badge/SLSA-Build%20L3-2ea44f)](https://github.com/monumental-archive/.github/blob/main/docs/runbook.md#verifying-as-a-consumer-would)
[![SLSA Source L3](https://img.shields.io/badge/SLSA-Source%20L3-2ea44f)](https://github.com/monumental-archive/.github/blob/main/docs/source-track.md)
[![SLSA Dependencies L2](https://img.shields.io/badge/SLSA-Dependencies%20L2-2ea44f)](https://github.com/monumental-archive/.github/blob/main/docs/dependency-track.md)
[![OpenSSF Best Practices](https://www.bestpractices.dev/projects/14067/badge)](https://www.bestpractices.dev/projects/14067)
[![OpenSSF Baseline](https://www.bestpractices.dev/projects/14067/baseline)](https://www.bestpractices.dev/projects/14067)
[![REUSE status](https://api.reuse.software/badge/github.com/monumental-archive/release-lab)](https://api.reuse.software/info/github.com/monumental-archive/release-lab)
[![coverage](https://codecov.io/gh/monumental-archive/release-lab/branch/main/graph/badge.svg)](https://codecov.io/gh/monumental-archive/release-lab)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21914272.svg)](https://doi.org/10.5281/zenodo.21914272)
[![npm](https://img.shields.io/npm/v/%40monumental-archive%2Flab-wasm.svg)](https://www.npmjs.com/package/@monumental-archive/lab-wasm)
[![ghcr release-lab](https://img.shields.io/badge/ghcr.io-monumental--archive%2Frelease--lab-blue)](https://github.com/orgs/monumental-archive/packages/container/package/release-lab)
[![ghcr lab-pg](https://img.shields.io/badge/ghcr.io-monumental--archive%2Flab--pg-blue)](https://github.com/orgs/monumental-archive/packages/container/package/lab-pg)
[![fair-software](https://img.shields.io/badge/fair--software.eu-%E2%97%8F%20%E2%97%8F%20%E2%97%8F%20%E2%97%8F%20%E2%97%8F-green)](https://fair-software.eu)
<!-- badges:end -->

The org's release lab: where risky release machinery is proven before any
production repository runs it. Fixture crates, **real GitHub APIs, real
credentials, real rulesets, real registries**.

The publishes are real, and that is the point — a rehearsal that ships
nowhere proves nothing. `@monumental-archive/lab-wasm` is on npm with
provenance, the images are on GHCR, the releases are immutable and carry
their full evidence bundles. What is disposable is the *meaning*: the
crates have no consumers and the version numbers are spent freely.

One line the lab never crosses: **crates.io**. Uploads there are
yank-only and a fixture has no business holding a name, so `rust-crate`
is the single class rehearsed dry. DOIs are deliberately NOT grouped
with that line (.github#316): a crates.io name is a scarce global
namespace a fixture would squat; a DOI is a citation record that
squats nothing. Every lab release mints a **real, permanent** version
DOI under the lab's one concept record — that pile-up at rehearsal
cadence is the design, because a rehearsal against a mirrored sandbox
API never proves the path the permanent record takes, and proving that
path is this repository's entire job.

The canon it proves lives in
[monumental-archive/.github](https://github.com/monumental-archive/.github)
— `docs/release.md`. Repositories conform to that canon; this is where the
canon is exercised first.

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

## What is exercised here

The canon's release machinery is complete (`.github#28`, closed): both
archetypes, every artifact class, repro gate, evidence bundles, signed
verdicts, DOIs. All of it ran here first. Four fixture crates carry it —
minimal, but structurally honest enough to make the shared workflows
execute their real code paths and reach their real endpoints:

| Fixture | Class it feeds |
| --- | --- |
| `lab-core` | rust-crate (the library, and the internal path+version dependency shape) |
| `lab-cli` | rust-binary, and the binary that lands in the image |
| `lab-wasm` | wasm-npm |
| `lab-pg` | pgrx-extension, and its per-major extension images |

The caller stubs are the entire surface a conforming repository owns; the
logic they invoke lives in the canon, SHA-pinned:

| Stub | What it proves |
| --- | --- |
| `gate.yml` | the shared CI gate, called across a repository boundary |
| `release.yml` | phase 1 — version decision, changelog, Release PR, and on merge the App-minted `v*` tag and draft release |
| `publish.yml` | phase 2 at full width — `rust-binary`, `oci-image`, `wasm-npm` and `pgrx-extension` built for real across every supported Postgres major, repro-gated, signed through the org signer, pushed to GHCR and npm, with a real version DOI and an evidence bundle |
| `continuous.yml` | the continuous archetype — digest publish on merge, weekly rebuild, no tags, no versions |
| `exercise-sign.yml` | the org signer across a repository boundary: bytes built here, signed there without the signer ever seeing them, verified the way a stranger would |
| `source-attest.yml` | this repository's reserved source-signing identity (below) |
| `audit.yml`, `audit-repro.yml`, `scorecard.yml` | the Monday advisory audit, the Thursday cold rebuild of the latest published release, and the copied Scorecard stub |

Two classes are deliberately not run here for real. **rust-crate** is
rehearsed dry — the lab never uploads to crates.io — and its coexistence
and dry-run shape were proven on v0.15.3. **source-archive** is the
canon's own phase 2, exercised by `.github` on itself.

Both archetypes coexisting in one repository is intentional, not
leftover: `continuous.yml` refuses tags and `publish.yml` refuses
branches, and that pair of inverse guards is only tested where both live.

## What proving here has caught

Each of these was found on a real run, before any production repository
was touched, and none of them was visible to a linter:

| Found | How it presented | Resolution |
| --- | --- | --- |
| Canon checkout used `github.workflow_sha` | `upload-pack: not our ref` — the entry-point workflow's SHA is the *caller's* commit | `github.job_workflow_sha`, and ultimately the `$/.github/actions/canon` self-reference (`.github#165`) |
| The same bug, latent in the shared CI gate | never failed: its only caller lived in the same repository, where both SHAs coincide | fixed together |
| `git-cliff` absent from the toolbelt | `git: 'cliff' is not a git command` | belt standup |
| Tag-mint App lacked `pull_requests: write` | `The permissions requested are not granted to this installation` | App permission + install approval |
| An undecided advisory in a release SBOM | the dependency gate refused to publish v0.19.1 | dependency-keyed VEX; RUSTSEC-2021-0127 decided on v0.20.1 |
| The containerised `cargo build` was not reproducible | the repro gate went red on all seven image digests at v0.21.0, and nothing published | `.github#295` — five of seven fixed by `--provenance=false --sbom=false` + `rewrite-timestamp`, the last two by moving the compile out of the Dockerfile; bit-for-bit on v0.22.1 |

The last row is the shape worth keeping in mind. The gate blocked the
registry uploads, the tags, the append-only Sigstore entries and the
release itself; the entire cost of the finding was a disposable lab
version number.

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

## Source attestation

This repository is one of the org's three source-track emitters
(`.github#207`) and was the first: it proved the emitter end to end before
`signer` and the canon founded their own chains, and the org's Source L3
claim moved only once all three were stranger-verified.

The chain was founded at `ea49b2f0` (2026-08-12) by
`.github/workflows/source-attest.yml`, the reserved signing identity. That
file's path at `@refs/heads/main` **is** the identity — a keyless
certificate names the workflow path plus ref — so moving or renaming it is
a breaking change to the root-of-trust contract, and its contents change
freely while its path never does.

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

The first five links claim `SLSA_SOURCE_LEVEL_2` and stay that way: they
were emitted before the claims job held a token that could read org-level
tag-ruleset details, so the VSA under-claimed rather than assert a control
it could not see. They are not backfilled — honest degradation is a real
behaviour here, not a design intention.

An earlier pilot (2026-08-10) drove `slsa-framework/source-tool` and
parked on four upstream defects (watch `.github#199`); the org built its
own emitter instead of waiting. Those genesis attestations remain in this
repository's notes as the historical record — a different dialect, not a
link in the current chain.

Unlike releases, the notes chain is **not** disposable: each link verifies
its predecessor, so deleting notes breaks verification for everything after.

## Housekeeping

Immutable releases are ON (the draft-then-publish shape depends on it). Old
lab releases and tags are disposable; delete them freely between runs —
this repository has no consumers. One exception: the **latest** release is
load-bearing, because the Thursday `audit-repro` job rebuilds it and
compares against its published `checksums.txt`. Delete that one and the
audit reddens until the next release is cut.
