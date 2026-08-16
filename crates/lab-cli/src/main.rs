use std::env::consts::ARCH;

// The global allocator is compiled C (libmimalloc-sys), so this binary
// cannot link for *-musl without a musl-targeting C compiler — which is
// exactly what the fixture exists to prove.
/// The allocator the musl-linking fixture turns on: documented because
/// `missing_docs_in_private_items` reaches statics too (canon #445).
#[global_allocator]
static GLOBAL: mimalloc::MiMalloc = mimalloc::MiMalloc;

// `clippy::print_stdout` (restriction) bans writing to stdout, and this
// is a CLI whose entire output is that line — the lint is right about
// library code and structurally wrong about a binary that exists to
// print. Narrow, reasoned, and it fails the moment the println goes.
#[expect(
    clippy::print_stdout,
    reason = "this is the CLI fixture; printing is what it does"
)]
fn main() {
    println!("{}", lab_core::banner(env!("CARGO_PKG_VERSION"), ARCH));
}
