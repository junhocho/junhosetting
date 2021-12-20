#!/bin/bash
# This is recommended to run in clean slate user.
# run this in ~/junhosetting
# run this with   `sh setup-all.sh` and exit just after `zsh` is installed to proceed following configurations.


# GIT setup
git config --global user.email "junhocho@snu.ac.kr"
git config --global user.name "junhocho"
git config --global push.default simple
git config --global core.editor vim

# ZSH
./setup-zsh.sh

# TMUX
# Tmux resurrect
git clone https://github.com/tmux-plugins/tmux-resurrect ~/junhosetting/tmux-resurrect
# cp ~/junhosetting/tmux.conf ~/.tmux.conf
echo 'source ~/junhosetting/tmux.conf' > ~/.tmux.conf
tmux source ~/.tmux.conf

# VIM
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim and copy .vimrc
# cp ~/junhosetting/vimrc ~/.vimrc
# --> source vimrc for frequent vimrc update
echo 'source ~/junhosetting/vimrc' > ~/.vimrc
vim +PlugInstall

# change default shell
chsh -s /usr/bin/zsh ${USER}

# Install Pytorch here : https://pytorch.org/

echo "Now enjoy! start with command : zsh!"
zsh
