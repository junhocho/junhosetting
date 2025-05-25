#!/bin/bash
# This is recommended to run in clean slate user.
# run this in ~/junhosetting
# run this with   `sh setup-all.sh` and exit just after `zsh` is installed to proceed following configurations.

# sudo needed
# docker :  https://docs.docker.com/install/linux/docker-ce/ubuntu/
# nvidia container toolkit https://github.com/NVIDIA/nvidia-docker
# sudo usermod -aG docker ${USER}
# sudo chmod 666 /var/run/docker.sock
# ## apt-install
# sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install tmux zsh curl vim neovim ctags

# GIT setup
git config --global user.email "junho@sudormrf.run"
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

# change default shell
# Neovim install
./neovim-install.sh
chsh -s /usr/bin/zsh ${USER}

# Install Pytorch here : https://pytorch.org/

echo "Now enjoy! start with command : zsh!"
zsh
