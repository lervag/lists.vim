source init.vim

let g:lists_todos = ['TODO', 'INPROGRESS', 'DONE']

silent edit examples/lists.txt

" Checkbox lists
call lists#toggle(7)
call lists#toggle(10)
let [s:root, s:current] = lists#parser#get_at(3)
call assert_equal(len(s:current.children), 3)
call assert_true(s:current.checked)
call assert_true(s:root.children[1].children[0].checked)

" Todo lists
call lists#toggle(17)
let [s:root, s:current] = lists#parser#get_at(17)
call assert_equal(s:current.states[s:current.state], 'DONE')

call lists#test#finished()
