" vimrc
" Author: Junho Cho [junhocho@snu.ac.kr]
" 2016/09/30 updated
" :set vb
set noeb vb t_vb=

" === Junho custom mapping
let mapleader = ","
" Split line
nnoremap L i<CR><Esc>
nnoremap <C-l> :set nonumber!<CR>
nnoremap <C-i> :IndentLinesToggle<CR>
:tnoremap <Esc> <C-\><C-n>
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

" Default shell as zsh
" set shell="zsh -l"
"set shell=/bin/zs

set nocompatible
filetype on
filetype off

"=== NEOVIM ===
"smooth scrolling : http://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
set lazyredraw
set synmaxcol=128
syntax sync minlines=256
set mouse=a

"=== MACVIM ===
set guifont=Source\ Code\ Pro\ For\ Powerline:h14
set guicursor=
"Fix bug of weird character on tmux after neovim
"https://github.com/neovim/neovim/wiki/FAQ#nvim-shows-weird-symbols-2-q-when-changing-modes

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
set noswapfile
" set cursorline
set visualbell
set wildmenu
"set paste!                         "Use when Paste sth
"set tags=~/caffe_sal/tags
"set tags+=~/py-faster-rcnn/tags
set laststatus=2
syntax on

"Prevent freezing vim without tmux
" set noeb vb t_vb=


"=== Ctirl.vim ===================
set runtimepath^=~/.vim/plugged/ctrlp.vim
let g:ctrlp_show_hidden = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll|png|jpg)$'
  \ }
" 가장 가까운 .git 디렉토리를 cwd(현재 작업 디렉토리)로 사용
" 버전 관리를 사용하는 프로젝트를 할 때 꽤 적절하다.
" .svn, .hg, .bzr도 지원한다.
let g:ctrlp_working_path_mode = 'r'
" Too slow ctrlp: https://stackoverflow.com/questions/21346068/slow-performance-on-ctrlp-it-doesnt-work-to-ignore-some-folders
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_clear_cache_on_exit = 0

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


"===  BUFFER : this concept is heavily inspired from
" http://bakyeono.net/post/2015-08-13-vim-tab-madness-translate.html
" 이 옵션은 버퍼를 수정한 직후 버퍼를 감춰지도록 한다.
" 이 방법으로 버퍼를 사용하려면 거의 필수다.
set hidden
" 버퍼 새로 열기
" 원래 이 단축키로 바인딩해 두었던 :tabnew를 대체한다.
nmap <leader>T :enew<cr>
" 다음 버퍼로 이동
nmap <leader>' :bnext<CR>
" 이전 버퍼로 이동
nmap <leader>; :bprevious<CR>
" 현재 버퍼를 닫고 이전 버퍼로 이동
" 탭 닫기 단축키를 대체한다.
nmap <leader>bq :bp <BAR> bd #<CR>
" 모든 버퍼와 각 버퍼 상태 출력
nmap <leader>bl :ls<CR>


" === Function keys mapping ===
"map <F2> <ESC>:NERDTree<CR>
nnoremap <silent> <special> <F1> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>
" Quick Save
map <F3> <ESC>:w<CR>
" inoremap <C-s> <C-o>:w<ESC><CR>
" inoremap <C-s> <ESC>:w<ESC><CR>a
:imap <c-s> <ESC>:w<CR>
:map <c-s> <Esc>:w<CR>
:imap <c-q> <ESC>:q<CR>
:map <c-q> <Esc>:q<CR>

" remove white spaces : trailing
map <F4> <ESC>:%s/\s\+$//e<CR>
map <F5> <ESC>:edit<CR>
imap <C-5> <ESC>:edit<CR>
map <F6> <ESC>:vs<CR>
map <F7> <ESC>:sp<CR>
"map <F8> <ESC>:new<CR>
nmap <F8> <ESC>:SrcExplToggle<CR>
:map <F9> <ESC>:TagbarToggle<CR>
"map <F9> <ESC>:close<CR>
"
map <C-TAB> <C-p>


"=== ctags ===
map <C-}> :exec("tag /".expand("<cword>"))<CR>
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


"===  Auto-paris ===
"let g:AutoPairsFlyMode = 0
"let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
"let g:AutoPairsShortcutToggle = '<M-p>'
let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsShortcutBackInsert = '<C-b>'
let g:AutoPairsShortcutJump = '<C-n>'

"=== Syntastic Setting ===
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>


"============= PLUG ===============
call plug#begin('~/.vim/plugged')

" Git
Plug 'airblade/vim-gitgutter' "Shows git diff
Plug 'tpope/vim-fugitive' "Git wrapper in vim

" Easier browsing through vim
Plug 'scrooloose/nerdtree'
Plug 'wesleyche/SrcExpl'
Plug 'majutsushi/tagbar' " Tagbar
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'gikmx/ctrlp-obsession' "Session navigator using vim-obsession/vim-prosession

" Easy Editting
Plug 'maralla/completor.vim' " Autocompl
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jiangmiao/auto-pairs' " Auto Pairs : parenthesis
Plug 'mbbill/undotree' "Undotree
Plug 'tpope/vim-commentary' "Comment with gcc and gc
Plug 'Yggdroot/indentLine'

" Visualize
Plug 'jacquesbh/vim-showmarks' "Show marks
Plug 'scrooloose/syntastic' " Syntastic
Plug 'junegunn/seoul256.vim' "Theme
Plug 'vim-airline/vim-airline' " airline
Plug 'vim-airline/vim-airline-themes'

" Language
" if not working :IPython, try :UpdateRemotePlugins and restart nvim
Plug 'hkupty/iron.nvim' "Ipython
Plug 'tbastos/vim-lua' " Lua plugins
"Plug 'hdima/python-syntax' "Python
" Plug 'junhocho/python-syntax'
Plug 'Yggdroot/indentLine'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Markdown
" Plug 'plasticboy/vim-markdown'
" Plug 'JamshedVesuna/vim-markdown-preview'


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
" ============================================================================


" " Python syntax
" let python_highlight_all = 1


"=== ShowMarks ====
nnoremap <leader>m :DoShowMarks<CR>
nnoremap dm :execute 'delmarks '.nr2char(getchar())<cr>

" ctrlp-obsession : for ctrlp vim sessions
nnoremap <leader>ss :CtrlPObsession<CR>

"===  undotree ===
if has("persistent_undo")
	set undodir=~/.vim/.undodir/
	set undofile
endif
nnoremap <leader>ut :UndotreeToggle<CR>:UndotreeFocus<CR>

"=== Markdown preview requirement. Also `pip install grip`
let vim_markdown_preview_github=1


"=== Theme ===
let g:seoul256_background = 235
colo seoul256
