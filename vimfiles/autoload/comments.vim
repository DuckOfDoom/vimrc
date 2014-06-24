function! comments#Comment()
	let ext = tolower(expand('%:e'))
	if (ext == 'hs')
		silent s:^:--:g
	elseif (ext == 'vim')
		silent s:^:\":g
	else
		silent s:^:\/\/:g
	endif
endfunction

function! comments#Uncomment()
	let ext = tolower(expand('%:e'))
	if (ext == 'hs')
		silent s:^\s*\--::g
	elseif (ext == 'vim')
		silent s:^\s*\"::g
	else
		silent s:^\s*\/\/::g
	endif
endfunction
