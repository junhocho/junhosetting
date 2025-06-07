# Junho setting

## setup github authentication

```
ssh-keygen -t rsa -C "junhocho@snu.ac.kr"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

// add `~/.ssh/id_rsa` in github profile SSH keys.

ssh -T git@github.com


ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwhlRIXw5eRPiBBe9eDprklLLQ2cjFmpv1/RY5zotDLaJ80SMQONoKufETWYTbGpk2QOji6uHME3MX9iz93sUj3wmLZJMPXC8TAmDlFNC80Q4kKY9XVZsJo5b8YxArawbKba+DYfGxjmKke10yYhEWh1zHtRJYW4+POsKx4obD95iJSLiIe7ezejyASCIP6sGtO6djEqBpX86L29dqTjL1eyV6O7D9KJ2NFJBKFbXfZYluYAJtUcFDtS75nzV9kXL4n8BrKTGkG7mZVOP7SO89XUUOe7GhGakJim0EOBaweZgmjo2IjJeTr7kKnDTj99qLSFabekoNaMMvHqBFWKFrxHhRUJWo/Qjqt6N2L+ABvACkeufava1C0XYN9H1dgP0VpWcKwEej6qRdwIH/75btc5MX4pvSDjyXQwGfj1aj7rITTeIgZjHpK6UpsY+iUR/12pvTb6iQnzREwbywJ0ym0ehqD/4LzCnf2Mi2afy2e845zMAVGoBQK20zsfIlcTtBvdcqbodEZzsW8+yDMi/xVINwbAalWvq1OZu0ufxdn2a8Gb4fI5+hb1sANfwdtSLoPLwYMbdZp7k2CMYIvqHIE19u3kEgm1uWGEcINTleFGsIjZpdIeHpX3CmUF+hDSDPhyvvnBWw5FqQ/WJvIQI7XgXdJSf+AWRrNPXYQO/INQ== junhocho@snu.ac.kr
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFAMbZw7aebfWiF2oTcM80oqjbVThwwnanlAz/PfGe2+LhPqGB2bCo9tbN1dPOvC0dFN8EUAE+rsuSNbayVUDnJPV35tJGKQ5pDOnin5EH67f4b/OXfajTUh7vQiTS7LkM94un8fcu+Ju9jSe3km7hJDahFbl9Ifoiqs7Zo5Py6m0pu3y+l307MhJ87ypmoMge2XcEiwd6n5M2G6gIfErc+k+BmIWLxX5z4QFBEISRXLiXz4Swj/ucOb8Hb1COpOfDYuGiTztSYobC1v5UbgVpkJXKWNqHPZz+GnV10Npnldi19bwFYdu0Z3mJMrZtLJuf4csLSBmfp62+7HJRYZT2gdlyUZeWrR4JD4nHCjufWHj+Bmu6KygVJTh/+i7lwNh5WAEQZhFu2I8+b4+LVPRuu0xeU3zVlagZT/7KnZKjDZfqC5NvZHwKOTt+3jUnjFG/4aA5LJsuSYG/oL5UfjYHRyNVfpovDPq/opp//LBs0zpTW2+nluR6UAlfFAv7FX526BHPpg9eC9EA5rxJe8mhKpL7nJu86sB0F8Ixf6PH1TFFII5U3j0Oc+6fUqpvK+KW+jid3/O6To8n3mdSDFC1AKPOKY6zrbQiJyO22SdAnj6V8cH5UcmoK0pB2aGpY7r3YA9JWgFjX7b9aKAv1ql/RIESXpU2G+u45lozFen2TQ== junhocho@snu.ac.kr
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxkVLrApLVNFDYlJz+9wQZ+A73YfOiVR9USFaNBiYyg5RAou7k9sTctyV6uKdq8rH3eouOBJdEf4ZNrfLJeoVoNP/rtFaJ0EkkqCyCvBZe6gvp2AqevPuozaQzrAx2CT2IPozIpU39XvaXNgoGRD2nrn0bl24ph3fLUoEVnlrBdj7/J+rQstF3ypJQF7HAaBIJu2XAcxsDVKCavpkcwKjFw3yi5HvE6MsoIlQpNELQRXpXd58bwlCtrtq1BVV9WhSCesRifKx6i+vb3zTH7B5GgM5Tc3gP23LtnTGleuYt+AaX8+6HtMoa6V7Fy/CPzJnxuz1j9VuIgmpjnBd/o65NbUtaR9zPZ8TsFMlaVauu2W3VtVF5d5kfwB4lF1ge/ZvRKXxpysBuPpzwwMeUpKUXsVlxFhzVSLUgxyvOyIEQYPas4dcP95CiO5Oevutr3ldYPNYfKSn4GgxSuDuf70y12iFDJxX4172llJspWiH9N+gG/KpCYtyFonDnU0TqZJ/UkzY2XQb9F42zgoO7ljRTKEdCFOA6aSDchijKx8LYCfm0ANDIhLKmdAOEpIEtecDPekVHVNVshpjbGVLTKkwD0mZK7UYXdhl9hs8mSCKFXrzLiRGH4rHhNwp5wXBSGXBE1X4E/bGaurK/PqtdHu6HOcAV2YmyZFY7Cmgo5BITKQ== junhocho@snu.ac.kr
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpE3YqEVEf4WF4oz101sHQWAMea7H9B5zdsWzzrjDpebXqwN+YNbcZuE7HwPL+0ik3qSuYoPGy1dbQlCW61ZeGw1hGGheRNyqThGG60v2DmxX+C7/G+8rBEmK0SKxKwrL3XchfDrXM+BRV1cnZSs+dDt0UDNmIJMLjguXpA6Uwt+p0dPLgOySxVA6vK543Q2uh9+I1k8SXiJMLBhQR0PTvM6PuzxFSkAR6oGcVz7PsaW91j6I7lT3BzmW1TCld2fHEaATC499fCR5w9YTjfB40WTpjdGOB2pS+rhD+wi5BCRy4fTv0QMxsWeTSQXgFoupT228QGLHyfSmpct2ttX+ah53S4tUmFy+Hz0bScNOC7St2JULDdRBw7xn2DWzIKvfpcwZwQKAejOIG1f1nKHnLaoSj+5s0HLZyrdTjAL2u8eLqW1NXvWjwWxL41p0UGnyq81S95V7236rLEm6BtQKOX88cnqpIjhvwfuQT0dL33SFC6FJzwAWPVByd5zl4P33p/TEFxcMMFo1sbQhzKa/15hQXjgrdyTg8x0teJEiqbFyKTNdLKvxHkbFHgwc8ZL3qnUE5kLf66DNq7hdo8l0IZu/jE3THKSy8DXrsR9C8uXb8+DBUCZk4/MYe2zBc1kTNd0GyAS2KvA/IUbx1AKkW4XofVdDuVnn33GrKZVSnhw== junhocho@snu.ac.kr
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCxGz3eKcLzhHmoQG+RXaPChdKKs+HxHCgGw2XZHyl6GXCr6g7xH0T/QwmrTyumIY1anmObrd0ZOFjm9fyaGeG1mkZJg4Lg3OkLUoLeHNG6CDfQnso4wT9Rt75X9IvrGBJWFl4CkEJTAlfVjXUmnKoB74hOLPOTHYKvJqHrZaqCGO4xjTXyPODWLGzIJeQZKfhS0NvU0ka3EA+UI+UlgJo8QUqgUBSUWLW1f8CwqU2WyNdYLc94ip/4Qq5674u/E1lcIQIXEHpdCt/46Lfus/WNhp1HS6uJkjuNrZv6pLpOY5ajEydi4CtkdDdMZqLGd6osA9AtBcO8mdwVFlj3MkVQFyyfgtynnDhG2mhRO13ZuqqqmuI5e+x1z2QDpHtlSkzfKHDnKsWDLR/UuGGbH5YX8RxCWWdLbNrx4HiRUx30tdUJU7cfJYK6/8Ar3eGmepaSL7MaAzHTF3m2Fv6825rH3xf3ZI7/fXzxHR3X4196qm0WqfYYKiXJGQ2WC6+hf1KXQUf3E+DSnvU5x/wBz4xbZ8mMO9lQouSmfz0zJ32rXR48xBgjHmhtu1xuWe7xZzHeVwJ1ge7+f8wVAEgGirY+DaTsDuzyBgGLmhKseFzbRg8jvEhKTOwIErmwH5zmg/LleI4q0EZq49e50XNqkPUWml2a9QXoIvFAoTvzVKVzZw== junhocho@snu.ac.kr


// paste these public keys in `~/.ssh/authorized_keys`

```

