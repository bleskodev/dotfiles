if exists('g:vim_lsp_workspace_folders_loaded')
    finish
endif
let g:vim_lsp_workspace_folders_loaded = 1

" some persistent state
let s:servers = { }                     " known running servers that support workspace folders
let s:workspace_folders_from_file = []  " workspace folders read from the workspace file
let s:workspace_file_read = 0           " workspace file has been read

" update workspace folders when a server is initialized or shutdown
augroup vim_lsp_workspace_folders
    au!
    au User lsp_server_init call s:server_initialized()
    au User lsp_server_exit call s:server_shutdown()
augroup END

" new server has been initialized, send configured workspace folders
" if server supports the feature
function! s:server_initialized() abort
    let l:server_names = lsp#get_server_names()
    for l:server_name in l:server_names
        if !has_key(s:servers, l:server_name)
            if s:server_supports_workspace_folders(l:server_name)
                if s:workspace_file_read == 0
                    call s:read_workspace_file()
                endif
                call s:update_workspace_folders(l:server_name, s:workspace_folders_from_file, [])
                let s:servers[l:server_name] = 1
            endif
        endif
    endfor
endfunction

" server has been shutdown, remove the server from known servers
function! s:server_shutdown() abort
    let l:server_names = lsp#get_server_names()
    for l:server_name in l:server_names
        if has_key(s:servers, l:server_name)
            unlet s:servers[l:server_name]
        endif
    endfor
endfunction

" check if a server supports workspace folders
function! s:server_supports_workspace_folders(server_name)
    let l:caps = lsp#get_server_capabilities(a:server_name)
    if has_key(l:caps, 'workspace')
        let l:workspace = l:caps['workspace']
        if type(l:workspace) == type({}) && has_key(l:workspace, 'workspaceFolders')
            let l:wf = l:workspace['workspaceFolders']
            if l:wf['supported'] && l:wf['changeNotifications']
                return v:true
            endif
        endif
    endif
    return v:false
endfunction

" read workspace file (.lsp.workspace)
" workspace file should contain paths to workspace folders (relative to
" server's root) one path per line
function! s:read_workspace_file() abort
    let l:workspace_file_name = '.lsp.workspace'
    let l:workspace_file_path = lsp#utils#find_nearest_parent_file_directory(
                \ lsp#utils#get_buffer_path(),
                \ l:workspace_file_name)
    let l:workspace_file_full_path = l:workspace_file_path . '/' . l:workspace_file_name
    let s:workspace_folders_from_file = readfile(l:workspace_file_full_path)
    let s:workspace_file_read = 1
endfunction

" converts a list of folder paths (relative to server's root)
" to WorkspaceFolders format expected by LSP specification
function! s:folders_to_workspace_folders(server_name, folders) abort
    let l:root_uri = lsp#get_server_root_uri(a:server_name)
    let l:root_path = lsp#utils#uri_to_path(l:root_uri)
    let l:workspace_folders = []
    for l:item in a:folders
        let l:workspace_folders += [{
                    \ 'uri': lsp#utils#path_to_uri(l:root_path . '/' . l:item),
                    \ 'name' : l:item
                    \  }]
    endfor
    return l:workspace_folders
endfunction

" creates workspace/didChangeWorkspaceFolders LSP protocol message
function! s:create_workspace_folders_msg(server_name, added_folders, removed_folders)
    let l:added_wf = s:folders_to_workspace_folders(a:server_name, a:added_folders)
    let l:removed_wf = s:folders_to_workspace_folders(a:server_name, a:removed_folders)
    return { 'method': 'workspace/didChangeWorkspaceFolders',
                \ 'params': {
                \     'event': {
                \         'added': l:added_wf,
                \         'removed': l:removed_wf
                \     }
                \ }}
endfunction

" send workspace folders change message to the specified server
function! s:update_workspace_folders(server_name, folders_to_add, folders_to_remove) abort
    call lsp#callbag#pipe(lsp#notification(
                \ a:server_name,
                \ s:create_workspace_folders_msg(a:server_name,
                \                                a:folders_to_add,
                \                                a:folders_to_remove)),
                \ lsp#callbag#subscribe())
endfunction

" Methods callables via commands (see below)
"
" read workspace file and send workspace folders to known servers
function! s:lsp_wf_read_workspace_file() abort
    " unconditionally read workspace file
    call s:read_workspace_file()
    for l:server in keys(s:servers)
        call s:update_workspace_folders(l:server, s:workspace_folders_from_file, [])
    endfor
endfunction

" add a list of workspace folders to a server
" a:1    => server_name
" a:2..n => paths to folders to add (relative to server's root folder)
function! s:lsp_wf_add_workspace_folders(...) abort
    if a:0 >= 2
        let l:server_name = a:1
        let l:folders_to_add = s:folders_to_doc_uri(l:server_name, a:000[1:-1])
        call s:update_workspace_folders(l:server_name, l:folders_to_add, [])
    else
        echo 'Error: Not enough params in a function call (<server_name>, <folder1>, ...))'
    endif
endfunction

" remove a list of workspace folders from a server
" a:1    => server_name
" a:2..n => paths to folders to remove (relative to server's root folder)
function! s:lsp_wf_remove_workspace_folders(...) abort
    if a:0 >= 2
        let l:server_name = a:1
        let l:folders_to_remove = s:folders_to_doc_uri(l:server_name, a:000[1:-1])
        call s:update_workspace_folders(l:server_name, [], l:folders_to_remove)
    else
        echo 'Error: Not enough params in a function call (<server_name>, <folder1>, ...))'
    endif
endfunction

command! LspWFReadWorkspace call s:lsp_wf_read_workspace_file()
command! -nargs=+ LspWFAddWorkspaceFolders call s:lsp_wf_add_workspace_folders(<f-args>)
command! -nargs=+ LspWFRemoveWorkspaceFolders call s:lsp_wf_remove_workspace_folders(<f-args>)

" for test
"command! LspWFServerInitialized call s:server_initialized()
"command! LspWFServerShutDown call s:server_shutdown()

