# release-lab

The org's release lab: where risky release machinery is proven before any
production repository runs it. Dummy crates, **real GitHub APIs, real
credentials, real rulesets**, no registry publishes.

It began as a test bed for one project's pipeline, and was renamed when it
became org-generic. The canon it proves lives in
[monumental-archive/.github](https://github.com/monumental-archive/.github)
— `docs/release.md`. Repositories conform to that canon; this lab is where
the canon is exercised first.

It exists because the release half of a pipeline — tag creation, draft
assembly, asset upload, immutability, publishing, recovery — is covered by
nothing except live releases, and live releases are the most expensive
possible place to find defects.

## Phase 1 canon: proven here

`release.yml` is the caller stub for the shared phase-1 workflow
(`monumental-archive/.github/.github/workflows/release.yml`, SHA-pinned).
This repository contains no release logic of its own for phase 1 — it is
the first conforming consumer.

Proving it live caught three defects that no local linter could have found,
before any production repository was touched:

| Defect | How it presented | Fix |
| --- | --- | --- |
| Canon checkout used `github.workflow_sha` | `upload-pack: not our ref` — the entry-point workflow's SHA is the *caller's* commit | `github.job_workflow_sha` |
| Same bug latent in the shared CI gate | never failed: its only caller lives in the same repo, where both SHAs coincide | fixed together |
| `git-cliff` absent from the toolbelt | `git: 'cliff' is not a git command` | belt standup |
| Tag-mint App lacked `pull_requests: write` | `The permissions requested are not granted to this installation` | App permission + install approval |

The lesson worth keeping: **a shared workflow whose only exerciser lives in
its own repository is untested for the cross-repository case.** That class
of defect is what this lab exists to catch.

## The `v*` tag-creation lock

Canon: humans never push release tags; only the pipeline's App mints them.
The org ruleset restricts `v*` **creation** with the tag-mint App as sole
bypass actor.

Both halves are proven here, under `enforcement: active` — note that
`evaluate` mode proves *neither*, since it enforces nothing and bypass
actors record no evaluation:

| Half | Repro | Expected |
| --- | --- | --- |
| Negative | `git tag -a v9.9.9-x -m x && git push origin v9.9.9-x` as a human | `GH013 ... Cannot create ref due to creations being restricted.` |
| Positive | merge a release PR; the tag job mints the tag via the App | annotated tag + draft release appear |

`current_user_can_bypass: never` on the ruleset is the check that the org
owner is bound by it too.

## Legacy scenarios (pending phase-2 canon)

`release-lab.yml` (workflow_dispatch) still drives the *legacy* publish
pipeline — one project's scripts with the crate lists swapped. Phase-2
canon (publish, prove, sign) is not yet designed, so these scenarios prove
the old shape, not the org's. They stay until phase-2 canon replaces them,
and their guards are the input to designing it.

It also drives
[monumental-archive/trusted-builder](https://github.com/monumental-archive/trusted-builder),
pinned by commit SHA: `attest`/`verify` (the signing boundary) and
`attach`/`publish`. That caller-to-builder contract spans two
repositories, so no local linter can check it — the first attempt died as
`startup_failure` with no jobs, no annotations and no log, over one
permission scope.

| Scenario | Dispatch | Proves |
| --- | --- | --- |
| Golden path | `phase1`, then `phase2` | tags + drafts cut; assets attach; releases publish immutable |
| Resume after death mid-assembly | `phase2` with `kill_after: build`, then plain `phase2` | re-dispatch converges; rebuilt bytes overwrite draft assets; SHA256SUMS stays consistent |
| Resume after death pre-publish | `phase2` with `kill_after: attach`, then plain `phase2` | attach is idempotent while draft; publish picks up where it died |
| Immutability regression | disable immutable releases, run `phase2` | the shared publish-releases workflow stops after ONE mutable release, names the fix |
| Stranded version recovery | bump the workspace version, dispatch `phase1` | tag guards (existing tags, wrong-commit tags, duplicate drafts) |

## Registry stance

Nothing is published to crates.io or npm from this repository, ever. The
legacy scripts' registry probes are deleted in the lab copies (marked
`LAB DIVERGENCE`); "already released" is decided by the tag namespace.

## Housekeeping

Immutable releases are ON (the draft-then-publish shape depends on it). Old
lab releases and tags are disposable; delete them freely between scenario
runs — this repository has no consumers.
