#!/bin/sh

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# vim plugin manager install
git clone git://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
