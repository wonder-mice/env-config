" Shows indention based context for current cursor position.
" Function to call is Whereami. Key binding example:
" nnoremap <silent> <leader>w :Whereami<CR>

function! s:startswith(string,prefix)
	return strpart(a:string, 0, strlen(a:prefix)) ==# a:prefix
endfunction

function! s:strip(s)
	return substitute(a:s, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! s:is_context(s)
	if 0 == strlen(a:s)
		return 0
	endif
	if s:startswith(a:s, "{")
		return 0
	endif
	if s:startswith(a:s, "#")
		return 0
	endif
	return 1
endfunction

function! s:nwidth()
	let l:md = strlen(printf("%d", line("$")))
	return max([&numberwidth - 1, l:md])
endfunction

function! s:whereami()
	let l:n = getpos(".")[1]
	let l:mind = -1
	let l:mlst = []
	while 0 < n && 0 != mind
		let l:p = n
		let l:n = p - 1
		let l:ind = indent(p)
		if ind >= mind && -1 != mind
			continue
		endif
		let l:str = s:strip(getline(p))
		if !s:is_context(str)
			continue
		endif
		if -1 != mind
			call insert(mlst, [str, ind, p])
		endif
		let l:mind = ind
	endwhile
	return mlst
endfunction

function! Whereami()
	let l:mlst = s:whereami()
	let l:lfmt = printf("%%%dd ", s:nwidth())
	for s in mlst
		echo printf(lfmt, s[2]) . repeat(" ", s[1]) . s[0]
	endfor
endfunction

command -bar -nargs=0 Whereami :call Whereami()
