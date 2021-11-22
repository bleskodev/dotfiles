" Vim compiler file
" Compiler: dub
" Maintainer: Blesko Dev
" Last Change: 2019 Dec 19

if exists("current_compiler")
  finish
endif
let current_compiler = "dub"

CompilerSet makeprg=dub
CompilerSet errorformat=%*[^@]@%f\(%l\):\ %m,%f\(%l\\,%c\):\ %m,%f\(%l\):\ %m,%f:%l\ -\ %m
