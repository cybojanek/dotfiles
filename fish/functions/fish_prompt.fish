# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_dirtystate green
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_stashstate green
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind green
set __fish_git_prompt_color_upstream_equal green
set __fish_git_prompt_color_upstream green
set __fish_git_prompt_color_upstream_done green
set __fish_git_prompt_color_bare green
set __fish_git_prompt_color_merging red

function fish_prompt --description 'Write out the prompt'
    # Exit code from previous command
    set -l last_status $status
    if test $status -eq 0
        set -g __fish_prompt_exit_status (set_color green)"\$"
    else
        set -g __fish_prompt_exit_status (set_color red)$last_status
    end
    # Store previous exit code
    set -l last_status $status

    # Refresh titlebar color
    echo -e -n $__fish_title_color

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (echo -n -e "\e[38;5;"(\
            __hostname_hash_color)"m")(hostname)(set_color normal)
    end

    # Current directory
    set -g __fish_prompt_cwd (set_color green)"["(set_color yellow)(\
        echo $PWD | sed -e "s|^$HOME|~|")(set_color green)"]"(set_color normal)

    set -g __fish_prompt_cwd_short (set_color green)"["(set_color yellow)(\
        prompt_pwd)(set_color green)"]"(set_color normal)

    # User color
    switch $USER
      case root
        set -g __fish_prompt_user (set_color red)"root"
      case '*'
        set -g __fish_prompt_user (set_color green)$USER
    end

    # (time)
    set -l prompt_time " "(set_color purple)"("(date "+%H:%M")")"(set_color normal)

    # virtual env
    if set -q VIRTUAL_ENV
        set prompt_venv " "(set_color -u green )"("(basename "$VIRTUAL_ENV")")"(set_color normal)
    else
        set prompt_venv ""
    end

    # git
    set -l prompt_git (__fish_git_prompt)

    # .--user@hostname
    set -l prompt_host (set_color yellow)".--"$__fish_prompt_user(set_color yellow)"@"$__fish_prompt_hostname
    # (time) (virtual env) (git)
    set -l prompt_stat "$prompt_time$prompt_venv$prompt_git"

    set -l prompt_long "$prompt_host$__fish_prompt_cwd$prompt_stat"
    set -l prompt_short "$prompt_host$__fish_prompt_cwd_short$prompt_stat"

    if test (tput cols) -le (echo -e -n $prompt_long | gsed -r "s:\x1B(\[[0-9;]*[mK]|\(B)::g" | wc -c)
        echo -e $prompt_short
    else
        echo -e $prompt_long
    end

    # '->'
    echo -e -n -s (set_color yellow)"'->"
    # exit status
    echo -n -s $__fish_prompt_exit_status " "

end
