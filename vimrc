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

"=== Ctirl.vim ===================
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
" 가장 가까운 .git 디렉토리를 cwd(현재 작업 디렉토리)로 사용
" 버전 관리를 사용하는 프로젝트를 할 때 꽤 적절하다.
" .svn, .hg, .bzr도 지원한다.
let g:ctrlp_working_path_mode = 'r'

" 단축키를 리더 키로 대체
nmap <leader>p :CtrlP<cr>

" 여러 모드를 위한 단축키
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>



"=== airline ===============
let g:airline#extensions#tabline#enabled = 1 "buffer list
let g:airline#extensions#tabline#fnamemod = ':t' "buffer file name print only
let g:airline_powerline_fonts = 1 "able powerline font. disable if font breaks. Or install powerline-patch


" BUFFER : this concept is heavily inspired from
" http://bakyeono.net/post/2015-08-13-vim-tab-madness-translate.html
" 이 옵션은 버퍼를 수정한 직후 버퍼를 감춰지도록 한다.
" 이 방법으로 버퍼를 사용하려면 거의 필수다.
set hidden

" 버퍼 새로 열기
" 원래 이 단축키로 바인딩해 두었던 :tabnew를 대체한다.
nmap <leader>T :enew<cr>

" 다음 버퍼로 이동
nmap <leader>l :bnext<CR>

" 이전 버퍼로 이동
nmap <leader>h :bprevious<CR>

" 현재 버퍼를 닫고 이전 버퍼로 이동
" 탭 닫기 단축키를 대체한다.
nmap <leader>bq :bp <BAR> bd #<CR>

" 모든 버퍼와 각 버퍼 상태 출력
nmap <leader>bl :ls<CR>

syntax on

map <F1> <ESC>:TagbarToggle<CR>
"map <F2> <ESC>:NERDTree<CR>
nnoremap <silent> <special> <F2> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>

map <F3> <ESC>:w<CR>
map <F4> <ESC>:wq<CR>
" remove white spaces : trailing
map <F5> <ESC>:%s/\s\+$//e<CR>
map <F6> <ESC>:vs<CR>
map <F7> <ESC>:sp<CR>
"map <F8> <ESC>:new<CR>
nmap <F8> :SrcExplToggle<CR>

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

"set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle
" required!
"Plugin 'gmarik/vundle'
Plug 'tpope/vim-fugitive'
"Plugin 'Lokaltog/vim-easymotion'  : not necessary to me
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
"Plugin 'tpope/vim-rails.git'
" vim-scripts repos
Plug 'L9'
"Plugin 'FuzzyFinder' --> Use CtrlP instead
" non-GitHub repos
"Plugin 'git://git.wincent.com/command-t.git' --> Use CtrlP
"Plugin 'vim-ruby/vim-ruby'
Plug 'The-NERD-tree'

"Plugin 'Source-Explorer-srcexpl.vim'
Plug 'wesleyche/SrcExpl'
"Plugin 'pyflakes'
Plug 'Python-Syntax'
" Bundle 'Valloric/YouCompleteMe'
Plug 'AutoComplPop'
Plug 'nathanaelkane/vim-indent-guides'

" Syntastic
"Plugin 'vim-syntastic/syntastic.git' old
Plug 'scrooloose/syntastic'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"more airline compatible plugins
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'

" Tagbar
" git clone git://github.com/majutsushi/tagbar ~/.vim/bundle/tagbar
Plug 'Tagbar'

" Lua plugins
" git clone https://github.com/tbastos/vim-lua.git ~/.vim/bundle/vim-lua
Plug 'tbastos/vim-lua'


call plug#end()             " required
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
