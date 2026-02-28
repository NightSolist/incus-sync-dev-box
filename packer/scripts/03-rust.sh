#!/bin/bash
set -e

echo "═══ Установка Rust ═══"

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo 'source $HOME/.cargo/env' >> ~/.bashrc

source $HOME/.cargo/env
echo "Rust: $(rustc --version)"