############
## PROMPT ##
############
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWUPSTREAM="auto"
GIT_COMPLETION=0
# OS X
if [ `uname` == 'Darwin' ] && [ `which brew` ]; then
    if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ] && [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
        . `brew --prefix`/etc/bash_completion.d/git-completion.bash
        . `brew --prefix`/etc/bash_completion.d/git-prompt.sh
        GIT_COMPLETION=1
    fi
# ArchLinux
elif [ -f /usr/share/git/completion/git-completion.bash ] && [ -f /usr/share/git/completion/git-prompt.sh ]; then
    . /usr/share/git/completion/git-completion.bash
    . /usr/share/git/completion/git-prompt.sh
    GIT_COMPLETION=1
fi

# Calculate minutes since last git commit
minutes_since_last_commit() {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now - last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit / 60))
    echo $minutes_since_last_commit
}

# Add git prompt features if we're in a git directory
# Also adds minutes_since_last_commit
git_prompt() {
    if [[ GIT_COMPLETION -eq 1 ]]; then
        local g="$(__gitdir)"
        if [ -n "$g" ]; then
            local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
            if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
                local COLOR=${txtred}
            elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
                local COLOR=${txtylw}
            else
                local COLOR=${txtgrn}
            fi
            local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${txtgrn}"
            # __git_ps1 is from the Git source tree's contrib/completion/git-completion.bash
            local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
            echo ${GIT_PROMPT}
        fi
    fi
}

# Called after every command to update prompt
update_prompt() {
    #write the current terminal's history to the history file
    #history -n
    history -a
    RET=$?;

    # Set the return symbol
    SPECHARG="☯"
    SPECHARB="✕"
    RET_VALUE="$(if [[ $RET == 0 ]]; then echo -ne "${txtylw}$SPECHARG"; else echo -ne "${txtred}$SPECHARB"; fi;)"

    # Always move cursor back to the start of line
    PS1="\[\033[G\]"
    # Set the title to user@host
    PS1="$PS1${txtylw}┌──"
    local user_color="${txtgrn}"
    if [ `whoami` == 'root' ]; then
        user_color="${blired}"
    fi
    PS1="$PS1${user_color}\[\u\]${txtylw}@${txtwht}\[\h\]"
    #[directory]
    PS1="$PS1${txtgrn}[${txtylw}\w${txtgrn}]"
    # git
    PS1="$PS1${txtgrn}$(git_prompt)"
    # go to next line
    PS1="$PS1${txtylw}\n└─>$RET_VALUE ${txtrst}"
}

PROMPT_COMMAND=update_prompt
