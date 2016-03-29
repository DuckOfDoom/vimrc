#cljfold.vim#

This plugin is for automagic folding of &#x03BB; clojure code based on
'foldwords' that are the start of code-blocks.

This defaults to 'def' and 'ns' via

    let g:clojure_foldwords = "def,ns"
    
Additional options:

If you want to exclude blank lines from fold, use

    let g:clojure_dont_fold_blank_lines = 1 (default 0)


If you want to automatically open all folds after opening the file, use

    let g:clojure_auto_open_folds = 1 (default 0)

by Greg Berenfield with much taken from [Steve
Losh](http://www.vim.org/account/profile.php?user_id=22067) and [Meikel
Brandmeyer](http://www.vim.org/account/profile.php?user_id=62)
