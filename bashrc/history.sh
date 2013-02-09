#################
## CLI History ##
#################
stty stop undef                                 #forward search
export HISTSIZE=100000                          #bash history will save this many commands.
export HISTFILESIZE=${HISTSIZE}                 #bash will remember this many commands.
export HISTCONTROL=ignoredups                   #ignore duplicate commands
export HISTIGNORE="ls:pwd:exit:clear"           #don't put this in the history.
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "  # log format
shopt -s cmdhist                                #save multi-line commands as a single line in the history.
shopt -s expand_aliases                         #expand aliases in this file.
shopt -s histappend                             #append to the history file instead of overwriting