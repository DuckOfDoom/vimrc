if exists("loaded_log_highlighter") 
   finish
endif
let loaded_log_highlighter = ""

function log_highlighter#Hello()
      let match_pat = '.*\%'.line(".").'l.*'
       echo 'syn match '. s:lcolor_grp . s:lcolor_n . ' "' . match_pat . '" containedin=ALL'
"      exec 'syn match '. s:lcolor_grp . s:lcolor_n . ' "' . match_pat . '" containedin=ALL'
endfunction
