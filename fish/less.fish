##########
## LESS ##
##########
set -xg LESS_TERMCAP_mb (echo -e '\e[01;31m')       # begin blinking
set -xg LESS_TERMCAP_md (echo -e '\e[01;38;5;33m')  # begin bold
set -xg LESS_TERMCAP_me (echo -e '\e[0m')           # end mode
set -xg LESS_TERMCAP_se (echo -e '\e[0m')           # end standout-mode
set -xg LESS_TERMCAP_so (echo -e '\e[38;5;136m')    # begin standout-mode - info box
set -xg LESS_TERMCAP_ue (echo -e '\e[0m')           # end underline
set -xg LESS_TERMCAP_us (echo -e '\e[04;38;5;57m')  # begin underline
