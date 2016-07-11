set expandtab
set shiftwidth=2

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

noremap <C-k><C-d> mqHmwgg=G`wzt`q :%!stylish-haskell<CR>
