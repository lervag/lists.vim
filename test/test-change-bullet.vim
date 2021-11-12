source init.vim

silent edit examples/lists.txt

call assert_equal('-', lists#bullet#get(5))
call assert_equal('*', lists#bullet#get(19))

call lists#bullet#change_all('*', 7)
call assert_equal('*', lists#bullet#get(5))
call assert_equal('*', lists#bullet#get(12))
silent undo
call assert_equal('-', lists#bullet#get(5))
call assert_equal('-', lists#bullet#get(12))

call lists#bullet#toggle_all(7)
call assert_equal('*', lists#bullet#get(5))
call assert_equal('*', lists#bullet#get(12))
silent undo
call assert_equal('-', lists#bullet#get(5))
call assert_equal('-', lists#bullet#get(12))

call lists#bullet#change_local('*', 7)
call assert_equal('-', lists#bullet#get(5))
call assert_equal('*', lists#bullet#get(6))
call assert_equal('*', lists#bullet#get(7))
call assert_equal('-', lists#bullet#get(8))
call assert_equal('*', lists#bullet#get(11))
call assert_equal('-', lists#bullet#get(12))
silent undo

call lists#bullet#toggle_local(7)
call assert_equal('-', lists#bullet#get(5))
call assert_equal('*', lists#bullet#get(6))
call assert_equal('*', lists#bullet#get(7))
call assert_equal('-', lists#bullet#get(8))
call assert_equal('*', lists#bullet#get(11))
call assert_equal('-', lists#bullet#get(12))
silent undo

call lists#test#finished()
