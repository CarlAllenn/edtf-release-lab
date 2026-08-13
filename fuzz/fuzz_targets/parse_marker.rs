//! Round-trip invariant: any input parse_version_marker accepts must
//! re-render to a string it accepts again with the same value — and no
//! input may panic it.
#![no_main]
use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    if let Ok(s) = std::str::from_utf8(data) {
        if let Some((maj, min, pat)) = lab_core::parse_version_marker(s) {
            let rendered = format!("v{maj}.{min}.{pat}");
            assert_eq!(
                lab_core::parse_version_marker(&rendered),
                Some((maj, min, pat))
            );
        }
    }
});
