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
use std::collections::HashMap;
use std::os::unix::process::CommandExt;
use std::process::Command;

use anyhow::anyhow;
use anyhow::Result;

fn main() -> Result<()> {
    let mut configs = HashMap::new();

    configs.insert("Alacritty", "/home/selva/.config/alacritty/alacritty.toml");
    configs.insert("Neovim", "/home/selva/.config/nvim-custom");
    configs.insert("XMonad", "/home/selva/.xmonad");
    configs.insert("Fish", "/home/selva/.config/fish");
    let apps = configs.keys().collect::<Vec<_>>();

    match rofi::Rofi::new(&apps).run() {
        Ok(choice) => {
            let mut al = Command::new("nohup");
            let path_to_config = configs
                .get(&*choice)
                .ok_or(anyhow!("Unable to get config"))?;
            let open_command = format!("nvim {} >/dev/null 2>&1 &", path_to_config);
            al.arg("alacritty").arg("-e").arg(open_command);
            println!("{:?}",al)
            al.exec();
        }
        Err(rofi::Error::Interrupted) => println!("Interrupted"),
        Err(e) => println!("Error: {}", e),
    }
    Ok(())
}
