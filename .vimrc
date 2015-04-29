if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif


"---------------------------------------------------------------------------
"general option
"---------------------------------------------------------------------------
"general options {{{
set number
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

set ruler
set history=1000
"set autoindent
set smartindent
set showmode

set backspace=2
set wrapscan
set showmatch

set wildmenu

set laststatus=2
set cmdheight=1
set showcmd
set title
set nobackup	" do not keep a backup file, use versions instead

set foldmethod=marker

"set term=xterm_color
"set term=beos-ansi
" }}}
"search {{{
set incsearch
set ignorecase
set smartcase
" }}}
"encod, japanese {{{
set encoding=utf-8
set termencoding=utf8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp
"}}}



"---------------------------------------------------------------------------
"plugin load   //Neobundle
"---------------------------------------------------------------------------
filetype off
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"unite and more {{{
NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

"}}}
"util {{{
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdtree'
"}}}
"editor {{{
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'terryma/vim-multiple-cursors'
"}}}
"colorschemes {{{
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tomasr/molokai'
"NeoBundle 'sickill/vim-monokai'
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'cocopon/iceberg.vim'
"NeoBundle 'nanotech/jellybeans.vim'
"}}}
call neobundle#end()
filetype plugin indent on
NeoBundleCheck



"---------------------------------------------------------------------------
"plugin setting
"---------------------------------------------------------------------------
" unite {{{
let g:unite_enable_start_insert=1
"let g:unite_source_history_yank_enable = 1
"let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
"call unite#filters#matcher_default#use(['matcher_fuzzy'])

nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
autocmd FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
autocmd FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
autocmd FileType unite nmap <silent> <buffer> <ESC><ESC> q
autocmd FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q

nnoremap <space><space> :<C-u>Unite file_rec/async<CR>

" }}}
" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}
" ctags {{{
let g:auto_ctags = 1
nnoremap <C-]> g<C-]>
" }}}
" ag {{{
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif
" }}}
" neocomplete {{{
if has('lua')
    NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ 'depends' : 'Shougo/vimproc',
        \ 'autoload' : { 'insert' : 1,}
        \ }
endif
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}
" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
"hi EasyMotionTarget guifg=#80a0ff ctermfg=81
" }}}
"quickrun {{{
let g:quickrun_config={'_': {'split': ':botright', 'close_on_empty': 1, 'into' : 1,}}
"let g:quickrun_config={'_': {'split': 'vertical'}}
"let g:quickrun_config={'_': {'split': ':botright', 'close_on_empty': 1,"outputter/buffer/into" : 1,}}
"let g:quickrun_config={'_': {'split': '', 'close_on_empty': 1}}
"nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
"}}}
"nerdtree {{{
nnoremap <silent><C-n><C-n> :NERDTreeToggle<CR>
"}}}
"easyalign {{{
vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}



"---------------------------------------------------------------------------
"color
"---------------------------------------------------------------------------
"curorline {{{
set cursorline
autocmd ColorScheme * highlight CursorLine cterm=underline
"autocmd FileType unite highlight CursorLine cterm=underline ctermbg=200
"autocmd ColorScheme * highlight Comment ctermfg=59
"}}}
"whitespace {{{
" Two-byte space
autocmd ColorScheme * hi link TwoByteSpace Error
autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '　')"
" Unite 
let g:extra_whitespace_ignored_filetypes = ['unite']

"}}}
"colorscheme {{{
colorscheme molokai
"set background=dark
"colorscheme solarized
"colorscheme hybrid
"let g:molokai_original = 1
"highlight Normal ctermbg=none
"}}}
"80col line {{{
if (exists('+colorcolumn'))
    "set colorcolumn=80
    "highlight ColorColumn ctermbg=9
endif
"}}}



"---------------------------------------------------------------------------
"other
"---------------------------------------------------------------------------
imap echo<TAB> <?php echo  ?><ESC>hhi
imap foreach<TAB> <?php foreach(): ?><?php endforeach ?><ESC>bbbhhi<Enter><Enter><ESC>ka<TAB>
imap php<TAB> <?php ?><ESC>hh
imap phpif<TAB> <?php if(): ?><?php endif ?><ESC>bbbhhi<Enter><Enter><ESC>kkwww
imap prr<TAB> print_r();<ESC>hi
imap vard<TAB> var_dump();<ESC>hi



