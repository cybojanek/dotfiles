### Configs

Various config files I use for my terminal and programs.

I did **NOT** by any means write all of this on my own. Its been collected over the years from many places on the web.

Thank you to everyone.

### Usage
Source any of the files you want in _bashrc/_, but _colors.sh_ should be first.

### Troubleshooting
Q: When I try to compile a kernel, the ncurses menu is all messed up (_make menuconfig_)

A: If you sourced _grc_, then _make_ was aliased to _grc make_. Remove that alias, or call make with the absolute path
