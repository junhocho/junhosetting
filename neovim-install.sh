#source ~/.zshrc	

# Option 1: Install from apt (older version)
# sudo apt install neovim
# sudo apt install python3-neovim

# Option 2: Install latest Neovim (v0.11.1) from GitHub releases
echo "Installing latest Neovim from GitHub releases..."
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
mkdir -p ~/.local
cp -r nvim-linux-x86_64/* ~/.local/
rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz

# Add ~/.local/bin to PATH if not already there
if ! echo $PATH | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# VIM
# vim-plug은 더 이상 필요없음 (init.lua는 lazy.nvim 사용)
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
# 	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim and copy .vimrc
# cp ~/junhosetting/vimrc ~/.vimrc
# --> source vimrc for frequent vimrc update
echo 'source ~/junhosetting/vimrc' > ~/.vimrc

# Python3 required!!
pip install neovim


# AppImage는 더 이상 필요없음 (위에서 이미 tar.gz 설치함)
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage

# Config changed from neovim
mkdir -p ~/.config/nvim/
# For new Lua-based configuration (recommended for v0.11+)
echo "-- junhosetting의 init.lua를 불러오기" > ~/.config/nvim/init.lua
echo "vim.cmd('luafile ~/junhosetting/init.lua')" >> ~/.config/nvim/init.lua
# Keep old vimscript config as backup
# echo "source ~/.vimrc" >> ~/.config/nvim/init.vim

# vim-plug도 필요없음 (lazy.nvim이 자동 설치됨)
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# # install vundle --> changed to plug
# # git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# # Some plugins git cloned in the folder
# git clone https://github.com/tbastos/vim-lua.git ~/.vim/plugged/vim-lua
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim/plugged/nerdtree
# git clone https://github.com/majutsushi/tagbar.git ~/.vim/plugged/tagbar
# git clone https://github.com/hdima/python-syntax.git ~/.vim/plugged/python-syntax
# git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe
# git clone https://github.com/junegunn/seoul256.vim.git ~/.vim/plugged/seoul256.vim
# #git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
# #mkdir ~/.vim/plugged/completor/start
# #git clone https://github.com/maralla/completor.vim.git ~/.vim/plugged/completor/start/completor.vim




# echo "Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}" >> 

# cd ~/.vim/plugged/YouCompleteMe
# git submodule update --init --recursive
# ./install.sh
# REFER :  http://neverapple88.tistory.com/26
# https://github.com/Valloric/YouCompleteMe
cd ~/junhosetting

# also make .nvimrc symlink
# ln -s ~/.vimrc ~/.nvimrc
# ln -s ~/.vimrc  ~/.config/nvim/init.vim
# Create alias for nvim (if using ~/.local/bin installation)
# The PATH update above should make 'nvim' available directly
# But we can add 'vi' alias for convenience
echo "alias vi='nvim'" >> ~/.bashrc
echo "alias vi='nvim'" >> ~/.zshrc

source ~/.zshrc

# lazy.nvim은 자동으로 플러그인을 설치하므로 수동 명령 불필요
# vi +UpdateRemotePlugins
# vi +PlugInstall

echo "Neovim installation complete!"
echo "Run 'nvim' to start Neovim. Plugins will be installed automatically on first run."

git config --global core.editor $(which nvim)
