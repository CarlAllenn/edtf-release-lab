//! Dummy crate: exists so the release pipeline has a workspace to version.
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
