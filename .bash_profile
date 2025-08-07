# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

source "$HOME/.config/broot/launcher/bash/br"

# ~/.bashrc or ~/.bash_profile

# Initialize Starship prompt for bash
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# Update PATH environment variable
export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/util-linux/bin:/opt/homebrew/opt/util-linux/sbin:/opt/homebrew/opt/ruby/bin:$HOME/.local/bin:$PATH"
# Visual Studio Code command line
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# GPG signing setup
if command -v gpg > /dev/null 2>&1; then
  export GPG_TTY=$(tty)
fi

# Enable python virtualenv prompt handling (disable venv prompt)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Add custom function to add to PATH only if not present
path_add() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# Adding paths (make sure to call path_add if required, if not already added)
path_add "/opt/homebrew/opt/llvm/bin"
path_add "$HOME/.local/bin"
path_add "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Source aliases if exists
if [ -f "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Source broot launcher removal note:
# You had this line before -> source "$HOME/.config/broot/launcher/bash/br"
# If you don't want broot, remove this line from your bash config.

# Additional bash config workarounds (optional):

# Use "cdspell" option (if bash supports) to autocorrect minor cd typos:
shopt -s cdspell

# Enable programmable completion, if not already enabled (most distros do):
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# Bash does NOT have equivalent to zsh's `setopt autoread`, `correct`, `autocd` by default.

# For autocorrect like functionality:
# You can use "shopt -s cdspell" as above.

# For automatic cd without "cd" command, you would need custom functions or tools (not included here).


