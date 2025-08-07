#!/usr/bin/env zsh

DOTFILES_DIR="$HOME/.dotfiles"
STARSHIP_SRC="$DOTFILES_DIR/starship.toml"
CONFIG_DIR="$HOME/.config"
STARSHIP_DEST="$CONFIG_DIR/starship.toml"

# Dotfiles to link
files=(bash_profile tmux.conf vimrc zprofile zshrc gitconfig aliases)

usage() {
  echo "Usage: $0 [--dry-run]"
  echo "  --dry-run  Show what would be done without making changes"
}

dry_run=false

if [[ "$1" == "--dry-run" ]]; then
  dry_run=true
elif [[ -n "$1" ]]; then
  usage
  exit 1
fi

for file in "${files[@]}"; do
  target="$HOME/.$file"
  source_file="$DOTFILES_DIR/.$file"

  if [[ ! -e "$source_file" ]]; then
    echo "Warning: Source file $source_file does not exist, skipping."
    continue
  fi

  if $dry_run; then
    echo "[Dry-run] Would link $source_file to $target"
  else
    ln -sf "$source_file" "$target"
    echo "Linked ."$file" -> $source_file"
  fi
done

# starship toml
if $dry_run; then
  echo "[Dry-run] Would create $CONFIG_DIR and link $STARSHIP_SRC to $STARSHIP_DEST"
else
  mkdir -p "$CONFIG_DIR"
  ln -sf "$STARSHIP_SRC" "$STARSHIP_DEST"
  echo "Linked starship.toml -> $STARSHIP_DEST"
fi
