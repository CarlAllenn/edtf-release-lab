use wasm_bindgen::prelude::wasm_bindgen;

// `clippy::inline_modules` (restriction, canon #445): a module lives in
// its own file, self-named rather than `mod.rs`.
#[cfg(test)]
mod tests;

/// The one thing the package exists to do, callable from JS.
// `single_call_fn` counts callers clippy can see, and the callers of a
// `#[wasm_bindgen]` export are on the other side of the JS boundary —
// invisible by construction. It fires here at all only because the canon
// sets `avoid-breaking-exported-api = false`, which is what makes the
// public surface the most-linted code rather than the least.
// `missing_const_for_fn` is impossible to satisfy rather than merely
// unwanted: `#[wasm_bindgen]` refuses outright — "can only
// #[wasm_bindgen] non-const functions".
// `cfg_attr`, not a bare expect: under `cfg(test)` the test module is a
// second caller, so the lint does not fire and an unconditional
// expectation would itself be unfulfilled — an `#[expect]` has to be true
// in every configuration the file is compiled in.
#[cfg_attr(
    not(test),
    expect(
        clippy::single_call_fn,
        reason = "the callers are JS, across the wasm boundary clippy cannot see"
    )
)]
#[expect(
    clippy::missing_const_for_fn,
    reason = "#[wasm_bindgen] rejects const fn"
)]
#[inline]
#[must_use]
#[wasm_bindgen]
pub fn answer() -> u32 {
    lab_core::answer()
}
