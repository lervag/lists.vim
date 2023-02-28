source init.vim

silent read examples/lists.txt
ListsEnable

normal 15GoNew
call assert_equal('  - [x] New', getline(16))

normal 10GoNew
call assert_equal('    - [x] New', getline(11))

normal 9GoNew
call assert_equal('    - New', getline(10))

normal 9GoNew
call assert_equal('    - New', getline(10))

call lists#test#finished()
