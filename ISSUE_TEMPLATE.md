# Description

The description should provide the details necessary to address the issue.
This typically includes the following:

1. A description of the expected behaviour
2. A description of the observed behaviour
3. The steps required to reproduce the issue

If your issue is instead a feature request or anything else, please consider if
minimal examples and vimrc files might still be relevant.

# Minimal working example

Please provide a minimal working example. That is, provide __an example of a file
with relevant content__, and **a minimal vimrc file** such as this:

```vim
" filename: test.vim
set nocompatible
let &rtp  = '~/.vim/bundle/lists.vim,' . &rtp

" Load other plugins, if necessary
" let &rtp = '~/path/to/other/plugin,' . &rtp

filetype plugin indent on
syntax enable
```

Now you can open the test file with `vim -u test.vim test.txt`.
