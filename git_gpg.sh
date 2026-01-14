#!/bin/bash

set -Eeuo pipefail
trap 'echo "Error: failed on line $LINENO"; exit 1' ERR

# define dirs and handle permissions
GPG_DIR="$HOME/.gnupg"
mkdir -p "$GPG_DIR"
chmod 700 "$GPG_DIR"

# config gpg agent to use pinentry
PINENTRY_PATH="$(command -v pinentry)"
if [[ -z "$PINENTRY_PATH" ]]; then
  echo "Error: pinentry not found"
  exit 1
fi

AGENT_CONF="$GPG_DIR/gpg-agent.conf"
echo "pinentry-program $PINENTRY_PATH" > "$AGENT_CONF"

# tell gpg to use gpg-agent
GPG_CONF="$GPG_DIR/gpg.conf"
if ! grep -Fxq "use-agent" "$GPG_CONF" 2>/dev/null; then
  echo "use-agent" >> "$GPG_CONF"
fi

# reload gpg-agent
gpgconf --kill gpg-agent || true
gpgconf --launch gpg-agent

# gpg_tty config in rc file
SHELL_RC="$HOME/.zshrc"
TTY_LINE='export GPG_TTY=$(tty)'
if ! grep -Fxq "$TTY_LINE" "$SHELL_RC" 2>/dev/null; then
  echo "" >> "$SHELL_RC"
  echo "# Ensure GPG can prompt in terminal" >> "$SHELL_RC"
  echo "$TTY_LINE" >> "$SHELL_RC"
fi

# create gpg key and continue on
echo "If you already have a GPG key, import or skip. Otherwise generate one."
echo "To generate a new key, use: gpg --full-generate-key"
read -p "Do you want to generate a new GPG key now? (y/N): " GENERATE
if [[ "$GENERATE" =~ ^[Yy]$ ]]; then
  gpg --full-generate-key
fi

# git side config
echo "Available GPG secret keys as below:"
gpg --list-secret-keys --keyid-format=long

echo "Enter the GPG key ID you want to use for commit signing:"
read -r GPG_KEY_ID

git config --global gpg.program "$(command -v gpg)"
git config --global user.signingkey "$GPG_KEY_ID"

read -p "Enable Git commit signing by default? (y/N): " SIGNALL
if [[ "$SIGNALL" =~ ^[Yy]$ ]]; then
  git config --global commit.gpgsign true
fi

echo "Setup finished. Reload your terminal or source ~/.zshrc."
