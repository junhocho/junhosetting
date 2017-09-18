sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
# Config changed from neovim
mkdir ~/.config/nvim/
echo "source ~/.nvimrc" >> ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# also make .nvimrc symlink
ln -s ~/.vimrc ~/.nvimrc
echo "alias vi='nvim'" >> ~/.zshrc
echo "Now Reload your zsh!"
