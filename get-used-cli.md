footer: © Junho Cho, 2016
slidenumbers: true

# [fit] Get Used to
# [fit] **C**ommand **L**ine **I**nterface

![bg](http://i.giphy.com/26AHKGvq2zAJmfDj2.gif)

###### Created by [@junhocho](https://github.com/junhocho)


---

# Hey, isn't **GUI** is enough?
![fit left](https://www.kullabs.com/uploads/gui1.png)


---

# [fit] Well,
![fit right](http://i.giphy.com/4sM16dIFEQpi0.gif)

---
# [fit] satisfied?
![fit left](https://www.teamviewer.com/resources/images/screenshots/win-mainwindow.png)

---

# CLI
### ( Tmux + VIM )
![](http://www.tmerse.com/images/awesome-tmux.gif)

---

# [fit] Why CLI?

# [fit] Portable. Simple. Automated. and **Cool**

![right bg](https://media.giphy.com/media/l3vR3gvEdsdJl26oU/source.gif)

---

### You own **servers**
### You have **mac** ~~Kakaotalk~~
### You are **lazy**
### You are a **blogger**
### You are a **computer geek**


![left](http://i.giphy.com/26AHM8fwpxlAWJdGE.gif)

---

# [fit] Try CLI
![right](http://i.giphy.com/26AHPxxnSw1L9T1rW.gif)


---



## [fit] This presentation are inspired by [@nicknisi](https://github.com/nicknisi/vim-workshop)

### [youtube link](https://www.youtube.com/watch?v=5r6yzFEXajQ)
![](http://nicknisi.com/images/beef_nick.png)

---
# Coverage

1. Ubuntu14.04 (The OS)
2. Vim	(The editor)
3. Tmux (The workspace)

# [fit] [dotfiles link](https://github.com/junhocho/junhosetting) : `https://github.com/junhocho/junhosetting`


---

![bg 60%](https://www.webssh.net/common/frontend/img/placeholders/com_itimeteo_webssh.png)

# Let's start
# with **SSH**

---

# [fit] SSH : Secure Shell

**Secure connection to server**

## [fit] Host(server) IP : **`147.46.89.175`**
## [fit] User ID	: **`bctjv-[yourname]`**
## [fit] password : **`bctjv`**

---

# Login !

## [fit] Linux/macOS : `ssh bctjv-[yourname]@147.46.89.175`

![fit](https://dl.dropboxusercontent.com/s/yc6412danz44wfe/08204CDE-BFC8-472B-BF52-4CC7C7729D34-51476-0001651648007179.gif)

---

### Windows : use [putty](http://www.putty.org)
![right fit](http://screenshots.en.sftcdn.net/en/scrn/20000/20678/putty-7.jpg)

---

# [fit] This actually needs


## [fit] `sudo apt-get install openssh-server`

# [fit] OpenSSH installed at your **SERVER**

---

# [fit] and Actually you don't need password either.
# [fit] make password key and keep it !
# [ref](https://dobest.io/ssh-without-password/)

![bg](http://i.giphy.com/4VGsPgKbt8WXu.gif)

---

# Ubuntu14.04 (Linux)

![right](http://design.ubuntu.com/wp-content/uploads/logo-ubuntu_st_no®-black_orange-hex.png)

- One of Linux
- Commonly used in Deep Learning libraries
- [link about Directories  : tmp, root, var, usr, home, bin](http://webdir.tistory.com/101 )

---

# Simple commands

`mv` , `cp` , `rm` , `mkdir` , `rmdir`
`ls -lh`, `df -lh`, `du -sh ./*`, `whoami`
`cp *.py /path/to/dest/`
`rm -rf /다/지워/버리겠다/*.txt`
`sudo apt-get install tmux`

[funny commands](http://www.tecmint.com/20-funny-commands-of-linux-or-linux-is-fun-in-terminal/)

---
# [fit] **Try**
# `cowsay`

![left fit](https://www.dropbox.com/s/q3x64a5qa435hn3/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202016-11-08%2000.55.50.png?raw=1)

# `cmatrix`

---

# Some Signals
```bash
# ==== Ex1) ====
$ yes yell!
<C-c>   # Control - c. Interrupt!
# ==== Ex2) ====
$ python -c '
c = 0
while True: print c; c= c+1'

<C-z>   : stop for the moment and backgorund!
$ fg  # back on foreground
# ==== Ex 3) ====
$ python
<C-d>  # exit
```



---

# Concept

- directory and file / [permission, ownership](http://brothernsister.tistory.com/27)

# ![fit inline 100%](https://www.dropbox.com/s/kyqn1svnox8dtok/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202016-11-09%2020.46.06.png?raw=1)

^`Workspace` : `drwxrwxr-x` : directory and has 775 permision
`.zshrc` : `-rw-r--r--` : file and has 644 permision
`hello.py` : `-rwxr-xr--` : file and has 754 permision

---

## [fit] change permssion : `$ chmod 755 hello.py`
## [fit] change ownership : `$ chown userid hello.py`

### [fit] `sudo command` : borrow sudo privilege and command

## Do not abuse sudo 👎

^permission이 없는 것은 sudo 명령어로 해결가능.
하지만 함부로 사용 No
linux를 root 계정을 사용하는 것은 안전하지 않음.
 보통 모든 유저에게 sudo 권한을 주진 않음.

---    
# Shell

- Default shell is `bash shell`
- `bash shell` made in 1989 which is pretty _uncomfortable_.

# [fit] Use `zsh`
- manage zsh with http://ohmyz.sh

![right](http://i.giphy.com/bmeGvNXq71kGs.gif)

---
# Why ZSH?

1. smart autocomplete
2. highly customizable
3. Bundled functions, helpers, plugin, themes : ex) git

![fit](http://1.bp.blogspot.com/-0aOrH7uBrYM/UGaLvh3uCzI/AAAAAAAABgg/JFFpU5Ym8Cw/s1600/Screen%2BShot%2B2012-09-29%2Bat%2B12.36.34%2BAM.png)

---
# [fit] Install zsh

```bash
sudo apt-get install git # git is very essential. Source code repositories
sudo apt-get install zsh # Already installed in our case
cd # move to home folder
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # install
sudo chsh -s /usr/bin/zsh [your-id] # change your default shell into zsh
```
# [fit] *Easy?*

---
# [fit] Let's do some more tweak!
# Then, git clone `Junhosetting` first

```bash
cd # move to home folder
git clone https://github.com/junhocho/junhosetting #Star it
cd junhosetting
vi install.txt  # peek vim
```

---

# Hey, **Vim** user
### **Vim** : improved Vi.

```
1 # Zsh setup
2 zsh autojump - https://github.com/wting/autojump.git
3 zsh syntax highlighting - https://github.com/zsh-users/zsh-syntax-highlighting.git
4  
5
6 #alias-tips
7 $ cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins            # 커스텀 플러그인 폴더로 이동
8 $ git clone https://github.com/djui/alias-tips.git  # 저장소를 로컬로 복사
9 $ $EDITOR ~/.zshrc                                  # 에디터로 파일을 에디터로 불러들임
10 plugins=(git ... alias-tips) 추가
11 ...
 ```
---

# Let's do some more **tweak**.

### 1. [ZSH syntax highlight](https://github.com/zsh-users/zsh-syntax-highlighting.git)

### 2. [autojump](https://github.com/wting/autojump.git)

*Vim quit?* ~~[Alt F4]~~

```
:q 		# vim quit
:wq		# save and quit. identical to <shift-ZZ>
```

---

# Zsh highlighting install

```bash
cd
# get source of zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# put codes in .zshrc
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
# activate it now
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# this refreshes your .zshrc modofication to your current environment
source ~/.zshrc # dotfiles locate in home folder
```
### [fit] It highlights if your command is valid

### Do **Autojump** by yourself

---

# [fit] some more useful commands

```bash
ls . | wc -l                        # how many files in this directory.
du -sh ./*                          # how big are folders and files in this directory
df -lh                              # list my Filesystem in human readable format
ln -s [target-folder] [make-link]   # make symbolic link
grep -nr --color "keyword-to-find" * # locate "keyword-to-find"

unzip some.zip                      # unzip
tar -xvf some.tar.gz                # untar
echo $CUDA_HOME                     # print some environment variable
wget https://goo.gl/ka7Yz5          # download file in web
wget http://www.ekn.kr/data/photos/20150938/art_1442387799.jpg # Download jpg image
python print-experiment-output.py 2>&1 | tee experiment.log # Store all print output in experiment.log
which python                        # useful to locate command

history                             # my command history
pstree                              # process tree
htop                                # system monitoring
nvidia-smi                          # gpu monitoring
who                                 # which users are online?
```

---

# [fit] [Alias](https://github.com/junhocho/junhosetting/blob/master/alias)

- Be more lazy.

## [fit] You don't have time to type : `grep -nr --color "keyword-to-find" *`

- put your alias at the end of `.zshrc`

```bash
cd
cat junhosetting/alias >> ~/.zshrc # Copy paste alias to end of .zshrc
tail ~/.zshrc # print some lines of the end of .zshrc
source ~/.zshrc # refresh this environment

grepn "key-word-to-find" * # Check the alias working
```

---

## Port

### [fit] Well know ports : `22 : SSH` / `80 : HTTP` / `3389 : Window rdp` ...

# [fit] [Portforward](https://github.com/junhocho/junhosetting/blob/master/portforward) from CLIENT to SERVER : `ssh -L localhost:$2:localhost:$2 $1`

```bash
# Ex) Do this at SERVER.
Jupyter notebook --no-browser --port 8888 # random ports 8888
# Do this at CLIENT
ssh -L localhost:8888:localhost:8888 junho@147.46.89.175
# Open web-browser in CLIENT and connect to `localhost:8888`
```
[VNC (GUI)](http://tmmse.xyz/vnc-setup/) :  Use GUI safely with SSH


---
# [fit] Web-server
```bash
# Do this at SERVER
python -m SimpleHTTPServer 8888 # Open temporary web-server in 8888
# Open web-browser in CLIENT and connect to 147.46.89.175:8888
```

---

# [fit] **SCP:** Move file between client and Server
## use it in CLIENT (unix) terminal.
## because Client : 유동 ip / Server : 고정 ip
```bash
scp /client/A host:~/path/dest/B
# Client의 파일 A를 host의 경로 B로 옮긴다.
scp host:~/path/dest/A /client/B
# Host의 파일 A를 Client의 B로 옮긴다.
scp -r junho@147.46.89.175:~/Downloads/WordCount ~/Workspace/
# -r 은 재귀적으로. 서버의 WordCount 디렉토리와 안의
# 모든 파일을 내 client의 Workspace의 복사
```
---

# [fit] Windows?

# WinSCP

![fit right](https://winscp.net/pad/screenshot.png)

---

# [fit] [`imgcat`](https://www.iterm2.com/index.html)
## only for macOS iterm2
![bg](http://shipyardbooks.com/imgs/posts/command-line-images.png)


---

# Killing Process

```bash
$ python -c '
c = 0
while True: print c; c= c+1'

<C-z> # go to sleep and background.
$ ps aux | grep python # print process that contains `python`
```
![inline](https://www.dropbox.com/s/6iot6o239wp10z6/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202016-11-08%2001.46.20.png?raw=1)

**`kill -9 [process-id]`** : 356 in this case

process killed!


---


# [fit] Any more questions?

![right](http://i.giphy.com/xT5LMEYx5AZwu4oiac.gif)

---

# 2. Vim

![](http://www.unixstickers.com/image/cache/data/stickers/vim/vim.sh-600x600.png)

---

# IDE?
# [fit] Visua Studio , Eclipse, Webstorm, Android studio, Pycharm, ZeroBaneStudio
![bg](http://cdn03.androidauthority.net/wp-content/uploads/2015/08/ASFeaturedPic.png)

---

# [fit] :heart: ~~IDE~~ Vim
# [fit] You don't have choice but to love VIM in SSH.

---

# [fit] Vim
![right fit](https://dl.dropboxusercontent.com/u/51664086/27EF2BE6261C6D4931DBBF5B6123A304.png)

- Vim : improved Vi.
- probably already installed in your system
- Highly customizable
- setting file : [.vimrc](https://github.com/junhocho/junhosetting/blob/master/vimrc#L19)

---

# [fit] Modal editing

![](http://d.pr/i/15nA1+)

---

# [fit] Modal Editing

* Normal - navigate the structure of the file `<esc>`
* Insert - editing the file `i, o, a, s, ...`
* Visual - highlight portions of the file to manipulate at once `v, shift-v, ctrl-v`
* Ex - command mode `:, /, ?`

---

# Don't use mouse!  :mouse:

## [fit] now all upper/lower alphabet differs
![left](http://i.giphy.com/3o7WTJn8VVkJDdSyB2.gif)

---

### [fit] `h j k l`

### [fit] ⬅️ ⬇️ ⬆️ ➡️

---


# [fit] `12j`
# [fit] move down 12 tiems, numbers affect

---
* `:29` : move to line 29
* `:set number` : show line numbers
* `:set nonumber` : `no` usually the opposite of command


---

* `^e` - scroll the window down
* `^y` - scroll the window up
* `^f` - scroll down one page
* `^b` - scroll up one page
* `H` - move cursor to the top of the window
* `M` - move cursor to the middle of the window
* `L` - move cursor to the bottom of the window

---

* `zz` : move window so that my cursor is at center
* `u` : undo
* `^r` : redo
* `:w` : save
* `:q` : quit
* `:wq` : save and quit

---

* `gg` - go to top of file
* `G` - go to bottom of file

# [fit] text objects

* `w` - words
* `s` - sentences
* `p` - paragraphs

---

# [fit] Motions

* `a`- all
* `i` - in
* `t` - 'til
* `f` - find forward
* `F` - find backward

---

# [fit] Commands

* `d` - delete (also cut)
* `c` - change (delete, then place in insert mode)
* `y` - yank (copy)
* `v` - visually select

---

# [fit] `{command}{text object or motion}`

---

# [fit] `diw`
## [fit] delete in word

---

# [fit] `caw`
## [fit] change all word

---

# [fit] `yi)`
## [fit] yank all text inside parentheses

---

# [fit] `va"`
## [fit] visually select all inside doublequotes
## Including doublequotes

---

# [fit] `^v 4j I # <esc>`
### [fit] visually select column 4 down lines and enter insert mode to write `#`
## [fit] commenting multiple lines with `#`

![right fit](https://dl.dropboxusercontent.com/s/97wlhor0ox6w5ue/043712AF-5A80-4C7E-8BB0-DA17AD444E66-51476-0001B9C057AF9542.gif?raw=1)

---

# [fit] Repetition
## [fit] The DOT command
### `.`

---

# [fit] Repeat the last command

![](http://media.giphy.com/media/3rgXBCsCWGS82uYKiI/giphy.gif)

---

# [fit] that's it

---

# [fit] but it's powerful

![](http://www.jeffbullas.com/wp-content/uploads/2013/12/9-Simple-and-Powerful-Ways-to-Get-More-Retweets-on-Twitter-Report-.jpg)

---

# [fit] Additional commands

* `dd` / `yy` - delete/yank the current line
* `D` / `C` - delete/change until end of line
* `^` / `$` - move to the beginning/end of line
* `I` / `A` - move to the beginning/end of line and insert
* `o` / `O` - insert new line above/below current line and insert




---

# [fit] Additional commands
* `J` - delete line break. pretty useful
* `p` - paste
* `*` on word - find all this words.
* `^a` on number - increment

---

# [fit] Try and make actions repeatable
## [fit] Practice it

---

# [fit] Not everything is repeatable

## [fit] at least with the DOT command

---

# [fit] MACROS
![](http://media.giphy.com/media/Vm6YGB3Ng8lnW/giphy.gif)

---

# [fit] Macro
## [fit] A sequence of commands recorded to a register

---

## Record a macro

* `q{register}`
* (do the things)
* `q`

## Play a macro

* `@{register}`

![left](http://media.giphy.com/media/2F0IsIg0lHveE/giphy.gif)

---

* `mk` : mark position at `k`
 ```
  `k : move cursor to position k
  ```

---

## Ex mode

- `/someword` : find `someword`
- `:spl` / `:vspl` : split (horizontal or vertical) vim pane
- `^w + w/arrow` : move pane in vim
-  : vertical split pane
- `:e.` : file tree
- `:%s/foo/bar/g` : replace all `foo` to `bar`

---

- `:syntax on` : syntax on
- `:set paste` : paste mode. Useful when using vim `indent` option
- `:set cursorline` : show cursor with underline

### [fit] Let's put those useful Options
### [fit] as basic setting.

---

# [fit] get into junhosetting once again

```bash
cp ~/junhosetting/vimrc ~/.vimrc
```

---

# [fit] Plugins

---

# Plugins : install what you need

* [vundle](https://github.com/gmarik/vundle) - plugin manager
* [nerdtree](https://github.com/scrooloose/nerdtree) - file drawer
* [ctrlp](https://github.com/kien/ctrlp.vim) - fuzzy file finder
* [fugitive](https://github.com/tpope/vim-fugitive) - git tool
* [syntastic](https://github.com/scrooloose/syntastic) - syntax checker / linter

---

# [fit] But My IDE does more
![](http://www.hollywoodreporter.com/sites/default/files/imagecache/thumbnail_570x321/2012/04/dawson_crying.jpg)

---

# [fit] Vim is extemely **customizable**
## [fit] Plugins tailor vim to your needs

---

# [fit] But we can still do more

---

![original](http://d.pr/i/R5c+)
### Not an IDE
### It's **VIM**

---
# [fit] Install Vundle with plugins
```bash
cd
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# clone in ~/.vim/bundle/ and setup your vimrc with plugins
vi # then do :PluginInstall
# Test :NERDTree with <F2> in vim
# Test if autocomplete works
```

![right 80%](https://www.dropbox.com/s/w61ntwzc452e0ia/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202016-11-10%2002.49.25.png?raw=1)

---

# [fit] **executables**  

Write on top of script
`#!bin/bash` if shell script,
`#!bin/usr/python` if python script.
**`chmod +x script`**

### [fit] then the script is executable as **`$ ./script`**

---

# [fit] ctags
# [fit] Source code inspection

```bash
sudo apt-get install ctags
cd your-project
ctags -R . # will produce `tags` in the folder
vi code.cpp
< C - t > # to go inside declration
< C - ] > # to go back
```


---

#  3. Tmux
# [fit] Terminal Multiplexer


---

# [fit] vim + tmux

![](http://d.pr/i/R5c+)

---

### [fit] Why Tmux?
- Don't want to stop your SSH session.
  1. Experiment session
  2. Downloading big file
  3. web-server

---

- Extendable Workspace
- And Maintain your session
- Co-operation


---

```bash
tmux new -s [session-name]	  # create new session
tmux ls                       # list existing session
tmux attch -t [session-name]	# attach existing session
```

---

`tmux new -s py-practice`

---

# [fit] **`<C-b>`** : Tmux binding-key.
- will change it to **`<C-a>`** unless you have flexible finger bone

# [fit] `<C-b> c` , **`bind c`** : New window
# [fit] **`bind d`** : dettach from working session

---

# [fit] Let's configure Tmux.

 - [ref1](http://www.haruair.com/blog/2124), [ref2](https://blog.outsider.ne.kr/699)
 - [.tmux.conf](https://github.com/junhocho/junhosetting/blob/master/tmux.conf)

```bash
cp ~/junhosetting/tmux.conf ~/.tmux.conf  #  dotfile로 이름바꿔서 복붙
tmux source .tmux.conf    # If you have working tmux session
# Now your Tmux looks better and <C-a> is the binding-key
```

---

**`tmux new -s [session-name]`**

`bind c` : new window
`bind n` : Next window
`bind p` : Previous window
`bind %` : vertical split pane
`bind "` : horizontal split pane
`bind h(jkl, arrow)` : move my cursor pane to pane
`bind [` : copy-mode / `q` : copy-mode exit
`exit` / `<C-d>` : quit pane

---

# [fit] There's a lot that tmux can do

---

# [fit] Synchronize-panes
# [fit] `bind :setw synchronize-panes`

![fit](http://d.pr/i/vRVt+)

---

# [fit] Create splits on the fly
# [fit] `bind %` and `bind "`

![fit](http://d.pr/i/12gE5+)

---

# [fit] Have flexible workspace

![fit](https://dl.dropboxusercontent.com/s/du4ewaeyy53kz6t/ECB46A4D-C8EE-41EE-90BC-047E8D41E0B5-51476-0001BF2D78337540.gif?raw=1)

---

# [fit] tmux + vim = :heart:

---

# [fit] linux + GIT + tmux + vim = :heart:

---

# [fit] Learn your editor well
## [fit] \(even if it's not vim\)

---

# [fit] Don't copy someone else's configuration
## [fit] Make it your own

---

# [fit] Setup all configuration

```bash
./setup-all.sh  # Do all the configuration we did today.  Read it!
```

# [fit]  in one step!

---

# [fit] But share your configuration
![](http://i.giphy.com/l3V0Ctx2EveOxwCaI.gif)

---

# [fit] dotfiles

* Share your configuration
* Steal ideas from others
* [junhocho/dotfiles](https://github.com/junhocho/junhosetting)

### Others
* [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles)
* [bryanforbes/dotfiles](https://github.com/bryanforbes/dotfiles)
* [jason0x43/dotfiles](https://github.com/jason0x43/dotfiles)

![left](http://i.giphy.com/26AHE9qfBhoMYiZi0.gif)

---

# [fit] Keep practicing

---

# [fit] :heart:

dotfiles and materials available at [@junhocho](https://github.com/junhocho/junhosetting)[^*]

[^*]: Inspired from [@nicknisi](https://github.com/nicknisi/vim-workshop)

