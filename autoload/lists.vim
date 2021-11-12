" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! lists#init() abort " {{{1
  " Set 'comments' option for lists
  setlocal comments+=fb:*,f:*\ TODO:,b:*\ [\ ],b:*\ [x]
  setlocal comments+=fb:-,f:-\ TODO:,b:-\ [\ ],b:-\ [x]

  command! -buffer ListsMoveUp    call lists#move(0)
  command! -buffer ListsMoveDown  call lists#move(1)
  command! -buffer ListsToggle    call lists#toggle()
  command! -buffer ListsUniq      call lists#uniq(0)
  command! -buffer ListsUniqLocal call lists#uniq(1)
  command! -buffer ListsShowItem  call lists#show_item()

  command! -buffer -bang ListsToggleBullet
        \ if empty(<q-bang>) |
        \   call lists#bullet#toggle_all() |
        \ else |
        \   call lists#bullet#toggle_local() |
        \ endif

  nnoremap <silent><buffer> <plug>(lists-moveup)              :ListsMoveUp<cr>
  nnoremap <silent><buffer> <plug>(lists-movedown)            :ListsMoveDown<cr>
  nnoremap <silent><buffer> <plug>(lists-toggle)              :ListsToggle<cr>
  nnoremap <silent><buffer> <plug>(lists-uniq)                :ListsUniq<cr>
  nnoremap <silent><buffer> <plug>(lists-uniq-local)          :ListsUniqLocal<cr>
  nnoremap <silent><buffer> <plug>(lists-show-item)           :ListsShowItem<cr>
  inoremap <silent><buffer> <plug>(lists-toggle)              <esc>:call lists#new_item()<cr>
  onoremap <silent><buffer> <plug>(lists-al)                  :call      lists#text_obj#list_element(0, 0)<cr>
  xnoremap <silent><buffer> <plug>(lists-al)                  :<c-u>call lists#text_obj#list_element(0, 1)<cr>
  onoremap <silent><buffer> <plug>(lists-il)                  :call      lists#text_obj#list_element(1, 0)<cr>
  xnoremap <silent><buffer> <plug>(lists-il)                  :<c-u>call lists#text_obj#list_element(1, 1)<cr>
  nnoremap <silent><buffer> <plug>(lists-bullet-toggle-all)   :call lists#bullet#toggle_all()<cr>
  nnoremap <silent><buffer> <plug>(lists-bullet-toggle-local) :call lists#bullet#toggle_local()<cr>

  for [l:rhs, l:lhs] in items({
        \ '<plug>(lists-toggle)': '<c-s>',
        \ '<plug>(lists-moveup)': '<leader>wlk',
        \ '<plug>(lists-movedown)': '<leader>wlj',
        \ '<plug>(lists-uniq)': '<leader>wlu',
        \ '<plug>(lists-uniq-local)': '<leader>wlU',
        \ '<plug>(lists-show-item)': '<leader>wls',
        \ '<plug>(lists-bullet-toggle-all)': '<leader>wlt',
        \ '<plug>(lists-bullet-toggle-local)': '<leader>wlT',
        \ 'i_<plug>(lists-toggle)': '<c-s>',
        \ 'o_<plug>(lists-al)': 'al',
        \ 'x_<plug>(lists-al)': 'al',
        \ 'o_<plug>(lists-il)': 'il',
        \ 'x_<plug>(lists-il)': 'il',
        \})
    if l:rhs[0] !=# '<'
      let l:mode = l:rhs[0]
      let l:rhs = l:rhs[2:]
    else
      let l:mode = 'n'
    endif

    if hasmapto(l:rhs, l:mode) || !empty(maparg(l:lhs, l:mode))
      continue
    endif

    execute l:mode . 'map <silent><buffer>' l:lhs l:rhs
  endfor
endfunction

" }}}1

function! lists#toggle(...) abort "{{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()
  if empty(l:current) | return | endif

  call l:current.toggle()
endfunction

" }}}1
function! lists#move(direction, ...) abort "{{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()
  if empty(l:current) | return | endif

  let l:target_pos = getcurpos()

  if a:direction == 0
    let l:target = -1
    let l:parent_counter = 0
    let l:prev = l:current.prev
    while l:prev.indent >= 0
      let l:parent_counter += l:prev.indent < l:current.indent

      if l:prev.indent == l:current.indent
        let l:target = l:parent_counter > 0
              \ ? l:prev.lnum_last
              \ : l:prev.lnum_start - 1
        break
      elseif l:parent_counter > 1 && l:prev.indent == l:current.parent.indent
        let l:target = l:prev.lnum_end
        break
      endif

      let l:prev = l:prev.prev
    endwhile

    let l:target_pos[1] += l:target - l:current.lnum_start + 1
  else
    let l:target = -1
    let l:next = l:current.next
    while !empty(l:next)
      if l:next.indent > l:current.indent
        let l:next = l:next.next
        continue
      endif

      let l:target = l:next.indent < l:current.indent
            \ ? l:next.lnum_end
            \ : l:next.lnum_last
      break
    endwhile

    let l:target_pos[1] += l:target - l:current.lnum_last
  endif

  if l:target < 0 | return | endif

  silent execute printf('%d,%dm %d',
        \ l:current.lnum_start, l:current.lnum_last, l:target)

  call setpos('.', l:target_pos)
endfunction

" }}}1
function! lists#uniq(local, ...) abort "{{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()
  if empty(l:current) | return | endif

  let l:parent = a:local ? l:current.parent : l:root

  let l:list_parsed = s:uniq_parse(l:parent.children)
  let l:list_new = s:uniq_to_text(l:list_parsed)

  let l:last = l:parent.children[-1]
  while !empty(l:last.children)
    let l:last = l:last.children[-1]
  endwhile
  let l:start = l:parent.children[0].lnum_start
  let l:end = l:last.lnum_end

  let l:save_pos = getcurpos()
  silent execute printf('%d,%ddelete _', l:start, l:end)
  call append(l:start-1, l:list_new)
  call setpos('.', l:save_pos)
endfunction

function! s:uniq_parse(items) abort "{{{2
  let l:uniq = []

  for l:e in a:items
    let l:found = 0
    for l:u in l:uniq
      if join(l:u.text) ==# join(l:e.text)
        call extend(l:u.children, l:e.children)
        let l:found = 1
        break
      endif
    endfor

    if !l:found
      call add(l:uniq, {
            \ 'text' : l:e.text,
            \ 'children' : l:e.children,
            \})
    endif
  endfor

  for l:u in l:uniq
    let l:u.children = s:uniq_parse(l:u.children)
  endfor

  return l:uniq
endfunction

" }}}2
function! s:uniq_to_text(tree) abort "{{{2
  let l:text = []

  for l:leaf in a:tree
    call extend(l:text, l:leaf.text)

    if !empty(l:leaf.children)
      call extend(l:text, s:uniq_to_text(l:leaf.children))
    endif
  endfor

  return l:text
endfunction

" }}}2

" }}}1
function! lists#renumber() abort "{{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()
  if empty(l:current) | return | endif
endfunction

" }}}1
function! lists#show_item(...) abort "{{{1
  let [l:root, l:current] = a:0 > 0
        \ ? lists#parser#get_at(a:1)
        \ : lists#parser#get_current()
  if empty(l:current) | return | endif

  call lists#log#echo(join(l:current.to_string(), "\n"))
endfunction

" }}}1
function! lists#new_item() abort "{{{1
  " Go back properly to insert mode
  let l:col_last = col('$') - 1
  let l:col_cur = col('.')
  normal! l

  " Toggle TODOstate if cursor inside valid todo list item
  let l:line = getline('.')
  if l:line !~# '^\s*$'
    let [l:root, l:current] = lists#parser#get_current()

    if !empty(l:current)
      call l:current.toggle()
      let l:col_new = col('$') - 1
    endif

    " Go back properly to insert mode
    if l:col_cur == l:col_last
      startinsert!
    else
      startinsert
    endif

    return
  endif

  " Find last used list item type
  let [l:root, l:current] = lists#parser#get_previous()
  if empty(l:root)
    startinsert
    return
  endif

  let l:cur = l:root
  while !empty(l:cur.next)
    let l:cur = l:cur.next
  endwhile

  call setline(line('.'), l:cur.next_header())
  startinsert!
endfunction

" }}}1
