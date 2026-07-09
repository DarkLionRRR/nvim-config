#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -e "$HOME/.config/nvim-dev" ]]; then
    mkdir -pv "$HOME/.config"
    ln -s "$SCRIPT_DIR" "$HOME/.config/nvim-dev"
    echo "This config installed"
fi
