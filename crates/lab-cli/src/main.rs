// The global allocator is compiled C (libmimalloc-sys), so this binary
// cannot link for *-musl without a musl-targeting C compiler — which is
// exactly what the fixture exists to prove.
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

fn main() {
    println!(
        "lab-cli {} on {} (answer: {})",
        env!("CARGO_PKG_VERSION"),
        std::env::consts::ARCH,
        lab_core::answer()
    );
}
