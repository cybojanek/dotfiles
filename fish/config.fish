# Welcome message
setenv fish_greeting ""

# TERM variable
setenv TERM "xterm-256color"

# Command shortcuts
alias grep 'grep --color=auto'
alias less 'less -R'
alias ls 'gls --color=auto -F'
alias cat 'lolcat'
alias .. 'cd ..'
alias diff 'colordiff'
alias sort 'gsort'
alias sublime 'open -a Sublime\ Text\ 2.app'
alias love "/Applications/love.app/Contents/MacOS/love"
alias remake "make clean; and make -j2"

# Dircolors
eval (gdircolors -c ~/.dir_colors)

# PATH
# gcc linux cross compiler
setenv PATH "/usr/local/gcc-4.8.1-for-linux64/bin" $PATH
# ruby
setenv PATH "/usr/local/opt/ruby193/bin" $PATH
setenv PATH "/usr/local/opt/ruby/bin" $PATH
# latex
setenv PATH "/usr/texbin" $PATH
# local
setenv PATH "/usr/local/bin" $PATH
setenv PATH "/usr/local/sbin" $PATH
# dotfiles
setenv PATH "/Users/cybojanek/repos/github/dotfiles/bin" $PATH
setenv PATH "/Users/cybojanek/bin" $PATH

# ENV preferences
setenv NODE_REDNOSE 1
setenv EDITOR vim
setenv PAGER less

# Pokeme
setenv POKEME_PUSHOVER_TOKEN ""
setenv POKEME_PUSHOVER_USER ""
setenv POKEME_NC ""
setenv POKEME_GROWL ""

for x in less grc
	. ~/repos/github/dotfiles/fish/$x.fish
end

# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish
