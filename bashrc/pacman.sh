##########
# Pacman #
##########
alias pacman='pacman-color'
alias pac="sudo pacman-color -S"      # default action     - install one or more packages
alias pacu="sudo pacman-color -Syu"   # '[u]pdate'         - upgrade all packages to their newest version
alias pacs="pacman-color -Ss"         # '[s]earch'         - search for a package using one or more keywords
alias paci="pacman-color -Si"         # '[i]nfo'           - show information about a package
alias pacr="sudo pacman-color -R"     # '[r]emove'         - uninstall one or more packages
alias pacl="pacman-color -Sl"         # '[l]ist'           - list all packages of a repository
alias pacll="pacman-color -Qqm"       # '[l]ist [l]ocal'   - list all packages which were locally installed (e.g. AUR packages)
alias paclo="pacman-color -Qdt"       # '[l]ist [o]rphans' - list all packages which are orphaned
alias paco="pacman-color -Qo"         # '[o]wner'          - determine which package owns a given file
alias pacf="pacman-color -Ql"         # '[f]iles'          - list all files installed by a given package
alias pacc="sudo pacman-color -Sc"    # '[c]lean cache'    - delete all not currently installed package files
alias pacm="makepkg -fci"             # '[m]ake'           - make package from PKGBUILD file in current directory