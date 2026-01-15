#!/bin/bash

set -e

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"

ln -sf "$CONFIG_DIR/aliases.sh" ~/.aliases.sh
echo " => Linked aliases.sh to ~/.aliases.sh"

ln -sf "$CONFIG_DIR/tmux.conf" ~/.tmux.conf
echo " => Linked tmux.conf to ~/.tmux.conf"


