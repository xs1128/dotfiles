#! /bin/bash

files="bash_profile tmux.conf vimrc zprofile zshrc gitignore aliases vim gitconfig"

for file in $files; do 
    ln -s ~/.dotfiles/.$file ~/.$file
done
