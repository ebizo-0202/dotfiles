#!/bin/sh
 
if [ ! -e _gitconfig ]; then
    echo "You must modify _gitconfig.example as _gitconfig before execute this script"
    exit 1
fi

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.xvimrc ~/.xvimrc
ln -sf ~/dotfiles/.tmux ~/.tmux
 
# vim plugin manager install
git clone git://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
