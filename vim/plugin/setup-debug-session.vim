" places gdb & debugged program windows at the bottom
" one beside the other (verticaly)
function! SetupDebugWindows()
    let gdb_buffer_name = "!gdb"
    let prg_output_name = "debugged program"
    let gdb_win_ids = []
    let prg_win_ids = []

    "collect windows for gdb & prg buffers
    for buf in getbufinfo()
        if buf.listed && buf.name == gdb_buffer_name
            let gdb_win_ids += buf.windows
        endif
        if buf.listed && buf.name == prg_output_name
            let prg_win_ids += buf.windows
        endif
    endfor

    call assert_equal(1, len(gdb_win_ids))
    call assert_equal(1, len(prg_win_ids))

    if len(gdb_win_ids) == 1 && len(prg_win_ids) == 1
        "move gdb window to the bottom
        call win_gotoid(gdb_win_ids[0]) 
        wincmd J
        " split gdb window and move prg window right to it
        call win_splitmove(prg_win_ids[0], gdb_win_ids[0], {"vertical":1, "rightbelow":1}) 
    endif
endfunction


