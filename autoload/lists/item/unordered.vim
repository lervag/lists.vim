" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"


function! lists#item#unordered#new() abort " {{{1
  return deepcopy(s:item)
endfunction

" }}}1


let s:item = extend(lists#item#general#new(), {
      \ 'type' : 'unordered',
      \ 're_item': '^\s*[*-]\(\s\|$\)',
      \})

function! s:item.next_header() abort dict "{{{1
  return substitute(copy(self.header), '^\s*\zs.*', '', '')
        \ . matchstr(self.header, '[*-]') . ' '
endfunction

" }}}1
