#!/bin/bash

set -Eeuo pipefail
trap 'echo "Error: failed on line $LINENO"; exit 1' ERR

# ensure gpg is installed and available
if ! command -v gpg >/dev/null 2>&1; then
  echo "Error: GPG is not installed"
  exit 1
fi

# prompt user for key ID
echo "Listing available GPG secret keys (long format):"
gpg --list-secret-keys --keyid-format=long

echo ""
read -p "Enter the GPG key ID you want to export for GitHub: " GPG_KEY_ID

# export public key in ASCII armor format
PUBKEY_FILE="$HOME/GPG_PUBLIC_KEY_${GPG_KEY_ID}.asc"
gpg --armor --export "$GPG_KEY_ID" > "$PUBKEY_FILE"

# double check the file content
if [[ ! -s "$PUBKEY_FILE" ]]; then
  echo "Error: exported public key file is empty or missing"
  exit 1
fi

# copy to macOS clipboard
if command -v pbcopy >/dev/null 2>&1; then
  cat "$PUBKEY_FILE" | pbcopy
  echo "Public GPG key copied to clipboard"
else
  echo "pbcopy not found; public key saved at $PUBKEY_FILE"
fi

echo ""
echo "Add the public GPG key to GitHub:"
echo "1) Go to GitHub -> Settings -> SSH and GPG keys"  
echo "2) Click 'New GPG key'"  
echo "3) Paste the key copied to the clipboard or from $PUBKEY_FILE"  
echo ""
echo "Your public key file location: $PUBKEY_FILE"

