set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
execute pathogen#infect()

" => General"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
"}}}

" => VIM user interface"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" No tabline pls
set showtabline=0

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" 15 tabs maximum
set tabpagemax=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

"completion options
set completeopt=longest,menuone

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500"

"-----BEGIN Save/Restore Window Size/Position - autooad/screensize.vim-----
if has("gui_running")
    if !exists('g:screen_size_restore_pos')
        let g:screen_size_restore_pos = 1
    endif
    if !exists('g:screen_size_by_vim_instance')
        let g:screen_size_by_vim_instance = 1
    endif
    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call screensize#ScreenRestore() | endif
    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call screensize#ScreenSave() | endif
endif
"-----END Save/Restore Window Size/Position-------

set diffexpr=diff#MyDiff()
"}}}

" => Colors and Fonts"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

set background=dark
set guifont=Consolas:h10:cRUSSIAN::

" Set extra options when running in GUI mode
if has("gui_running")
    colorscheme zenburn
    set guioptions-=T
    set guioptions-=m
    set guioptions-=l
    ""    set guioptions-=r
    set guioptions-=b
    "    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
else
    colorscheme zenburn
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac
"}}}

" => Text, tab and indent related"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

set ffs=dos,unix
set ff=dos

" Auto fold stuff
set foldenable

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set number "Show line numbers

"Dont jump to closing parenthesis when inserted - help: pi_paren.txt
let loaded_matchparen = 1 

" => Visual mode related 
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
"}}}

" => Buffers and folding {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Automatically switch CWD to current file location (for NERDTree and stuff)
set autochdir

set foldmarker={{{,}}} foldmethod=marker "Default folding for this file. For different file types folding is defined below
set foldnestmax=1

" FileTypes
au BufNewFile,BufRead *.mxml set filetype=mxml
au BufNewFile,BufRead *.as set filetype=actionscript
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.shader set filetype=glsl 
au BufNewFile,BufRead *.hs set filetype=haskell
au BufNewFile,BufRead *.cs set filetype=cs 

" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

autocmd BufWinLeave \* mkview
autocmd BufWinEnter \* silent loadview 

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Go to last file if invoked without arguments.
autocmd VimEnter * nested if
            \ argc() == 0 &&
            \ bufname("%") == "" &&
            \ bufname("2" + 0) != "" |
            \   exe "normal! `0" |
            \ endif

" Remember info about open buffers on close
set viminfo^=%"
"}}}

" => Status line {{{
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l 
"}}}

" => Keybindings {{{
let mapleader = ","
let g:mapleader = ","

"navigating NERDTree to current file
map <leader>nt :NERDTreeFind<CR>

"save and quit
nmap <leader>w :w!<cr>
nmap <leader>q :qa!<cr>"

"open vimrc
map <leader>vrc :vsplit $VIM\_vimrc<cr>

"paste multiple lines
xnoremap p pgvy

"reformat code
noremap <C-k><C-d> gg=G''zz

"moving blocks of text
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


"buffers
nnoremap <S-k> :bnext<CR>
nnoremap <S-j> :bprevious<CR>
map <leader>ba :BufOnly<cr>
map <leader>bc :Bclose<cr>

"window commands
nnoremap <A-j> :wincmd h<CR>
nnoremap <A-k> :wincmd l<CR>
nnoremap <A-h> :wincmd j<CR>
nnoremap <A-l> :wincmd k<CR>
nnoremap <leader>wc :close<CR>
nnoremap <leader>wn :vnew<CR>

"joining lnes
nnoremap <C-j> :join<CR>

"centering screen on cursor
nmap <space> zz
nnoremap '' ''zz

"completion (http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE)
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

map <C-k><C-c> :call Comment()<CR>
map <C-k><C-u> :call Uncomment()<CR>

map j gj
map k gk

map <silent><leader><cr> :noh<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>
"}}}

" => Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_enable_syntastic=1 
let g:airline#extensions#tabline#fnamemod = ':t' "Only filenames
"}}}

" => CtrlP  {{{
" Start ctrlP in MRU mode 
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_open_new_file = 'v'

"  t - in a new tab.
"  h - in a new horizontal split.
"  v - in a new vertical split.
"  r - in the current window.
" }}}

" => NERDTree {{{
let g:NERDTreeWinSize=50

if has("gui_running")
    au VimEnter * NERDTree
endif
" }}}

" => Helper Functions "{{{
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Comment Stuff
function! Comment()
    let ext = tolower(expand('%:e'))
    if (ext == 'hs' || ext == 'lua')
        silent s:^:--:g
    elseif (ext == 'vim')
        silent s:^:\":g
    elseif (ext == 'rb' || ext =='yml')
        silent s:^:#:g
    else
        silent s:^:\/\/:g
    endif
endfunction

function! Uncomment()
    let ext = tolower(expand('%:e'))
    if (ext == 'hs' || ext == 'lua')
        silent s:^\s*\--::g
    elseif (ext == 'vim')
        silent s:^\s*\"::g
    elseif (ext == 'rb' || ext == 'yml')
        silent s:^\s*\#::g
    else
        silent s:^\s*\/\/::g
    endif
endfunction
"}}}
