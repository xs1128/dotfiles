#!/bin/bash
set -e

add() { touch "$2"; grep -Fxq "$1" "$2" || echo "$1" >> "$2"; }

LINE='[[ -f $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]] && source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh'

case "$SHELL" in
  */zsh)
    add "$LINE" ~/.zshrc
    ;;
  */bash)
    add "$LINE" ~/.bash_profile
    ;;
  */fish)
    mkdir -p ~/.config/fish
    add '[[ -f $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]] && source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh' \
        ~/.config/fish/config.fish
    ;;
esac
