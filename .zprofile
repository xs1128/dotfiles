# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH

eval "$(/opt/homebrew/bin/brew shellenv)"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Test if ~/.aliases exists and source it
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

if [ -f ~/.virtualenvs/bin/activate ]; then
    source ~/.virtualenvs/bin/activate
fi

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Created by `pipx` on 2025-02-22 15:41:58
export PATH="$PATH:/Users/xsooi1128/.local/bin"

# Added by `rbenv init` on Sat Apr 26 17:01:36 CST 2025
eval "$(rbenv init - --no-rehash zsh)"


# Added by Toolbox App
export PATH="$PATH:/Users/xsooi1128/Library/Application Support/JetBrains/Toolbox/scripts"

