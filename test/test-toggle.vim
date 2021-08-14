source init.vim

let g:lists_todos = ['TODO', 'INPROGRESS', 'DONE']

silent edit examples/lists.txt

" Checkbox lists
call lists#toggle(1)
let [s:root, s:current] = lists#parser#get_at(1)
call assert_true(s:current.checked)

call lists#toggle(9)
call lists#toggle(12)
let [s:root, s:current] = lists#parser#get_at(5)
call assert_equal(3, len(s:current.children))
call assert_true(s:current.checked)
call assert_true(s:root.children[1].children[0].checked)

" Todo lists
call lists#toggle(19)
let [s:root, s:current] = lists#parser#get_at(19)
call assert_equal('DONE', s:current.states[s:current.state])

call lists#test#finished()
