# install zsh and ohmyz.sh
sudo apt-get install zsh curl -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  # install

# install zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo 'source ~/junhosetting/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
# source zsh later

# Copy my setup to zshrc
cat my-zsh-setup >> ~/.zshrc
