# Introduction

This is a [Vim](http://www.vim.org/) plugin to manage text based lists. The
following features are provided. The default mappings are indicated. See the
[main docs](doc/lists.txt) for the details.

* `<c-s>`: Normal mode and insert mode mapping to toggle list items, e.g. between things like:

    ```
    * [ ]      →    * [x]
    * TODO:    →    * DONE:
    ```

* `il` and `al`: Text objects for list items.
* `<leader>wlk` and `<leader>wlj`: Move list items up or down the list.
* `<leader>wlu`: Remove repeated entries in a list (recursively)

# Installation

If you use [vim-plug](https://github.com/junegunn/vim-plug), then add the
following line to your `vimrc` file:

```vim
Plug 'lervag/lists.vim'
```

Or use some other plugin manager:
* [vundle](https://github.com/gmarik/vundle)
* [neobundle](https://github.com/Shougo/neobundle.vim)
* [pathogen](https://github.com/tpope/vim-pathogen)

# Related projects

* [bullets.vim](https://github.com/dkarter/bullets.vim): a Vim/NeoVim plugin for automated bullet lists
* [lazyList.vim](https://github.com/KabbAmine/lazyList.vim): Be lazy, and let this vim plugin create lists for you
* [vim-rainbow-lists](https://github.com/lervag/vim-rainbow-lists): Nested highlighting of lists
* [vim-todo-lists](https://github.com/aserebryakov/vim-todo-lists): Vim plugin for TODO lists
* [vim-todo](https://github.com/cathywu/vim-todo): Basic todo list management in vim

# Acknowledgements

The functionality of lists.vim was earlier a part of
[wiki.vim](https://github.com/lervag/wiki.vim) and implemented for my personal
convenience. However, [as someone pointed
out](https://github.com/lervag/wiki.vim/issues/131), the list features do not
really have anything to do with the wiki functionality. Thus it was extracted
from wiki.vim into this dedicated list plugin.

