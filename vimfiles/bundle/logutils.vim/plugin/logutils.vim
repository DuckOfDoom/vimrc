if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python << ENDPYTHON
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))

sys.path.insert(0, python_root_dir)

import logutils
reload(logutils)

ENDPYTHON

"if exists('g:logutils_plugin_loaded')
"    finish
"endif

"command! -nargs=0 Test call Test()
command! -nargs=0 HighlightWithSettings call HighlightWithSettings()
command! -nargs=0 HighlightAutomatically call HighlightAutomatically()

noremap  <silent><leader>hs :call HighlightWithSettings() \| nohls<CR>
noremap  <silent><leader>ha :call HighlightAutomatically() \| nohls<CR>
noremap  <silent><leader>hc :call HighlightClear() \| nohls<CR>

let s:group = "LogsHighlighter_highlight" 

"function! Test()
"    python highlight.test()
"endfunction

function! HighlightWithSettings()
    python logutils.highlight_with_settings()
endfunction

function! HighlightAutomatically()
    python logutils.highlight_automatically()
endfunction

function! HighlightClear()
   python logutils.clear()    
endfunction

"let g:logutils_plugin_loaded = 1
