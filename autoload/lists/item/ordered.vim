" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"


function! lists#item#ordered#new() abort " {{{1
  return deepcopy(s:item)
endfunction

" }}}1


let s:item = extend(lists#item#general#new(), {
      \ 'type' : 'ordered',
      \ 're_item': '^\s*\d\+\.\%(\s\|$\)',
      \ 're_number': '^\s*\zs\d\+\ze\.\%(\s\|$\)',
      \})

function! s:item.next_header() abort dict "{{{1
  return substitute(copy(self.header), '^\s*\zs.*', '', '')
        \ . (self.counter_nested + 1) . '. '
endfunction

" }}}1
