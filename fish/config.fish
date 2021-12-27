set -x PATH $PATH $HOME/.opt/bin
set -x FD_OPTIONS '--type f --hidden --follow --exclude .git'
set -x FZF_DEFAULT_COMMAND fd $FD_OPTIONS
#set -x FZF_CTRL_T_COMMAND fd \$dir $FD_OPTIONS
set -x FZF_DEFAULT_OPTS '--layout=reverse --height 50% --multi'
