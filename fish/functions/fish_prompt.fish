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

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (echo -n -e "\e[38;5;"(__hostname_hash_color)"m")(hostname)(set_color normal)
    end

    # Current directory
    set -g __fish_prompt_cwd (set_color green)"["(set_color yellow)(echo $PWD | sed -e "s|^$HOME|~|")(set_color green)"]"

    # User color
    switch $USER
      case root
        set -g __fish_prompt_user (set_color red)"root"
      case '*'
        set -g __fish_prompt_user (set_color green)$USER
    end

    # Deliminator between user and host
    set -l __fish_user_host_delim (set_color yellow)"@"

    # .--user@hostname
    echo -n -s (set_color yellow)".--" "$__fish_prompt_user" "$__fish_user_host_delim" "$__fish_prompt_hostname"
    # [cwd]
    echo -n -s "$__fish_prompt_cwd"
    # virtual env
    if set -q VIRTUAL_ENV
        echo -n -s " " (set_color -u green ) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal)
    end
    # git
    echo -n -s (set_color normal)(__fish_git_prompt)
    # newline
    echo -e -n -s "\n"
    # '->'
    echo -n -s (set_color yellow)"'->"
    # exit status
    echo -n -s $__fish_prompt_exit_status " "

end
