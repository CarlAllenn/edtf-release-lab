# Changelog

All notable changes to this project are recorded here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
over the lab crates' public APIs (this is a test bed; the promise is nominal).

## [0.22.0](https://github.com/monumental-archive/release-lab/compare/v0.21.1...v0.22.0) - 2026-08-13

### Added

- move the lab-cli compile out of the dockerfile (#295) ([#144](https://github.com/monumental-archive/release-lab/pull/144))

### Fixed

- pin exercise-sign's runner images to ubuntu-24.04 ([#142](https://github.com/monumental-archive/release-lab/pull/142))

### Miscellaneous

- update dependency monumental-archive/.github to v1.15.1 ([#143](https://github.com/monumental-archive/release-lab/pull/143))
- update monumental-archive/signer digest to 1a28b69 ([#146](https://github.com/monumental-archive/release-lab/pull/146))
- update dependency monumental-archive/.github to v1.16.0 ([#147](https://github.com/monumental-archive/release-lab/pull/147))
- update dependency monumental-archive/.github to v1.16.1 ([#148](https://github.com/monumental-archive/release-lab/pull/148))

## [0.21.1](https://github.com/monumental-archive/release-lab/compare/v0.21.0...v0.21.1) - 2026-08-12

### Miscellaneous

- bump every canon pin to v1.15.1 ([#137](https://github.com/monumental-archive/release-lab/pull/137))
- update monumental-archive/signer digest to e1be035 ([#138](https://github.com/monumental-archive/release-lab/pull/138))

## [0.21.0](https://github.com/monumental-archive/release-lab/compare/v0.20.1...v0.21.0) - 2026-08-12

### Added

- land the repo's licence (0BSD) ([#131](https://github.com/monumental-archive/release-lab/pull/131))
- stand up the badge surface — scorecard publishing and shields ([#133](https://github.com/monumental-archive/release-lab/pull/133))

### Miscellaneous

- update monumental-archive/signer digest to 5ca3bba ([#134](https://github.com/monumental-archive/release-lab/pull/134))
- update dependency monumental-archive/.github to v1.14.0 ([#135](https://github.com/monumental-archive/release-lab/pull/135))
- bump every canon pin to v1.15.0 ([#136](https://github.com/monumental-archive/release-lab/pull/136))

## [0.20.1](https://github.com/monumental-archive/release-lab/compare/v0.20.0...v0.20.1) - 2026-08-12

### Fixed

- record the RUSTSEC-2021-0127 decision in deny.toml ([#129](https://github.com/monumental-archive/release-lab/pull/129))

## [0.20.0](https://github.com/monumental-archive/release-lab/compare/v0.19.0...v0.20.0) - 2026-08-12

### Added

- exercise the v1.13.0 verdict machinery at full width ([#126](https://github.com/monumental-archive/release-lab/pull/126))

### Miscellaneous

- update monumental-archive/.github to v1.13.0 ([#125](https://github.com/monumental-archive/release-lab/pull/125))
- update dependency monumental-archive/.github to v1.13.0 ([#127](https://github.com/monumental-archive/release-lab/pull/127))

## [0.19.0](https://github.com/monumental-archive/release-lab/compare/v0.18.3...v0.19.0) - 2026-08-12

### Added

- reserve the source-signing identity with the inert stub ([#109](https://github.com/monumental-archive/release-lab/pull/109))
- activate the source-track emitter (canon v1.9.0) ([#111](https://github.com/monumental-archive/release-lab/pull/111))
- take the two-stage source emitter, measuring the ambient token ([#119](https://github.com/monumental-archive/release-lab/pull/119))
- give the claims job its scoped read token ([#121](https://github.com/monumental-archive/release-lab/pull/121))

### Dependencies

- update monumental-archive/signer digest to b05fe88 ([#112](https://github.com/monumental-archive/release-lab/pull/112))
- update dependency monumental-archive/.github to v1.8.0 ([#113](https://github.com/monumental-archive/release-lab/pull/113))
- update dependency monumental-archive/.github to v1.9.0 ([#114](https://github.com/monumental-archive/release-lab/pull/114))
- update dependency monumental-archive/.github to v1.10.0 ([#115](https://github.com/monumental-archive/release-lab/pull/115))
- update dependency monumental-archive/.github to v1.10.1 ([#117](https://github.com/monumental-archive/release-lab/pull/117))

### Documentation

- record the founded source chain and how to verify it ([#118](https://github.com/monumental-archive/release-lab/pull/118))

### Miscellaneous

- update monumental-archive/.github to v1.11.0 ([#116](https://github.com/monumental-archive/release-lab/pull/116))
- update dependency monumental-archive/.github to v1.11.0 ([#120](https://github.com/monumental-archive/release-lab/pull/120))
- update dependency monumental-archive/.github to v1.11.1 ([#122](https://github.com/monumental-archive/release-lab/pull/122))
- update monumental-archive/signer digest to 9adecf6 ([#124](https://github.com/monumental-archive/release-lab/pull/124))
- update dependency monumental-archive/.github to v1.12.0 ([#123](https://github.com/monumental-archive/release-lab/pull/123))

## [0.18.3](https://github.com/monumental-archive/release-lab/compare/v0.18.2...v0.18.3) - 2026-08-11

### Fixed

- bump canon to v1.7.1 — pinned installer on the build legs ([#107](https://github.com/monumental-archive/release-lab/pull/107))

## [0.18.2](https://github.com/monumental-archive/release-lab/compare/v0.18.1...v0.18.2) - 2026-08-11

### Dependencies

- update dependency monumental-archive/.github to v1.6.0 ([#101](https://github.com/monumental-archive/release-lab/pull/101))
- bump canon to v1.7.0 and pin the builder stage digest ([#105](https://github.com/monumental-archive/release-lab/pull/105))

## [0.18.1](https://github.com/monumental-archive/release-lab/compare/v0.18.0...v0.18.1) - 2026-08-11

### Fixed

- bump canon pins to v1.5.3 ([#102](https://github.com/monumental-archive/release-lab/pull/102))

## [0.18.0](https://github.com/monumental-archive/release-lab/compare/v0.17.0...v0.18.0) - 2026-08-11

### Added

- adopt the dependency track ([#99](https://github.com/monumental-archive/release-lab/pull/99))

### Dependencies

- update dependency monumental-archive/.github to v1.4.1 ([#97](https://github.com/monumental-archive/release-lab/pull/97))

### Fixed

- bump canon pins to v1.5.2 ([#100](https://github.com/monumental-archive/release-lab/pull/100))

## [0.17.0](https://github.com/monumental-archive/release-lab/compare/v0.16.3...v0.17.0) - 2026-08-11

### Added

- add the oci metadata rehearsal marker ([#95](https://github.com/monumental-archive/release-lab/pull/95))

### Dependencies

- update dependency monumental-archive/.github to v1.3.2 ([#94](https://github.com/monumental-archive/release-lab/pull/94))

## [0.16.3](https://github.com/monumental-archive/release-lab/compare/v0.16.2...v0.16.3) - 2026-08-11

### Dependencies

- update dependency monumental-archive/.github to v1.2.1 ([#87](https://github.com/monumental-archive/release-lab/pull/87))
- update dependency monumental-archive/.github to v1.2.2 ([#88](https://github.com/monumental-archive/release-lab/pull/88))
- update monumental-archive/signer digest to e50552b ([#91](https://github.com/monumental-archive/release-lab/pull/91))
- update dependency monumental-archive/.github to v1.3.0 ([#92](https://github.com/monumental-archive/release-lab/pull/92))

### Miscellaneous

- seed every canon reference at v1.0.0 ([#85](https://github.com/monumental-archive/release-lab/pull/85))
- adopt canon v1.3.0 ([#89](https://github.com/monumental-archive/release-lab/pull/89))
- adopt canon v1.3.1 ([#90](https://github.com/monumental-archive/release-lab/pull/90))

## [0.16.2](https://github.com/monumental-archive/release-lab/compare/v0.16.1...v0.16.2) - 2026-08-10

### Miscellaneous

- bump the canon pins to current main ([#82](https://github.com/monumental-archive/release-lab/pull/82))

## [0.16.1](https://github.com/monumental-archive/release-lab/compare/v0.16.0...v0.16.1) - 2026-08-10

### Fixed

- add the 0.15.4 to 0.16.1 upgrade path ([#80](https://github.com/monumental-archive/release-lab/pull/80))

## [0.16.0](https://github.com/monumental-archive/release-lab/compare/v0.15.4...v0.16.0) - 2026-08-10

### Added

- attest source on every push to main ([#74](https://github.com/monumental-archive/release-lab/pull/74))

### Documentation

- record the source-track pilot in the lab charter ([#78](https://github.com/monumental-archive/release-lab/pull/78))

### Fixed

- apply both source-tool patches, downgrade softly at genesis ([#77](https://github.com/monumental-archive/release-lab/pull/77))

### Miscellaneous

- park the source-track pilot ([#79](https://github.com/monumental-archive/release-lab/pull/79))

## [0.15.4](https://github.com/monumental-archive/release-lab/compare/v0.15.3...v0.15.4) - 2026-08-10

### Fixed

- run the width proof for real across every supported major ([#72](https://github.com/monumental-archive/release-lab/pull/72))

## [0.15.3](https://github.com/monumental-archive/release-lab/compare/v0.15.2...v0.15.3) - 2026-08-10

### CI

- pass the workspace exclusion to the binary repro leg ([#69](https://github.com/monumental-archive/release-lab/pull/69))

### Fixed

- rehearse every class across every supported postgres major ([#71](https://github.com/monumental-archive/release-lab/pull/71))

## [0.15.2](https://github.com/monumental-archive/release-lab/compare/v0.15.1...v0.15.2) - 2026-08-10

### Fixed

- roll the canon pins past the tag-job token fix ([#66](https://github.com/monumental-archive/release-lab/pull/66))
- roll the canon pins past the rename-deletion fix ([#67](https://github.com/monumental-archive/release-lab/pull/67))

## [0.15.1](https://github.com/monumental-archive/release-lab/compare/v0.15.0...v0.15.1) - 2026-08-10

### Fixed

- name the upgrade path after the release that ships it ([#64](https://github.com/monumental-archive/release-lab/pull/64))

## [0.15.0](https://github.com/monumental-archive/release-lab/compare/v0.14.2...v0.15.0) - 2026-08-10

### Added

- let the extension name its version, and prove the upgrade to it ([#62](https://github.com/monumental-archive/release-lab/pull/62))

## [0.14.2](https://github.com/monumental-archive/release-lab/compare/v0.14.1...v0.14.2) - 2026-08-10

### Fixed

- carry the repository field the provenance validates ([#60](https://github.com/monumental-archive/release-lab/pull/60))

## [0.14.1](https://github.com/monumental-archive/release-lab/compare/v0.14.0...v0.14.1) - 2026-08-10

### Fixed

- pin past the npm path fix and the upgrade executor ([#58](https://github.com/monumental-archive/release-lab/pull/58))

## [0.14.0](https://github.com/monumental-archive/release-lab/compare/v0.13.3...v0.14.0) - 2026-08-10

### Added

- run the full canon — three classes, npm, images, doi ([#56](https://github.com/monumental-archive/release-lab/pull/56))

## [0.13.3](https://github.com/monumental-archive/release-lab/compare/v0.13.2...v0.13.3) - 2026-08-10

### Fixed

- pin past the unprivileged pgrx build ([#54](https://github.com/monumental-archive/release-lab/pull/54))

## [0.13.2](https://github.com/monumental-archive/release-lab/compare/v0.13.1...v0.13.2) - 2026-08-10

### Fixed

- pin past the first-publish upgrade-path guard fix ([#52](https://github.com/monumental-archive/release-lab/pull/52))

## [0.13.1](https://github.com/monumental-archive/release-lab/compare/v0.13.0...v0.13.1) - 2026-08-10

### Fixed

- actually pin cargo-pgrx ([#50](https://github.com/monumental-archive/release-lab/pull/50))

## [0.13.0](https://github.com/monumental-archive/release-lab/compare/v0.12.1...v0.13.0) - 2026-08-10

### Added

- prove the continuous archetype ([#46](https://github.com/monumental-archive/release-lab/pull/46))
- audit that releases rebuild to their published bytes ([#47](https://github.com/monumental-archive/release-lab/pull/47))
- add the pgrx extension fixture ([#49](https://github.com/monumental-archive/release-lab/pull/49))

### Dependencies

- update node.js to v24.19.0 ([#43](https://github.com/monumental-archive/release-lab/pull/43))

### Fixed

- drop the deprecated app-id input and advance the release pin ([#45](https://github.com/monumental-archive/release-lab/pull/45))

### Miscellaneous

- carry the licences the manifest already claims ([#48](https://github.com/monumental-archive/release-lab/pull/48))

## [0.12.1](https://github.com/monumental-archive/release-lab/compare/v0.12.0...v0.12.1) - 2026-08-09

### Fixed

- pin the attach layout fix ([#41](https://github.com/monumental-archive/release-lab/pull/41))

## [0.12.0](https://github.com/monumental-archive/release-lab/compare/v0.11.1...v0.12.0) - 2026-08-09

### Added

- teach lab-cli to say which architecture answered ([#39](https://github.com/monumental-archive/release-lab/pull/39))

## [0.11.1](https://github.com/monumental-archive/release-lab/compare/v0.11.0...v0.11.1) - 2026-08-09

### Fixed

- point the wasm class at the crate, not the workspace ([#37](https://github.com/monumental-archive/release-lab/pull/37))

## [0.11.0](https://github.com/monumental-archive/release-lab/compare/v0.10.2...v0.11.0) - 2026-08-09

### Added

- rehearse the rust-binary and wasm-npm classes ([#35](https://github.com/monumental-archive/release-lab/pull/35))

## [0.10.2](https://github.com/monumental-archive/release-lab/compare/v0.10.1...v0.10.2) - 2026-08-09

### Fixed

- pick up the toolbelt install in the manifest job ([#33](https://github.com/monumental-archive/release-lab/pull/33))

## [0.10.1](https://github.com/monumental-archive/release-lab/compare/v0.10.0...v0.10.1) - 2026-08-09

### Fixed

- pick up the container-driver builder fix ([#31](https://github.com/monumental-archive/release-lab/pull/31))

## [0.10.0](https://github.com/monumental-archive/release-lab/compare/v0.9.1...v0.10.0) - 2026-08-09

### Added

- prove the image class against a real registry ([#29](https://github.com/monumental-archive/release-lab/pull/29))

## [0.9.1](https://github.com/monumental-archive/release-lab/compare/v0.9.0...v0.9.1) - 2026-08-09

### Fixed

- grant packages write for the oci-image class ([#27](https://github.com/monumental-archive/release-lab/pull/27))

## [0.9.0](https://github.com/monumental-archive/release-lab/compare/v0.8.0...v0.9.0) - 2026-08-09

### Added

- add a class-representative image fixture ([#23](https://github.com/monumental-archive/release-lab/pull/23))

### CI

- remove the weekly exercise until it is worth having ([#20](https://github.com/monumental-archive/release-lab/pull/20))

### Dependencies

- pin debian docker tag to 3a39a05 ([#24](https://github.com/monumental-archive/release-lab/pull/24))

### Fixed

- pick up the git-cliff auth fix and repair the changelog links ([#25](https://github.com/monumental-archive/release-lab/pull/25))
- grant contents: read to the shared release workflow ([#26](https://github.com/monumental-archive/release-lab/pull/26))

## [0.8.0](https://github.com/monumental-archive/release-lab/compare/v0.7.0...v0.8.0) - 2026-08-09

### Added

- verify the rotated app key end to end ([#19](https://github.com/monumental-archive/release-lab/pull/19))

### CI

- pin the orchestrator to main now that it is merged
- prove the release machinery weekly, not once ([#18](https://github.com/monumental-archive/release-lab/pull/18))

## [0.7.0](https://github.com/monumental-archive/release-lab/compare/v0.6.0...v0.7.0) - 2026-08-09

### Added

- bump the orchestrator pin for the fourth rehearsal

## [0.6.0](https://github.com/monumental-archive/release-lab/compare/v0.5.0...v0.6.0) - 2026-08-09

### Added

- adopt the plural classes input and retry the rehearsal

## [0.5.0](https://github.com/monumental-archive/release-lab/compare/v0.4.0...v0.5.0) - 2026-08-09

### Added

- bump the orchestrator pin and drive a second rehearsal

## [0.4.0](https://github.com/monumental-archive/release-lab/compare/v0.3.0...v0.4.0) - 2026-08-09

### Added

- call the shared publish orchestrator as a rehearsal ([#12](https://github.com/monumental-archive/release-lab/pull/12))
- add a marker constant to drive a minor bump

### CI

- exercise the signer across the repository boundary ([#10](https://github.com/monumental-archive/release-lab/pull/10))
- bump the shared release pin to pick up the sign-off fix

### Dependencies

- update dependency rust to v1.97.1 ([#8](https://github.com/monumental-archive/release-lab/pull/8))

### Miscellaneous

- adopt the org scaffold and conform the workflows ([#7](https://github.com/monumental-archive/release-lab/pull/7))
- sync the commit config with org canon ([#11](https://github.com/monumental-archive/release-lab/pull/11))

## [0.3.0](https://github.com/monumental-archive/release-lab/compare/v0.2.0...v0.3.0) - 2026-08-09

### Added

- reposition as the org release lab; record the tag-lock scenario

## [0.2.0](https://github.com/monumental-archive/release-lab/compare/v0.1.2...v0.2.0) - 2026-08-09

### Added

- conform to the org release canon

### Fixed

- pin lab actions to SHAs; ride the job_workflow_sha canon fix
- ride the git-cliff belt standup

## [0.1.2](https://github.com/monumental-archive/release-lab/compare/lab-core-v0.1.2...v0.1.2) - 2026-08-09

### Added

- an oci scenario, so the image signer has a subject

## [lab-core-v0.1.2](https://github.com/monumental-archive/release-lab/compare/lab-core-v0.1.1...lab-core-v0.1.2) - 2026-08-09

### Added

- agent leak test — bulk egress with RSS sampling
- sign through the trusted builder, verify before publishing ([#1](https://github.com/monumental-archive/release-lab/pull/1))
- drive the shared release half, and bump to 0.1.2 ([#2](https://github.com/monumental-archive/release-lab/pull/2))

### Fixed

- invoke the probe via bash (API-created files are 644)

### Testing

- A/B the mise version under block egress
- scoped rust pin driving mise's rustup backend
- bounded probe of the confirmed stall point
- four legs isolating CARGO_HOME repoint vs rustup env
- is egress enforcement a precondition for the stall?

## [lab-core-v0.1.1](https://github.com/monumental-archive/release-lab/compare/lab-core-v0.1.0...lab-core-v0.1.1) - 2026-08-08

### Added

- canary-hang repro — hardened vs control probe jobs
- OOM repro — publish-job preamble with memory sampling
- oom-repro runs edtf's real packaging/wasm/sbom steps with sampling
- split phase2 into assemble + finish with attested-state hand-off

### Fixed

- oom-repro heavy steps need VERSION set

### Miscellaneous

- bump to 0.1.1 for the tail-split rehearsal

## [lab-core-v0.1.0](https://github.com/monumental-archive/release-lab/releases/tag/lab-core-v0.1.0) - 2026-08-08

### Added

- release-half test bed — stub artifacts, real GitHub APIs
