set nocompatible    " required by Vundle
filetype off        " required by Vundle
"set shell=/bin/bash " required by Vundle ENABLE THIS BEFORE CALLING :PluginUpdate/:PluginInstall


" set runtime path to include Vundle and initialize
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'   " color theme
Plugin 'vim-scripts/LustyExplorer'          " file explorer
Plugin 'rking/ag.vim'                       " search plugin
Plugin 'tpope/vim-fugitive'                 " git integration plugin
Plugin 'vim-ruby/vim-ruby'                  " latest vim-ruby plugin
Plugin 'davidhalter/jedi-vim'               " python completion plugin
Plugin 'vim-scripts/a.vim'                  " switch .h <-> .c plugin
Plugin 'Valloric/YouCompleteMe'             " c++ completion plugin
Plugin 'idanarye/vim-dutyl'                 " d completion and tools

" All plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on " required

syntax enable
let g:solarized_termcolors=16
set t_Co=256
set background=dark
"set background=light
colorscheme solarized

set hidden      " required by LustyExplorer

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when we tab complete
set wildmenu

" Display
set title
set number
set ruler
set wrap

" status line
set laststatus=2    " always display status line
set statusline=[%n]\ %<%f\ %{fugitive#statusline()}%h%m%r%=%-14.(%l,%c%V%)\ %P\ %a

set scrolloff=3     " display minimum 3 lines around cursor
set splitbelow

" redefine leader key
let mapleader=','

" configuration for Ag plugin
" place a marker and search
nnoremap <leader>j mA:Ag<space>
" place a marker and search the word under cursor
nnoremap <leader>ja mA:Ag "<C-r>=expand("<cword>")<cr>"
nnoremap <leader>jA mA:Ag "<C-r>=expand("<cWORD>")<cr>"

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
set tabstop=2
" indentation 2 characters
set shiftwidth=2
" C/C++ indentation
set cinoptions+=f0
" D indentation (leave by default, dont let dutyl do it)
let g:dutyl_dontHandleIndent = 1

" A few keybindings
"
" Bubble single lines
nnoremap <C-Up> ddkP
nnoremap <C-Down> ddp
" Bubble multiple lines
vnoremap <C-Up> xkP`[V`]
vnoremap <C-Down> xp`[V`]
" insert blank line without entering insert mode
nnoremap <leader>o o<ESC>
nnoremap <leader>O O<ESC>
" more convenient <esc> in insert mode
inoremap jk <ESC>

" Spell check
cmap spc setlocal spell spelllang=

" Completion
" Ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global=1

" YouCompleteMe
nnoremap <leader>yg :YcmCompleter GoTo<cr>

" setup :make to DUB for D files
autocmd FileType d setlocal makeprg=dub\ build
autocmd FileType d setlocal foldmethod=syntax
autocmd FileType d setlocal efm=%*[^@]@%f\(%l\):\ %m,%f\(%l\\,%c\):\ %m,%f\(%l\):\ %m
" setup :make to qibuild for C files
autocmd FileType cpp setlocal makeprg=qibuild\ make
autocmd FileType cpp setlocal foldmethod=syntax
autocmd FileType c setlocal foldmethod=syntax

" map Space to toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
