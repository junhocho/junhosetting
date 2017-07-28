# Junho setting

git clone --depth 1 <repo>

## you can configure zsh, vim plugins, tmux with `./setup-all.sh`

it installs all zsh, vim , tmux firt
run `./setup-all.sh` then input passwords 2 times (for sudo) then `exit` at first zsh to proceed following installs.

powerline font might be needed : https://github.com/powerline/fonts

Personally shifting vim to [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
Here's my [`neovim`](./neovim-install.sh). It also installs [vim-plug](https://github.com/junegunn/vim-plug#example)

Using Iterm2 and want to fix my tab name.
Disable all  `Iterm2 > Preferences > Appearance > Window & Tab Titles`
include this code in zshrc:
```
DISABLE_AUTO_TITLE="true"
echo -ne "\e]1;serverName\a"
```

---

Some explanations:

- install_txt : what i normally install first
- portforward : copy in `/usr/bin` or `/usr/local/bin/` and `$ portforward user@123.123.123.123 8888`
- imgcat : useful with iterm2
- bash_profile
- bashrc
- tmux.conf
- vimrc
- zshrc

---
CLI environment presentation inspired from [@nicknisi](https://github.com/nicknisi/vim-workshop)

## [Slides pdf](https://dl.dropboxusercontent.com/u/51664086/get-used-to-cli.pdf)

## [Slides md](./get-used-to-cli.md)
