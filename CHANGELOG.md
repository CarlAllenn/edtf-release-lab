# Changelog

All notable changes to this project are recorded here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
over the lab crates' public APIs (this is a test bed; the promise is nominal).

## [0.7.1](https://github.com/monumental-archive/edtf-release-lab/compare/v0.7.0...v0.7.1) - 2026-08-09

### CI

- pin the orchestrator to main now that it is merged
- prove the release machinery weekly, not once ([#18](https://github.com/monumental-archive/edtf-release-lab/pull/18))

## [0.7.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.6.0...v0.7.0) - 2026-08-09

### Added

- bump the orchestrator pin for the fourth rehearsal

## [0.6.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.5.0...v0.6.0) - 2026-08-09

### Added

- adopt the plural classes input and retry the rehearsal

## [0.5.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.4.0...v0.5.0) - 2026-08-09

### Added

- bump the orchestrator pin and drive a second rehearsal

## [0.4.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.3.0...v0.4.0) - 2026-08-09

### Added

- call the shared publish orchestrator as a rehearsal ([#12](https://github.com/monumental-archive/edtf-release-lab/pull/12))
- add a marker constant to drive a minor bump

### CI

- exercise the signer across the repository boundary ([#10](https://github.com/monumental-archive/edtf-release-lab/pull/10))
- bump the shared release pin to pick up the sign-off fix

### Dependencies

- update dependency rust to v1.97.1 ([#8](https://github.com/monumental-archive/edtf-release-lab/pull/8))

### Miscellaneous

- adopt the org scaffold and conform the workflows ([#7](https://github.com/monumental-archive/edtf-release-lab/pull/7))
- sync the commit config with org canon ([#11](https://github.com/monumental-archive/edtf-release-lab/pull/11))

## [0.3.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.2.0...v0.3.0) - 2026-08-09

### Added

- reposition as the org release lab; record the tag-lock scenario

## [0.2.0](https://github.com/monumental-archive/edtf-release-lab/compare/v0.1.2...v0.2.0) - 2026-08-09

### Added

- conform to the org release canon

### Fixed

- pin lab actions to SHAs; ride the job_workflow_sha canon fix
- ride the git-cliff belt standup

## [0.1.2](https://github.com/monumental-archive/edtf-release-lab/compare/lab-core-v0.1.2...v0.1.2) - 2026-08-09

### Added

- an oci scenario, so the image signer has a subject

## [lab-core-v0.1.2](https://github.com/monumental-archive/edtf-release-lab/compare/lab-core-v0.1.1...lab-core-v0.1.2) - 2026-08-09

### Added

- agent leak test — bulk egress with RSS sampling
- sign through the trusted builder, verify before publishing ([#1](https://github.com/monumental-archive/edtf-release-lab/pull/1))
- drive the shared release half, and bump to 0.1.2 ([#2](https://github.com/monumental-archive/edtf-release-lab/pull/2))

### Fixed

- invoke the probe via bash (API-created files are 644)

### Testing

- A/B the mise version under block egress
- scoped rust pin driving mise's rustup backend
- bounded probe of the confirmed stall point
- four legs isolating CARGO_HOME repoint vs rustup env
- is egress enforcement a precondition for the stall?

## [lab-core-v0.1.1](https://github.com/monumental-archive/edtf-release-lab/compare/lab-core-v0.1.0...lab-core-v0.1.1) - 2026-08-08

### Added

- canary-hang repro — hardened vs control probe jobs
- OOM repro — publish-job preamble with memory sampling
- oom-repro runs edtf's real packaging/wasm/sbom steps with sampling
- split phase2 into assemble + finish with attested-state hand-off

### Fixed

- oom-repro heavy steps need VERSION set

### Miscellaneous

- bump to 0.1.1 for the tail-split rehearsal

## [lab-core-v0.1.0](https://github.com/monumental-archive/edtf-release-lab/releases/tag/lab-core-v0.1.0) - 2026-08-08

### Added

- release-half test bed — stub artifacts, real GitHub APIs
