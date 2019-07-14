#!/bin/bash
# Set up the appropriate rustc toolchain

cd "$(dirname "$0")"

cratesio_version=$(cargo search rustup-toolchain-install-master | grep -o "[0-9]\.[0-9]\.[0-9]")
rtim_version=$(rustup-toolchain-install-master --version | grep -o "[0-9]\.[0-9]\.[0-9]")

if ! command -v rustup-toolchain-install-master > /dev/null; then
  cargo install rustup-toolchain-install-master --debug
else
  if [ $rtim_version != $cratesio_version ]; then
    cargo install rustup-toolchain-install-master --debug --force
  fi
fi

RUSTC_HASH=$(git ls-remote https://github.com/rust-lang/rust.git master | awk '{print $1}')
rustup-toolchain-install-master -f -n master "$RUSTC_HASH"
rustup override set master
