#!/bin/bash
set -e

run_if() {
  local cmd="$1"
  local script="$2"

  if eval "$cmd"; then
    chmod u+x "$script"
    ./"$script"
  else
    echo "$(basename "$script") skipped"
  fi
}

prompt() {
  read -rp "$1 [y/N] " a
  [[ "$a" =~ ^[Yy]$ ]]
}

echo "==> 1. Brew install"
run_if "command -v brew >/dev/null" brew.sh
echo "==> 2. autojump"
run_if "command -v autojump >/dev/null" autojump.sh

echo "==> 3. tmux"
run_if "command -v tmux >/dev/null" tmux.sh

echo "==> 4. git gpg"
run_if "command -v gpg >/dev/null" git_gpg.sh

echo "==> 5. github gpg"
if git config --global --get user.signingkey >/dev/null 2>&1; then
  chmod u+x github_gpg.sh
  ./github_gpg.sh
elif prompt "GPG key unclear, run GitHub GPG setup anyway?"; then
  chmod u+x ithub_gpg.sh
  ./github_gpg.sh
fi

echo "==> Done"
