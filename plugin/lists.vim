" A Vim plugin to handle lists
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

if exists('g:loaded_lists') | finish | endif
let g:loaded_lists = 1


call lists#u#init_option('lists_filetypes', [])
call lists#u#init_option('lists_enable_default_maps', v:true)
call lists#u#init_option('lists_todos', ['TODO', 'DONE'])

command! ListsEnable call lists#init()


" Enable on desired filetypes
if !empty(g:lists_filetypes)
  augroup lists
    autocmd!
    for s:ft in g:lists_filetypes
      execute 'autocmd BufRead,BufNewFile *.' . s:ft 'ListsEnable'
    endfor
  augroup END
endif
