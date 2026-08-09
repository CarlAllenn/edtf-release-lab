//! Dummy crate: exists so the release pipeline has a workspace to version.
pub fn answer() -> u32 {
    42
}

/// Phase-2 rehearsal marker: gives git-cliff a feature to bump on.
pub const PHASE2_REHEARSAL: &str = "v0.4.0";
