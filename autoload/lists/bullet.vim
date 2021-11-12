" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! lists#bullet#get(...) abort " {{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()

  return get(l:current, 'bullet', '')
endfunction

" }}}1

function! lists#bullet#toggle_all(...) abort " {{{1
  let [l:_, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()

  let l:bullet = get(l:current, 'bullet', '')
  if empty(l:bullet) | return | endif

  let l:new = l:bullet ==# '*' ? '-' : '*'
  call lists#bullet#change_all(l:new, a:0 > 0 ? a:1 : line('.'))
endfunction

" }}}1
function! lists#bullet#change_all(new, ...) abort " {{{1
  let [l:cur, l:_] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()

  while !empty(l:cur)
    let l:cur = l:cur.next
    if has_key(l:cur, 'set_bullet')
      call l:cur.set_bullet(a:new)
    endif
  endwhile
endfunction

" }}}1

function! lists#bullet#toggle_local(...) abort " {{{1
  let [l:_, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()

  let l:bullet = get(l:current, 'bullet', '')
  if empty(l:bullet) | return | endif

  let l:new = l:bullet ==# '*' ? '-' : '*'
  call lists#bullet#change_local(l:new, a:0 > 0 ? a:1 : line('.'))
endfunction

" }}}1
function! lists#bullet#change_local(new, ...) abort " {{{1
  let [l:_, l:start] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()

  for l:item in l:start.parent.children
    if has_key(l:item, 'set_bullet')
      call l:item.set_bullet(a:new)
    endif
  endfor
endfunction

" }}}1
