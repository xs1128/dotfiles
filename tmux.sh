#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$SCRIPT_DIR/config/tmux.conf" ~/.tmux.conf

echo " => Linked tmux.conf to ~/.tmux.conf"
