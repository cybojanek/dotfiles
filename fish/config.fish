# Welcome message
set -xg fish_greeting ""

# TERM variable
set -xg TERM "xterm-256color"

# Command shortcuts
alias grep 'grep --color=auto'
alias less 'less -R'
alias ls 'gls --color=auto'
alias cat 'lolcat'
alias .. 'cd ..'
alias diff 'colordiff'
alias sort 'gsort'
alias sublime 'open -a Sublime\ Text\ 2.app'
alias love "/Applications/love.app/Contents/MacOS/love"

# Dircolors
eval (gdircolors -c ~/.dir_colors)

# PATH
# gcc linux cross compiler
set -xg PATH "/usr/local/gcc-4.8.0-for-linux64/bin/" $PATH
# ruby
set -xg PATH "/usr/local/opt/ruby193/bin" $PATH
# latex
set -xg PATH "/usr/texbin" $PATH
# local
set -xg PATH "/usr/local/bin" $PATH
set -xg PATH "/usr/local/sbin" $PATH
# dotfiles
set -xg PATH "~/repos/github/dotfiles/bin" $PATH

# ENV preferences
set -xg NODE_REDNOSE 1
set -xg EDITOR vim
set -xg PAGER less

# Pokeme
set -xg POKEME_PUSHOVER_TOKEN ""
set -xg POKEME_PUSHOVER_USER ""
set -xg POKEME_NC ""
set -xg POKEME_GROWL ""
