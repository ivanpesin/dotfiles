syntax on
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

filetype indent on

set nofoldenable foldmethod=indent

set nocompatible
set backspace=indent,eol,start
set nu ruler showcmd
set hidden
set ai ci pi cin cinkeys-=0#
set et sw=2 sts=2 ts=2
set list listchars=tab:»·,trail:·,extends:…,precedes:…
