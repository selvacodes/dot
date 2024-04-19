#!/usr/bin/env rust-script
//! This is a regular crate doc comment, but it also contains a partial
//! Cargo manifest.  Note the use of a *fenced* code block, and the
//! `cargo` "language".
//!
//! ```cargo
//! [dependencies]
//! anyhow = "1.0.82"
//! rofi = "0.4.0"
//! ```
use std::os::unix::process::CommandExt;
use std::process::Command;

use anyhow::anyhow;
use anyhow::Result;

fn main() -> Result<()> {
    let mut ze = Command::new("zellij");
    ze.arg("list-sessions");
    ze.arg("--no-formatting");
    let x = ze
        .output()
        .map_err(|_| anyhow!("Error in executinf command zellij"))?;
    let y = String::from_utf8(x.stdout)?;
    let sessions: Vec<String> = y.lines().map(String::from).collect();
    match rofi::Rofi::new(&sessions).run() {
        Ok(choice) => {
            let session_name = choice
                .split_whitespace()
                .next()
                .ok_or(anyhow!("Unable to get session name"))?;

            let mut al = Command::new("alacritty");
            let open_command = format!("zellij a {}", session_name);
            al.arg("-e").arg("sh").arg("-c").arg(open_command);
            al.exec();
            println!("opened {:?}", al)
        }
        Err(rofi::Error::Interrupted) => println!("Interrupted"),
        Err(e) => println!("Error: {}", e),
    }
    println!("Hello, world! {:?}", sessions);
    Ok(())
}
