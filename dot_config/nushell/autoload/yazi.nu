# Yazi file manager integration for Nushell
# This module provides seamless integration with Yazi, allowing you to change
# directories to the location you navigated to in Yazi when you exit.
#
# Based on the official Yazi documentation:
# https://yazi-rs.github.io/docs/quick-start#shell-wrapper

# yy - Open Yazi and change to the directory you navigated to
# This function mimics the behavior of the yy function in zsh/bash
# Usage: yy [path] - optionally specify a starting path
#
# The --env flag is crucial here as it allows the function to modify
# the environment (including the current directory) of the calling shell
export def --env yy [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}
