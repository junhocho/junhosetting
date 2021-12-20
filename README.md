# Junho setting

## setup github authentication

```
ssh-keygen -t rsa -C "junhocho@snu.ac.kr"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

ssh -T git@github.com
```

## git clone

For faster clone:
`git clone --depth 1 git@github.com:junhocho/junhosetting.git`

## you can configure zsh, vim plugins, tmux with `./setup-all.sh`

- It installs all zsh, vim , tmux firt
- Run `./setup-all.sh` then input passwords when needed.
- `exit` at first zsh to proceed following installs.

## Install anaconda3

- Install python3. `sh setup-anaconda.sh`

# Neovim

- I prefer [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) over vim.
- Here's my [`neovim`](./neovim-install.sh).
- It also installs [vim-plug](https://github.com/junegunn/vim-plug#example)
- Install python3 first. `sh setup-anaconda.sh`
- Simple install with `sh neovim-install.sh`
- powerline font might be needed at your client : https://github.com/powerline/fonts

# Iterm-2 setup

- Using Iterm2, show server name on tabe.
- Disable all  `Iterm2 > Preferences > Appearance > Window & Tab Titles`
- include this code in zshrc:
```
DISABLE_AUTO_TITLE="true"
echo -ne "\e]1;serverName\a"
```

# Some more explanations:

- install_txt : what i normally install first
- portforward : copy in `/usr/bin` or `/usr/local/bin/` and `$ portforward user@123.123.123.123 8888`
- imgcat : useful with iterm2
- tmux.conf
- vimrc
- zshrc
- my-zsh-setup : my useful alias
- install-pytorch.sh : install anaconda3 and pytorch3


CLI environment presentation inspired from [@nicknisi](https://github.com/nicknisi/vim-workshop)

## [info](http://tmmse.xyz/2018/04/01/command-line-interface/)

## [Slides md](./get-used-to-cli.md)
