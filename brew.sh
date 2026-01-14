#!/bin/bash

set -Eeuo pipefail
trap 'echo "Error: failed on line $LINENO, exiting..."; exit 1' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE="$SCRIPT_DIR/Brewfile"
TARGET="$HOME/Brewfile"

# verify existence
if [[ ! -f "$SOURCE" ]]; then
	echo "Error: Brewfile not found at $SOURCE"
fi

# symlink-ing
if [[ -L "$TARGET" ]]; then
	ln -sf "$SOURCE" "$TARGET"
elif [[ -e "$TARGET" ]]; then
	echo "Error: $TARGET exists and is not a symlink"
	exit 1
else 
	ln -s "$SOURCE" "$TARGET"
fi

# install brew
if ! command -v brew >/dev/null 2>&1; then
	if ! command -v curl >/dev/null 2>&1; then
		echo "Error: curl is required to install Homebrew"
		exit 1
	fi

	# got from https://brew.sh
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# fallback for intel macs, which probably wont be used lol
	if [[ -d /opt/homebrew/bin ]]; then
		BREW_PREFIX="/opt/homebrew"
    elif [[ -d /usr/local/bin ]]; then
    	BREW_PREFIX="/usr/local"
  	else
    	echo "Error: Homebrew installed but prefix not found"
    	exit 1
  	fi

	# post installation steps
  	eval "$("$BREW_PREFIX/bin/brew" shellenv)"

	ZPROFILE="$HOME/.zprofile"
	SHELLENV_CMD="eval \"\$($BREW_PREFIX/bin/brew shellenv)\""

	if [[ -f "$ZPROFILE" ]] && grep -Fxq "$SHELLENV_CMD" "$ZPROFILE"; then
		:
	else
		echo "$SHELLENV_CMD" >>"$ZPROFILE"
	fi

	# verification
	if ! command -v brew >/dev/null 2>&1; then
		echo "Error: brew command not available on check"
		exit 1	
	fi
fi

# install dependencies, yay
brew bundle install --file="$SOURCE"
