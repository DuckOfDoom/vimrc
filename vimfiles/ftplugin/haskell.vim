set expandtab
set shiftwidth=2

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

map <C-k><C-s> :%!stylish-haskell<CR>

" haskell-specific delimiters for EasyAlign
let g:easy_align_delimiters = {
\  ' ': { 'pattern': ' ',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
\  '.': { 'pattern': '\.', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\  '&': { 'pattern': '\\\@<!&\|\\\\',
\                          'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\  '<': { 'pattern': '<',  'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
\ }

"let g:easy_align_delimiters = {
"\  ' ': { 'pattern': ' ',  'left_margin': 0, 'right_margin': 0, 'stick_to_left': 0 },
"\  '=': { 'pattern': '===\|<=>\|\(&&\|||\|<<\|>>\)=\|=\~[#?]\?\|=>\|[:+/*!%^=><&|.-]\?=[#?]\?',
"\                          'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
"\  ':': { 'pattern': ':',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
"\  ',': { 'pattern': ',',  'left_margin': 0, 'right_margin': 1, 'stick_to_left': 1 },
"\  '|': { 'pattern': '|',  'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
"\  '.': { 'pattern': '\.', 'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
"\  '#': { 'pattern': '#\+', 'delimiter_align': 'l', 'ignore_groups': ['!Comment']  },
"\  '&': { 'pattern': '\\\@<!&\|\\\\',
"\                          'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
"\  '{': { 'pattern': '(\@<!{',
"\                          'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },
"\  '}': { 'pattern': '}',  'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
"\  '<': { 'pattern': '<-',  'left_margin': 1, 'right_margin': 0, 'stick_to_left': 0 },
"\ }
