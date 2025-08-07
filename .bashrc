# tmux
eval "$(starship init zsh)"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/util-linux/bin:/opt/homebrew/opt/util-linux/sbin:/opt/homebrew/opt/ruby/bin:$HOME/.local/bin:$PATH"

# GPG Signing
if command -v gpg >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
fi

# Enable python venv to work properly
export VIRTUAL_ENV_DISABLE_PROMPT=

setopt correct
setopt autocd
