" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! lists#test#finished() abort " {{{1
  for l:error in v:errors
    let l:match = matchlist(l:error, '\(.*\) line \(\d\+\): \(.*\)')
    let l:file = fnamemodify(l:match[1], ':.')
    let l:lnum = l:match[2]
    let l:msg = l:match[3]
    echo printf("%s:%d: %s\n", l:file, l:lnum, l:msg)
  endfor

  if $QUIT
    if len(v:errors) > 0
      cquit
    else
      quitall!
    endif
  endif
endfunction

" }}}1
