#!/bin/bash
set -e

add() { touch "$2"; grep -Fxq "$1" "$2" || echo "$1" >> "$2"; }

LINE='[[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh'

case "$SHELL" in
  */zsh)
    add "$LINE" ~/.zshrc
    ;;
  */bash)
    add "$LINE" ~/.bash_profile
    ;;
  */fish)
    mkdir -p ~/.config/fish
    add '[ -f (brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; and source (brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' \
        ~/.config/fish/config.fish
    ;;
esac
