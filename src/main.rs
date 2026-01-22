mod config;
mod dtos;
mod error;
mod models;

struct LinusTorvalds;

impl LinusTorvalds {
    fn said(&self) -> &str {
        "Most good programmers do programming not because they expect to get paid /
     or get adulation by the public, but because it is fun to program."
    }
}
fn main() {
    let linus_torvalds = LinusTorvalds;
    println!("Hello, -- {}!", linus_torvalds.said());
}
