#!/bin/bash

set -e

add() { grep -Fxq "$1" "$2" || echo "$1" >> "$2"; }

case "$SHELL" in
  */zsh)  add '[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh' ~/.zshrc ;;
  */bash) add '[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh' ~/.bash_profile ;;
  */fish)
    mkdir -p ~/.config/fish
    add '[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish' ~/.config/fish/config.fish
    ;;
esac
