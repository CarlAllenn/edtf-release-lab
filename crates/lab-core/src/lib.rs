//! Fixture crate: the workspace the org release pipeline versions,
//! builds and publishes. No consumers; the classes are what matter.
pub fn answer() -> u32 {
    42
}

/// Phase-2 rehearsal marker: gives git-cliff a feature to bump on.
pub const PHASE2_REHEARSAL: &str = "v0.4.0";

/// Second rehearsal marker.
pub const PHASE2_REHEARSAL_2: &str = "v0.5.0";

/// Third rehearsal marker.
pub const PHASE2_REHEARSAL_3: &str = "v0.6.0";

/// Fourth rehearsal marker.
pub const PHASE2_REHEARSAL_4: &str = "v0.7.0";

/// Key-rotation verification marker.
pub const KEY_ROTATION_CHECK: &str = "v0.8.0";

/// OCI image metadata marker: the release that first carries a resolved
/// facts map on every published index (.github#108).
pub const OCI_METADATA_CHECK: &str = "v0.17.0";

/// Fuzz surface (.github#316): parse a rehearsal marker of the form
/// `vMAJOR.MINOR.PATCH`. Returns None for anything else. The fuzz
/// target proves the parse/format round-trip panics on no input.
pub fn parse_version_marker(s: &str) -> Option<(u32, u32, u32)> {
    let rest = s.strip_prefix('v')?;
    let mut parts = rest.split('.');
    let major = parts.next()?.parse().ok()?;
    let minor = parts.next()?.parse().ok()?;
    let patch = parts.next()?.parse().ok()?;
    if parts.next().is_some() {
        return None;
    }
    Some((major, minor, patch))
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn markers_parse() {
        assert_eq!(parse_version_marker(PHASE2_REHEARSAL), Some((0, 4, 0)));
        assert_eq!(parse_version_marker("v1.20.0"), Some((1, 20, 0)));
        assert_eq!(parse_version_marker("1.2.3"), None);
        assert_eq!(parse_version_marker("v1.2"), None);
        assert_eq!(parse_version_marker("v1.2.3.4"), None);
    }
}
