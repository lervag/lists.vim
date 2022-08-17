set nocompatible
let &runtimepath =
      \ simplify(fnamemodify(expand('<sfile>'), ':h') . '/..')
      \ . ',' . &runtimepath
set noswapfile
set noshowmode
set nomore
nnoremap q :qall!<cr>

runtime plugin/lists.vim
