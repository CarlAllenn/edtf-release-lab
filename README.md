# edtf-release-lab

Throwaway test bed for the [edtf](https://github.com/CarlAllenn/edtf)
release pipeline. Dummy crates, **real GitHub APIs**, no registry
publishes. Exists because the production runbook's meta-lesson is that the
release half of the pipeline — tag creation, draft assembly, asset upload,
immutability, publishing, recovery — is covered by nothing except live
releases, and live releases are the most expensive possible place to find
defects.

## What runs here

`release-lab.yml` (workflow_dispatch) drives the same scripts the
production pipeline uses, with the crate lists edited to this repo's two
dummy crates — the same edit every adopter of the pipeline makes, so the
lab doubles as a rehearsal of the shared-config port.

| Scenario | Dispatch | Proves |
| --- | --- | --- |
| Golden path | `phase1`, then `phase2` | tags + drafts cut; assets attach; releases publish immutable |
| Resume after death mid-assembly | `phase2` with `kill_after: build`, then plain `phase2` | re-dispatch converges; rebuilt bytes overwrite draft assets; SHA256SUMS stays consistent |
| Resume after death pre-publish | `phase2` with `kill_after: attach`, then plain `phase2` | attach is idempotent while draft; publish picks up where it died |
| Immutability regression | disable immutable releases, run `phase2` | publish-releases.sh stops after ONE mutable release, names the fix |
| Stranded version recovery | bump the workspace version, dispatch `phase1` | tag-release.sh's guards (existing tags, wrong-commit tags, duplicate drafts) |

Each new pipeline defect found in production gets a scenario here first;
each structural change to the production pipeline (resumable tail,
idempotent attestation, the reusable-workflow builder) lands here before it
lands there.

## Registry stance

Nothing is published to crates.io or npm from this repository, ever. The
production scripts' registry probes are deleted in the lab copies (marked
`LAB DIVERGENCE`); "already released" is decided by the tag namespace.

## Housekeeping

Immutable releases are ON (the pipeline's draft-then-publish shape depends
on it). Old lab releases and tags are disposable; delete them freely
between scenario runs — this repository has no consumers.
