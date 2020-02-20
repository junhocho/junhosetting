# install zsh and ohmyz.sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  # install

# install zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo 'source ~/junhosetting/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
# source zsh later

# Copy my setup to zshrc
cat my-alias >> ~/.zshrc
