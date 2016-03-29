if !exists('g:clojure_foldwords')
    let g:clojure_foldwords = "def,ns"
endif

if !exists('g:clojure_dont_fold_blank_lines')
    let g:clojure_dont_fold_blank_lines = 0
endif

if !exists('g:clojure_auto_open_folds')
    let g:clojure_auto_open_folds = 0
endif


function! CompareLispword(line)
    let fwc = split(g:clojure_foldwords,",")

    for fw in fwc
        if a:line =~ '^\s*('.fw.'.*'
            return 1
        elseif a:line =~ '^\s*(\w*/'.fw.'.*'
            return 1
        endif
    endfor
endfunction

function! GetClojureFold()
    if CompareLispword(getline(v:lnum))
        return ">1"
    elseif getline(v:lnum) =~ '^\s*$'
        let my_cljnum = v:lnum
        let my_cljmax = line("$")

        while (1)
            let my_cljnum = my_cljnum
            if my_cljnum > my_cljmax
                return "<1"
            endif

            let my_cljdata = getline(my_cljnum)

            if my_cljdata =~ '^$'
                if g:clojure_dont_fold_blank_lines
                    return "-1"
                else 
                    return "<1"
                endif
            else
                return "="
            endif
        endwhile
    else
        return "="
    endif
endfunction

function! StartClojureFolding()
    setlocal foldexpr=GetClojureFold()
    setlocal foldmethod=expr
endfunction

augroup ft_clojure
    au!
    au BufNewFile,BufRead *.clj set filetype=clojure
    au FileType clojure silent! call StartClojureFolding()

    if g:clojure_auto_open_folds
        au FileType clojure setlocal foldlevel=99
    endif
    
    au FileType clojure setlocal report=100000
augroup END
