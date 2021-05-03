" places gdb & debugged program windows at the bottom
" one beside the other (verticaly)
function! s:setup_debug_windows()
    let l:gdb_buffer_name = "!gdb"
    let l:prg_output_name = "debugged program"
    let l:gdb_win_ids = []
    let l:prg_win_ids = []

    "collect windows for gdb & prg buffers
    for l:buf in getbufinfo()
        if l:buf.listed && l:buf.name == l:gdb_buffer_name
            let l:gdb_win_ids += l:buf.windows
        endif
        if l:buf.listed && l:buf.name == l:prg_output_name
            let l:prg_win_ids += l:buf.windows
        endif
    endfor

    call assert_equal(1, len(l:gdb_win_ids))
    call assert_equal(1, len(l:prg_win_ids))

    if len(l:gdb_win_ids) == 1 && len(l:prg_win_ids) == 1
        "move gdb window to the bottom
        call win_gotoid(l:gdb_win_ids[0]) 
        wincmd J
        " split gdb window and move prg window right to it
        call win_splitmove(l:prg_win_ids[0], l:gdb_win_ids[0], {"vertical":1, "rightbelow":1}) 
    endif
endfunction

function! s:start_debugger(...)
    let l:params = join(a:000, ' ')
    execute 'Termdebug' l:params
    call s:setup_debug_windows()
endfunc

command! SetupDebugWindows call s:setup_debug_windows()
command! -nargs=* -complete=file StartDebugger call s:start_debugger(<f-args>)

