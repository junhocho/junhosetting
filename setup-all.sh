# run this in ~/junhosetting
# This is recommended to run in clean slate user.

# install zsh and ohmyz.sh
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # install
sudo chsh -s /usr/bin/zsh ${USER}

# install zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# concat my alias to .zshrc
cat ~/junhosetting/alias >> ~/.zshrc

# install tmux and set tmux.conf
sudo apt-get install tmux -y
cp ~/junhosetting/tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

# install vim and copy .vimrc 
sudo apt-get install vim -y
cp ~/junhosetting/vimrc ~/.vimrc
# install vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim
touch installVimPlugin
echo "do   `:PluginInstall` \n and exit with `:wq`" >> installVimPlugin

echo "done installing plugins"
rm installVimPlugin

