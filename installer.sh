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

echo "==> 2–3. Git & GitHub GPG"
if prompt "Setup gpg for git and github?"; then
	echo "==> 2. git gpg"
	run_if "command -v gpg >/dev/null" git_gpg.sh

	echo "==> 3. github gpg"
	if git config --global --get user.signingkey >/dev/null 2>&1; then
	  chmod u+x github_gpg.sh
	  ./github_gpg.sh
	elif prompt "GPG key unclear, run GitHub GPG setup anyway?"; then
	  chmod u+x github_gpg.sh
	  ./github_gpg.sh
	fi
else
	echo "gpg setup skipped."
fi

echo "==> 4. tool's dmg"
chmod u+x manual.sh
./manual.sh

echo "==> 5. config (tmux, aliases, autojump, auto-sugg)"
chmod u+x config.sh
./config.sh

echo "==> Done"
