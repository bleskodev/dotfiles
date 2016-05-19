set nocompatible		" required
filetype off			  " required

" set runtime path to include Vundle and initialize
set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'	  " color theme
Plugin 'vim-scripts/LustyExplorer'		      " file explorer
Plugin 'rking/ag.vim'				                " search plugin
Plugin 'astashov/vim-ruby-debugger'		      " ruby debugger plugin
Plugin 'tpope/vim-fugitive'			            " git integration plugin

" All plugins must be added before the following line
call vundle#end() 		    " required
filetype plugin indent on	" required

syntax enable
let g:solarized_termcolors=16
set t_Co=256
set background=dark
"set background=light
colorscheme solarized

set hidden			" required by LustyExplorer

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

set scrolloff=3			" display minimum 3 lines around cursor
set splitbelow

" redefine leader key
let mapleader=','

" configuration for Ag plugin
" place a marker and search
nmap <leader>j mA:Ag<space>
" place a marker and search the word under cursor
nmap <leader>ja mA:Ag "<C-r>=expand("<cword>")<cr>"
nmap <leader>jA mA:Ag "<C-r>=expand("<cWORD>")<cr>"

" deactivate arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop> 
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop> 

" tabs to spaces
set expandtab
" tabs 2 characters
set tabstop=2
" indentation 2 characters
set shiftwidth=2

" A few keybindings
"
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" Spell check
cmap spc setlocal spell spelllang=

