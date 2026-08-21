//! Fixture crate: the workspace the org release pipeline versions,
//! builds and publishes. No consumers; the classes are what matter.

// `clippy::inline_modules` (restriction, canon #445): a module lives in
// its own file. `mod_module_files` picks the self-named layout over
// `mod.rs`, so the tests are `tests.rs` beside this file.
#[cfg(test)]
mod tests;

/// Key-rotation verification marker.
pub const KEY_ROTATION_CHECK: &str = "v0.8.0";

/// OCI image metadata marker: the release that first carries a resolved
/// facts map on every published index (.github#108).
pub const OCI_METADATA_CHECK: &str = "v0.17.0";

/// Phase-2 rehearsal marker: gives git-cliff a feature to bump on.
pub const PHASE2_REHEARSAL: &str = "v0.4.0";

/// Second rehearsal marker.
pub const PHASE2_REHEARSAL_2: &str = "v0.5.0";

/// Third rehearsal marker.
pub const PHASE2_REHEARSAL_3: &str = "v0.6.0";

/// Fourth rehearsal marker.
pub const PHASE2_REHEARSAL_4: &str = "v0.7.0";

/// Target-scope marker.
///
/// The release that first types every build subject with the target that
/// produced it, so a rebuild is judged against the targets its caller
/// declared rather than against the whole class (.github#637).
pub const TARGET_SCOPE_CHECK: &str = "v0.27.0";

/// The fixture's one value, returned so the build classes have something
/// to link and the tests something to assert.
// Called once inside this crate, by `banner`; the other callers are
// lab-cli, lab-wasm and the JS across the wasm boundary, none of which
// single_call_fn can see from here.
#[expect(
    clippy::single_call_fn,
    reason = "the other callers are other crates, and JS beyond the wasm boundary"
)]
#[inline]
#[must_use]
pub const fn answer() -> u32 {
    42
}

/// The line lab-cli prints.
///
/// Built here rather than in `main` so it is covered: `coverage:check`
/// counts the whole workspace, and logic in a binary no test enters is
/// logic nothing measures.
// The opposite cfg to `answer` above, for the same reason: outside a
// test build this crate never calls `banner` (lab-cli does), so the lint
// is silent; under cfg(test) the one test calls it exactly once and it
// fires. An `#[expect]` must hold in every configuration compiled, so
// each of these two functions is conditioned on the build the lint
// actually fires in.
#[cfg_attr(
    test,
    expect(
        clippy::single_call_fn,
        reason = "the real caller is lab-cli; under cfg(test) only the test calls it"
    )
)]
#[inline]
#[must_use]
pub fn banner(version: &str, arch: &str) -> String {
    let answer = answer();
    format!("lab-cli {version} on {arch} (answer: {answer})")
}

/// Fuzz surface (.github#316): parse a rehearsal marker of the form
/// `vMAJOR.MINOR.PATCH`. Returns `None` for anything else. The fuzz
/// target proves the parse/format round-trip panics on no input.
#[inline]
#[must_use]
pub fn parse_version_marker(marker: &str) -> Option<(u32, u32, u32)> {
    let rest = marker.strip_prefix('v')?;
    let mut parts = rest.split('.');
    let major = parts.next()?.parse().ok()?;
    let minor = parts.next()?.parse().ok()?;
    let patch = parts.next()?.parse().ok()?;
    if parts.next().is_some() {
        return None;
    }
    Some((major, minor, patch))
}
