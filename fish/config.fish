# Welcome message
setenv fish_greeting ""

# TERM variable
setenv TERM "xterm-256color"

# Dircolors
if test -e ~/.dir_colors
    switch (uname)
        case Darwin
            eval (gdircolors -c ~/.dir_colors)

        case Linux
            eval (dircolors -c ~/.dir_colors)
    end
end

# Load dotfile extensions
set -l dotfile_root  ~/repos/github/dotfiles
set -l dotfile_fish_extensions less colors
if test (type -t grc) = file
    set dotfile_fish_extensions $dotfile_fish_extensions grc
end
switch (uname)
    case Darwin

    case Linux
        set dotfile_fish_extensions $dotfile_fish_extensions apt pacman
end
for x in $dotfile_fish_extensions
    . $dotfile_root/fish/$x.fish
end

# Load fishmarks (http://github.com/techwizrd/fishmarks)
if test -e $HOME/.fishmarks/marks.fish
    . $HOME/.fishmarks/marks.fish
end

# Load virtualfish (https://github.com/adambrenecki/virtualfish)
set -l virtualfish_root ~/repos/github/virtualfish/
set -l virtual_fish_extensions virtual auto_activation global_requirements
for x in $virtual_fish_extensions
    . $virtualfish_root/$x.fish
end

# PATH
setenv PATH "$dotfile_root/bin" $PATH
setenv PATH "~/bin" $PATH
switch (uname)
    case Darwin
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

    case Linux

end

# Command shortcuts
switch (uname)
    case Darwin
        alias ls 'gls --color=auto -F'
        alias sort 'gsort'
        alias sublime 'open -a Sublime\ Text\ 2.app'
        alias love "/Applications/love.app/Contents/MacOS/love"

    case Linux
        alias ls 'ls --color=auto -F'

end
alias grep 'grep --color=auto'
alias less 'less -R'
alias .. 'cd ..'
alias remake "make clean; and make -j2"
if test (type -t lolcat) = file
    alias cat 'lolcat'
end
if test (type -t colordiff) = file
    alias diff 'colordiff'
end

# ENV preferences
setenv NODE_REDNOSE 1
setenv EDITOR vim
setenv PAGER less

# Pokeme
setenv POKEME_PUSHOVER_TOKEN ""
setenv POKEME_PUSHOVER_USER ""
setenv POKEME_NC ""
setenv POKEME_GROWL ""

# Titlebar color
if status -i
    set -l c ( __hostname_hash_color )
    set -l r $__fish_ansi_to_rgb_r[( math $c + 1)]
    set -l g $__fish_ansi_to_rgb_g[( math $c + 1)]
    set -l b $__fish_ansi_to_rgb_b[( math $c + 1)]

    set -g __fish_title_color "\e]6;1;bg;red;brightness;$r\a\r\e]6;1;bg;green;brightness;$g\a\r\e]6;1;bg;blue;brightness;$b\a\r"
end
