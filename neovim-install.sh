sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim ctags -y

sudo pip install neovim
# pip install neovim # if python overided

# Config changed from neovim
mkdir -p ~/.config/nvim/
echo "source ~/.vimrc" >> ~/.config/nvim/init.vim

# Old deprcated
#curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vundle --> changed to plug
# git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Some plugins git cloned in the folder
git clone https://github.com/tbastos/vim-lua.git ~/.vim/plugged/vim-lua
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/plugged/nerdtree
git clone https://github.com/majutsushi/tagbar.git ~/.vim/plugged/tagbar
git clone https://github.com/hdima/python-syntax.git ~/.vim/plugged/python-syntax
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe
git clone https://github.com/junegunn/seoul256.vim.git ~/.vim/plugged/seoul256.vim
#git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
#mkdir ~/.vim/plugged/completor/start
#git clone https://github.com/maralla/completor.vim.git ~/.vim/plugged/completor/start/completor.vim


pip install neovim
nvim +PluginInstall
cd ~/.vim/plugged/YouCompleteMe
git submodule update --init --recursive
./install.sh
# REFER :  http://neverapple88.tistory.com/26
# https://github.com/Valloric/YouCompleteMe
cd ~/junhosetting

# also make .nvimrc symlink
# ln -s ~/.vimrc ~/.nvimrc
ln -s ~/.vimrc  ~/.config/nvim/init.vim
echo "alias vi='nvim'" >> ~/.zshrc
echo "Now Reload your zsh!"
