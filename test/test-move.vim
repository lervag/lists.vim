source init.vim

silent edit examples/move_in.txt

call lists#move(0, 5)
call lists#move(0, 7)
call lists#move(0, 7)
call lists#move(1, 10)
call lists#move(1, 3)
call lists#move(1, 6)
call lists#move(1, 20)

call lists#move(0, 24)

let s:result = getline(1, '$')
let s:reference = readfile('examples/move_out.txt')

call assert_equal(s:reference, s:result)

call lists#test#finished()
