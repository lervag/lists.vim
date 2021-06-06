source init.vim

silent edit examples/lists.txt

" Numbered lists general
let [s:root, s:current] = lists#parser#get_at(22)
call assert_equal(
      \ '1. Ordered lists are also cool',
      \ s:current.text[0])

" Numbered todo lists
call lists#toggle(23)
let [s:root, s:current] = lists#parser#get_at(23)
call assert_equal('DONE', s:current.states[s:current.state])

call lists#test#finished()
