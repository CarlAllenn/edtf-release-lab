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
