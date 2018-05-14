#!/bin/bash
# This is recommended to run in clean slate user.
# run this in ~/junhosetting
# run this with   `sh setup-all.sh` and exit just after `zsh` is installed to proceed following configurations.

# GIT setup
git config --global user.email "junhocho@snu.ac.kr"
git config --global user.name "junhocho"
git config --global push.default simple
git config --global core.editor vim

# install zsh and ohmyz.sh
sudo apt-get install zsh curl -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  # install

# install zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo 'source ~/junhosetting/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
# source zsh later

# Copy my setup to zshrc
cat my-zsh-setup >> ~/.zshrc

# TMUX
# install tmux and set tmux.conf
# sudo apt-get install -y python-software-properties software-properties-common
# sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install tmux #-y tmux=2.0-1~ppa1~t


# Tmux resurrect
git clone https://github.com/tmux-plugins/tmux-resurrect ~/junhosetting/tmux-resurrect

# cp ~/junhosetting/tmux.conf ~/.tmux.conf
echo 'source ~/junhosetting/tmux.conf' > ~/.tmux.conf
tmux source ~/.tmux.conf

# install vim and copy .vimrc
sudo apt-get install vim -y
#cp ~/junhosetting/vimrc ~/.vimrc
# also source vimrc for frequent vimrc update
echo 'source ~/junhosetting/vimrc' > ~/.vimrc

# change default shell
sudo chsh -s /usr/bin/zsh ${USER}


# ANACONDA and python setup
wget https://repo.anaconda.com/archive/Anaconda3-5.1.0-Linux-x86_64.sh
bash Anaconda3-5.1.0-Linux-x86_64.sh
echo 'export PATH="/home/junho/anaconda3/bin:$PATH"' >> ~/.zshrc

# Neovim install
./neovim-install.sh

# Install Pytorch here : https://pytorch.org/

echo "Now enjoy! start with command : zsh!"
zsh
