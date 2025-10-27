status is-interactive; or exit

# remove greeting
set -g fish_greeting

# Path
set -x fish_user_paths
fish_add_path /opt/homebrew/bin $PATH
fish_add_path ~/.cargo/bin $PATH
fish_add_path /opt/homebrew/sbin $PATH
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path ~/.bun/bin

# Cursor styles
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

set -gx fish_vi_key_bindings

# editor
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

# language
set -gx LANG zh_CN.UTF-8
set -gx LANGUAGE zh_CN:en_US
set -gx LC_ALL zh_CN.UTF-8
set -gx LC_MESSAGES zh_CN.UTF-8

# homebrew hint
set -gx HOMEBREW_NO_ENV_HINTS 1

# Nubind atuin default keybindings
set -gx ATUIN_NOBIND true

# Alias
alias cls='clear'
# Enhanced ls with eza
alias ls='eza --icons --group-directories-first --color=always --time-style=long-iso'
alias ll='ls -lh' # Detailed list
alias la='ll -a' # Show hidden files
alias lla='ls -a' # Simple show all files
if type -q lazygit
    alias lg='lazygit'
end

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
fastfetch --logo none --config examples/13

eval "$(/opt/homebrew/bin/brew shellenv)"
