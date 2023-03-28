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
      \ 're_bullet': '^\s*\zs[*-]',
      \})

function! s:item.init() abort dict "{{{1
  let self.bullet = matchstr(self.header, self.re_bullet)
endfunction

" }}}1
function! s:item.next_header() abort dict "{{{1
  return substitute(copy(self.header), '^\s*\zs.*', '', '')
        \ . matchstr(self.header, '[*-]') . ' '
endfunction

" }}}1
function! s:item.set_bullet(new) abort dict "{{{1
  if index(['*', '-'], a:new) < 0 | return | endif
  if a:new ==# self.bullet | return | endif

  call setline(self.lnum_start,
        \ substitute(self.text[0], self.re_bullet, a:new, ''))
endfunction

" }}}1
function! s:item.to_checkbox() abort dict "{{{1
  " Edge case: missing space after bullet
  if self.text[0] =~# self.re_item . '$' && self.text[0] =~# '\S$'
    let self.text[0] .= ' '
  endif

  let l:line = substitute(self.text[0], '^\s*[*-]\s\zs', '[ ] ', '')

  call setline(self.lnum_start, l:line)
endfunction

" }}}1
