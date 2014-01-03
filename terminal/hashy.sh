#!/bin/bash
MD5="md5sum"
if [[ `uname` == 'Darwin' ]]; then MD5="md5" ; fi
HASH=`hostname -s | ${MD5}`
echo -n -e     "\033]6;1;bg;red;brightness;$((0x${HASH:0:2}))\a\033]6;1;bg;green;brightness;$((0x${HASH:2:2}))\a\033]6;1;bg;blue;brightness;$((0x${HASH:4:2}))\a"
