use wasm_bindgen::prelude::*;

/// The one thing the package exists to do, callable from JS.
#[wasm_bindgen]
pub fn answer() -> u32 {
    lab_core::answer()
}

#[cfg(test)]
mod tests {
    #[test]
    fn answers() {
        assert_eq!(super::answer(), 42);
    }
}
