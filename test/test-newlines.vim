source init.vim

silent read examples/lists.txt
ListsEnable

normal 15GoNew
call assert_equal('  - [x] New', getline(16))

call lists#test#finished()
