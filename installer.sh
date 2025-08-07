#!/bin/zsh

# Dotfiles to link
files=(bash_profile tmux.conf vimrc zprofile zshrc gitconfig aliases vim, better-branch.sh)

# Print usage
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
  source_file="$HOME/.dotfiles/.$file"

  if [[ ! -e "$source_file" ]]; then
    echo "Warning: Source file $source_file does not exist, skipping."
    continue
  fi

  if $dry_run; then
    echo "[Dry-run] Would link $source_file to $target"
  else
    ln -sf "$source_file" "$target"
    echo "Linked $target -> $source_file"
  fi
done

