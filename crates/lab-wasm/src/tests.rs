// See lab-core/src/tests.rs: `check-private-items = true` makes
// `missing_panics_doc` reach a `#[test]` fn, which asserts by design and
// has no caller to document a panic for.
#[expect(
    clippy::missing_panics_doc,
    reason = "a test panics by design; there is no caller to warn"
)]
#[test]
fn answers() {
    assert_eq!(super::answer(), 42);
}
