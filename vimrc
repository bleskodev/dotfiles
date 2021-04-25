set nocompatible    " required by Vundle
filetype off        " required by Vundle
"set shell=/bin/bash " required by Vundle ENABLE THIS BEFORE CALLING :PluginUpdate/:PluginInstall


" set runtime path to include Vundle and initialize
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'       " color theme
Plugin 'rking/ag.vim'                           " search plugin
Plugin 'tpope/vim-fugitive'                     " git integration plugin
Plugin 'tpope/vim-dispatch'                     " make helper plugin
Plugin 'vim-scripts/a.vim'                      " switch .h <-> .c plugin
Plugin 'sirtaj/vim-openscad'                    " open-scad syntax plugin
Plugin 'christoomey/vim-tmux-navigator'         " Seamless navigation between tmux panes and vim splits
Plugin 'tmux-plugins/vim-tmux'                  " Syntax highlighting for tmux.conf
Plugin 'benmills/vimux'                         " Easily interact with tmux from vim
Plugin 'preservim/nerdtree'                     " file explorer
Plugin 'prabirshrestha/vim-lsp'                 " LSP language server protocol
Plugin 'prabirshrestha/asyncomplete.vim'        " completion plugin
Plugin 'prabirshrestha/asyncomplete-lsp.vim'    " completion plugin (connection to LSP)
Plugin 'jackguo380/vim-lsp-cxx-highlight'       " C++ syntax highlighting
Plugin 'm-pilia/vim-ccls'                       " CCLS (LSP) plugin (expose LSP CCLS lsp extensions)

" All plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on " required

syntax enable
let g:solarized_termcolors=16
set t_Co=256
"set background=dark
set background=light
colorscheme solarized

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Display
set title
set number
set ruler
set wrap

" status line
set laststatus=2    " always display status line
set statusline=[%n]\ %<%f\ %{fugitive#statusline()}%h%m%r%=%-14.(%l,%c%V%)\ %P\ %a

set scrolloff=3     " display minimum 3 lines around cursor

" Splits
" easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" more natural split opening
set splitbelow
set splitright

" redefine leader key
let mapleader=','

" configuration for Ag plugin
" place a marker and search
nnoremap <Leader>j mA:Ag<space>
" place a marker and search the word under cursor
nnoremap <Leader>ja mA:Ag "<C-r>=expand("<cword>")<cr>"
nnoremap <Leader>jA mA:Ag "<C-r>=expand("<cWORD>")<cr>"

" tabs to spaces
set expandtab
" tabs 4 characters
set tabstop=4
" indentation 4 characters
set shiftwidth=4

" A few keybindings
"
" Bubble single lines
nnoremap <C-Up> ddkP
nnoremap <C-Down> ddp
" Bubble multiple lines
vnoremap <C-Up> xkP`[V`]
vnoremap <C-Down> xp`[V`]
" insert blank line without entering insert mode
nnoremap <Leader>o o<ESC>
nnoremap <Leader>O O<ESC>
" more convenient <esc> in insert mode
inoremap jk <ESC>

" Spell check
cmap spc setlocal spell spelllang=

" Completion
" Language servers (vim-lsp)
" CCLS (C++)
if executable('ccls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'ccls',
    \ 'cmd': {server_info->['ccls']},
    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
    \ 'initialization_options': {
    \   'cache': {'directory': '/tmp/ccls/cache'},
    \   'highlight': { 'lsRanges' : v:true },
    \ },
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
    \ })
endif

" PYLS (python-language-server)
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'allowlist': ['python'],
    \ })
endif

" Solargraph (Ruby)
if executable('solargraph')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'solargraph',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
    \ 'allowlist': ['ruby'],
    \ })
endif

" serve-d (Dlang)
if executable('serve-d')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'serve-d',
    \ 'cmd': {server_info->['serve-d']},
    \ 'allowlist': ['d'],
    \ })
endif

" LSP server debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = '/tmp/vim-lsp/vim-lsp.log'

" Code navigation (vim-lsp)
function! s:on_lsp_buffer_enabled() abort
  setlocal signcolumn=yes
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  nmap <buffer> <Leader>ld  <plug>(lsp-definition)
  nmap <buffer> <Leader>lr  <plug>(lsp-references)
  nmap <buffer> <Leader>li  <plug>(lsp-implementation)
  nmap <buffer> <Leader>lt  <plug>(lsp-type-definition)
  nmap <buffer> <Leader>ls  :LspDocumentSymbol
  nmap <buffer> <Leader>lS  :LspWorkspaceSymbol <C-r>=expand("<cword>")<cr>
  nmap <buffer> <Leader>rn  <plug>(lsp-rename)
  nmap <buffer> <Leader>lp  <plug>(lsp-previous-diagnostic)
  nmap <buffer> <Leader>ln  <plug>(lsp-next-diagnostic)
  nmap <buffer> <Leader>lep <plug>(lsp-previous-error)
  nmap <buffer> <Leader>len <plug>(lsp-next-error)
  nmap <buffer> <Leader>lf  <plug>(lsp-document-format)
  nmap <buffer> K <plug>(lsp-hover)

  "let g:lsp_format_sync_timeout = 1000
  "autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" folding
set nofoldenable    " no folding when document is opened
set foldmethod=syntax

" Default 'Yellow' color does not work with Solarized ??? (vim-lsp-cxx-higlight)
hi LspCxxHlGroupNamespace ctermfg=Magenta guifg=#3D3D00 cterm=none gui=none

" Syntax highlighting (C++) (vim-lsp-cxx-highlight)
if (&background == 'light')
  let g:lsp_cxx_hl_light_bg=1       " use colors for light background
endif
let g:lsp_cxx_hl_use_text_props=1   " use textprops

" Tab completion (asyncomplete.vim)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"


" setup :make to DUB for D files
autocmd FileType d compiler dub
autocmd FileType d nnoremap <buffer> <Leader>mb :Make build<CR>
autocmd FileType d nnoremap <buffer> <Leader>mt :Make test<CR>

" setup :make to qibuild for C files
autocmd Filetype cpp setlocal makeprg=qibuild\ make

" vimux shortcuts
nnoremap <Leader>vp :VixmuxProptCommand<CR>
nnoremap <Leader>vl :VixmuxRunLadCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>

" Termdebug configuration
packadd termdebug

nnoremap <Leader>dd :Termdebug
nnoremap <Leader>dr :Run<CR>

nnoremap <Leader>dn :Over<CR>
nnoremap <Leader>ds :Step<CR>
nnoremap <Leader>df :Finish<CR>
nnoremap <Leader>dc :Continue<CR>

nnoremap <Leader>db :Break<CR>
nnoremap <Leader>dx :Clear<CR>

nnoremap <Leader>de :Evaluate
nnoremap <Leader>dg :Gdb<CR>

