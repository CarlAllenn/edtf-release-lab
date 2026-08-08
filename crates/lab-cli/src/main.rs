fn main() {
    println!("lab-cli {} (answer: {})", env!("CARGO_PKG_VERSION"), lab_core::answer());
}
