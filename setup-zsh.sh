# install zsh and ohmyz.sh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  # install

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# install zsh highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo 'source ~/junhosetting/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
# source zsh later

# Copy my setup to zshrc
echo 'source ~/junhosetting/my-alias.sh'  >> ~/.zshrc
cat my-zsh-iterm >> ~/.zshrc
