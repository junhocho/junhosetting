" vimrc
" Author: Junho Cho [junhocho@snu.ac.kr]
" 2016/09/30 updated
:set vb
:set noeb vb t_vb=

set nocompatible
filetype on
filetype off


" EnCoding
set enc=UTF-8
set fileencodings=UTF-8
set fencs=utf8,euc-kr,cp949,cp932,euc-jp,shift-jis,big5,latin1,ucs-2le
set visualbell
set backspace=indent,eol,start
set statusline=%h%F%m%r%=[%l:%c(%p%%)]
set tabstop=4
set shiftwidth=4
set cindent
set autoindent
set smartindent
"filetype indent on
set history=15
set ruler
set showcmd
set nobackup
set foldmethod=marker
set hlsearch
set background=dark
set number
nnoremap <C-l> :set nonumber!<CR>
set visualbell
set noswapfile
set cursorline 
"set paste!                         "Use when Paste sth
set tags=~/caffe_sal/tags
"set tags+=~/py-faster-rcnn/tags
set laststatus=2

"Prevent freezing vim without tmux
set noeb vb t_vb=

"Ctirl.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
let g:ctrlp_working_path_mode = 'r'

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

syntax on

map <F1> <ESC>:Tlist<CR>
"map <F2> <ESC>:NERDTree<CR>
nnoremap <silent> <special> <F2> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>

map <F3> <ESC>:w<CR>
map <F4> <ESC>:wq<CR>

map <F6> <ESC>:vs<CR>
map <F7> <ESC>:sp<CR>
map <F8> <ESC>:new<CR>
map <F9> <ESC>:close<CR>
map <C-TAB> <C-p>

"ctags
map <C-}> :exec("tag /".expand("<cword>"))<CR>  
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>  
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

let mapleader=","
let python_highlight_all = 1

" Vundle
set nocompatible              " be iMproved
filetype on
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails.git'
" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
" non-GitHub repos
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'The-NERD-tree'

Plugin 'Source-Explorer-srcexpl.vim'
Plugin 'pyflakes'
Plugin 'Python-Syntax'
" Bundle 'Valloric/YouCompleteMe'
Plugin 'AutoComplPop'
Plugin 'nathanaelkane/vim-indent-guides'

" Syntastic
Plugin 'vim-syntastic/syntastic.git'

" airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()             " required
filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
