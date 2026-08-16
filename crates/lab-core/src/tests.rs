use super::{PHASE2_REHEARSAL, banner, parse_version_marker};

// `missing_panics_doc` reaches private items because the canon sets
// `check-private-items = true`, which is right for private helpers and
// wrong for a `#[test]` fn: asserting IS the contract, and a test has no
// caller to document a panic for. Narrow, written, and self-retiring —
// if clippy ever exempts test functions this expect fails and goes.
#[expect(
    clippy::missing_panics_doc,
    reason = "a test panics by design; there is no caller to warn"
)]
#[test]
fn banner_renders() {
    assert_eq!(
        banner("1.2.3", "aarch64"),
        "lab-cli 1.2.3 on aarch64 (answer: 42)"
    );
}

#[expect(
    clippy::missing_panics_doc,
    reason = "a test panics by design; there is no caller to warn"
)]
#[test]
fn markers_parse() {
    assert_eq!(parse_version_marker(PHASE2_REHEARSAL), Some((0, 4, 0)));
    assert_eq!(parse_version_marker("v1.20.0"), Some((1, 20, 0)));
    assert_eq!(parse_version_marker("1.2.3"), None);
    assert_eq!(parse_version_marker("v1.2"), None);
    assert_eq!(parse_version_marker("v1.2.3.4"), None);
}