## git clone

For faster clone:
`git clone --depth 1 git@github.com:junhocho/junhosetting.git`

## you can configure zsh, tmux with `./setup-all.sh`

- It installs all zsh, vim , tmux firt
- Run `./setup-all.sh` then input passwords when needed.
- `exit` at first zsh to proceed following installs.

## Install anaconda3

- Install python3. `sh setup-anaconda.sh`

## Neovim

- vim plugins and neovim
- I prefer [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) over vim.
- Here's my [`neovim`](./neovim-install.sh).
- Migrated from vim-plug to [lazy.nvim](https://github.com/folke/lazy.nvim) for better plugin management
- Install python3 first. `sh setup-anaconda.sh`
- Simple install with `sh neovim-install.sh`
- powerline font might be needed at your client : https://github.com/powerline/fonts

### Modern Neovim Features

- **LSP 지원**: Mason을 통한 자동 LSP 서버 설치 및 관리
- **파일 탐색기**: nvim-tree.lua (NERDTree 대체)
  - `F1`: 파일 트리 토글
  - `F5`: 파일 트리 새로고침 
  - `,e`: 파일 트리에 포커스
  - `,fc`: 현재 파일을 트리에서 찾기
  - Git 상태 표시 및 자동 리프레시
- **자동완성**: nvim-cmp (LSP 기반)
- **구문 강조**: Treesitter (더 정확한 구문 분석)
- **린터/포매터**: none-ls (null-ls 후속)
- **버퍼 관리**: bufferline.nvim (탭 스타일 버퍼)
- **상태바**: lualine.nvim (가벼운 모던 상태바)

### Help

# Iterm-2 setup

- Using Iterm2, show server name on tabe.
- Disable all  `Iterm2 > Preferences > Appearance > Window & Tab Titles`
- include this code in zshrc:
```
DISABLE_AUTO_TITLE="true"
echo -ne "\e]1;serverName\a"
```

## Install autojump

```
git clone git://github.com/wting/autojump.git
cd autojump
./install.py or ./uninstall.py

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
