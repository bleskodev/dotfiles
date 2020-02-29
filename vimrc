set nocompatible    " required by Vundle
filetype off        " required by Vundle
"set shell=/bin/bash " required by Vundle ENABLE THIS BEFORE CALLING :PluginUpdate/:PluginInstall


" set runtime path to include Vundle and initialize
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'   " color theme
Plugin 'sjbach/lusty'                       " file explorer
Plugin 'rking/ag.vim'                       " search plugin
Plugin 'tpope/vim-fugitive'                 " git integration plugin
Plugin 'tpope/vim-dispatch'                 " make helper plugin
Plugin 'vim-ruby/vim-ruby'                  " latest vim-ruby plugin
Plugin 'davidhalter/jedi-vim'               " python completion plugin
Plugin 'vim-scripts/a.vim'                  " switch .h <-> .c plugin
Plugin 'Valloric/YouCompleteMe'             " c++ completion plugin
Plugin 'idanarye/vim-dutyl'                 " d completion and tools
Plugin 'sirtaj/vim-openscad'                " open-scad syntax plugin
Plugin 'christoomey/vim-tmux-navigator'     " Seamless navigation between tmux panes and vim splits
Plugin 'tmux-plugins/vim-tmux'              " Syntax highlighting for tmux.conf
Plugin 'benmills/vimux'                     " Easily interact with tmux from vim

" All plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on " required

syntax enable
let g:solarized_termcolors=16
set t_Co=256
"set background=dark
set background=light
colorscheme solarized

set hidden      " required by LustyExplorer

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

" deactivate arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop> 
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop> 

" tabs to spaces
set expandtab
" tabs 2 characters
set tabstop=4
" indentation 2 characters
set shiftwidth=4
" C/C++ indentation
"set cinoptions+=f0

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
" Ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global=1

" YouCompleteMe
autocmd Filetype cpp nnoremap <buffer> <Leader>g :YcmCompleter GoTo<cr>
autocmd Filetype c nnoremap <buffer> <Leader>g :YcmCompleter GoTo<cr>

" setup :make to DUB for D files
autocmd FileType d setlocal foldmethod=syntax
autocmd FileType d compiler dub
autocmd FileType d nnoremap <buffer> <Leader>mb :Make build<CR>
autocmd FileType d nnoremap <buffer> <Leader>mt :Make test<CR>
"dutyl setup
let g:dutyl_stdImportPaths=['/usr/include/dlang/dmd']
let g:dutyl_dontHandleIndent = 1 " D indentation (leave by default, dont let dutyl do it)
autocmd Filetype d nnoremap <buffer> <Leader>g :DUjump<cr>

" setup :make to qibuild for C files
autocmd Filetype cpp setlocal makeprg=qibuild\ make
autocmd Filetype cpp setlocal foldmethod=syntax
autocmd Filetype c setlocal foldmethod=syntax

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

