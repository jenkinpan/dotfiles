status is-interactive; or exit

# remove greeting
set -g fish_greeting

# Path
set -x fish_user_paths
fish_add_path /opt/homebrew/bin $PATH
fish_add_path ~/.cargo/bin $PATH
fish_add_path /opt/homebrew/sbin $PATH

# Cursor styles
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block blink
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

set -gx LANG zh_CN.UTF-8
set -gx LANGUAGE zh_CN:en_US
set -gx LC_ALL zh_CN.UTF-8
set -gx LC_MESSAGES zh_CN.UTF-8

# Nubind atuin default keybindings
set -gx ATUIN_NOBIND true

# Alias
alias cls='clear'
# Enhanced ls with eza
alias ls='eza --icons --group-directories-first --color=always --time-style=long-iso'
alias ll='ls -lh' # Detailed list
alias la='ll -a' # Show hidden files
alias lla='ls -a' # Simple show all files
alias lg='lazygit'

starship init fish | source
zoxide init --cmd cd fish | source
atuin init fish | source
mise activate fish | source
fzf --fish | source

auto_theme

# bindings
bind \cr _atuin_search
bind -M insert \cr _atuin_search

# Show system info on startup
fastfetch --config examples/14
