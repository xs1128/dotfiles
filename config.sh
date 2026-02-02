#!/bin/bash

set -e

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"

add() {
  touch "$2"
  grep -Fxq "$1" "$2" || echo "$1" >> "$2"
}

# append into
chmod u+x "$CONFIG_DIR/autojump.sh" "$CONFIG_DIR/autosuggest.sh" "CONFIG_DIR/zsh-vi-mode.sh"
. "$CONFIG_DIR/autojump.sh"
. "$CONFIG_DIR/autosuggest.sh"
. "$CONFIG_DIR/zsh-vi-mode.sh"

# symbolic links
ln -sf "$CONFIG_DIR/aliases.sh" "$HOME/.aliases.sh"
echo " => Linked aliases.sh to $HOME/.aliases.sh"
add '[ -f "$HOME/.aliases.sh" ] && . "$HOME/.aliases.sh"' "$HOME/.zshrc"

ln -sf "$CONFIG_DIR/tmux.conf" "$HOME/.tmux.conf"
echo " => Linked tmux.conf to $HOME/.tmux.conf"


