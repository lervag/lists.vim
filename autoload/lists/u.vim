" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! lists#u#command(cmd) abort " {{{1
  return split(execute(a:cmd, 'silent!'), "\n")
endfunction

" }}}1
function! lists#u#extend_recursive(dict1, dict2, ...) abort " {{{1
  let l:option = a:0 > 0 ? a:1 : 'force'
  if index(['force', 'keep', 'error'], l:option) < 0
    throw 'E475: Invalid argument: ' . l:option
  endif

  for [l:key, l:value] in items(a:dict2)
    if !has_key(a:dict1, l:key)
      let a:dict1[l:key] = l:value
    elseif type(l:value) == type({})
      call lists#u#extend_recursive(a:dict1[l:key], l:value, l:option)
    elseif l:option ==# 'error'
      throw 'E737: Key already exists: ' . l:key
    elseif l:option ==# 'force'
      let a:dict1[l:key] = l:value
    endif
    unlet l:value
  endfor

  return a:dict1
endfunction

" }}}1
function! lists#u#init_option(name, default) abort " {{{1
  let l:option = 'g:' . a:name
  if !exists(l:option)
    let {l:option} = a:default
  elseif type(a:default) == type({})
    call lists#u#extend_recursive({l:option}, a:default, 'keep')
  endif
endfunction

" }}}1
