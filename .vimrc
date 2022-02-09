set number

syntax on
filetype plugin indent on

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'xarthurx/taskwarrior.vim'

call plug#end()

let g:task_rc_override = 'rc.defaultheight=0'
let g:task_rc_override = 'rc.defaultwidth=0'

syntax off
command TWT :TW limit:30 -WORK project.not:WORK -work
command TWI :TW rc.context=none \(project.not:WORK and -WORK and -work  and \(+in or +inthe or +hass or -PROJECT\)\)



