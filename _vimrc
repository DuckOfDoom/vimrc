set nocompatible
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

set noundofile
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

set switchbuf=split

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500"

set nowrapscan


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
if has("win32")
    set guifont=Consolas:h10:cRUSSIAN::
endif

let g:rainbow_active = 1

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=l
    ""    set guioptions-=r
    set guioptions-=b
    "    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

colorscheme base16-eighties

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set fileformat=unix
set fileformats=unix,dos
"}}}

" => Text, tab and indent related"{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Auto fold stuff
set foldenable

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set number "Show line numbers

"Dont jump to closing parenthesis when inserted - help: pi_paren.txt
"let loaded_matchparen = 0

"Dont insert comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
set splitright
set splitbelow

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

" Folding settings for *.clj files
let g:clojure_dont_fold_blank_lines = 1
let g:clojure_auto_open_folds = 1
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

imap kj <ESC>
vmap kj <ESC>

"navigating NERDTree to current file
map <leader>nh :NERDTree $HOME<CR>
map <leader>nt :NERDTreeFind<CR>
map <leader>nc :NERDTreeClose<CR>
map <leader>p :call PareditToggle()<CR>

"insert lines
vmap <leader>l :g/.\n\n\@!/norm o<cr>:noh<cr>

"open vimrc
if has("win32")
   map <leader>vrc :vsplit $VIM\_vimrc<cr>
else 
   map <leader>vrc :vsplit $VIM/vimrc<cr>
endif

map <leader>vrr :source $MYVIMRC<cr>

"paste multiple lines
xnoremap p pgvy

"reformat code
noremap <C-k><C-d> mqHmwgg=G`wzt`q 
vnoremap <C-k><C-d> =

"buffers
nnoremap <S-k> :bnext<CR>
nnoremap <S-j> :bprevious<CR>
nmap <leader>ba :BufOnly<cr>
nmap <leader>bc :Bclose<cr>

map <leader>hl :call log_highlighter#Hello()<CR>

"window commands
nnoremap <A-j> :wincmd h<CR>
nnoremap <A-k> :wincmd l<CR>
nnoremap <A-h> :wincmd j<CR>
nnoremap <A-l> :wincmd k<CR>
nmap <leader>wc :close<CR>
nmap <leader>wn :vnew<CR>

"joining lnes
nnoremap <C-j> :join<CR>

"centering screen on cursor
nmap <space> zz
nnoremap '' ''zz

inoremap <expr><CR> pumvisible() ? "\<C-n>" : "\<CR>" 

map <C-k><C-c> :call Comment()<CR>
map <C-k><C-u> :call Uncomment()<CR>

"map j gj
"map k gk

map <silent><leader><cr> :noh<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>

nmap <leader>fj :call FormatJson("n")<CR>
vmap <leader>fj :call FormatJson("i")<CR>

" extracts first block in { } 
map <leader>ej f{v%ygg"_dGP :call FormatJson("n")<CR>

map <leader>n :enew<CR>

"}}}

" => Tabular {{{
"haskell
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
"}}}

" => EasyAlign {{{
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
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
let g:NERDTreeCascadeSingleChildDir=0

if has("gui_running")
    au VimEnter * NERDTree
endif
" }}}

"{{{ => Neocomplete
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}

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
    elseif (ext == 'rb' || ext =='yml' || ext == 'erb' || ext == 'py' || ext == 'sh')
        silent s:^:#:g
    elseif (ext == 'clj')
        silent s:^:;;:g
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
    elseif (ext == 'rb' || ext =='yml' || ext == 'erb' || ext == 'py' || ext == 'sh')
        silent s:^\s*\#::g
    elseif (ext == 'clj')
        silent s:^\s*\;;::g
    else
        silent s:^\s*\/\/::g
    endif
endfunction

function! FormatJson(mode)
    if a:mode == "n"
        :%!python -m json.tool 
    elseif a:mode == "i"
        :'<,'>!python -m json.tool 
    endif

    set syntax=json  
endfunction
"}}}

