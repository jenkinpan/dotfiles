status is-interactive; or exit

# --- Basic Settings ---
set -g fish_greeting
set -gx LANG zh_CN.UTF-8
set -gx LANGUAGE zh_CN:en_US
set -gx LC_ALL zh_CN.UTF-8
set -gx LC_MESSAGES zh_CN.UTF-8

# --- Editor ---
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR

# --- Cursor styles ---
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore
set -g fish_vi_key_bindings

# Nubind atuin default keybindings
set -gx ATUIN_NOBIND true

# --- Aliases ---
alias cls='clear'
# Enhanced ls with eza
alias ls='eza --icons --group-directories-first --color=always --time-style=long-iso'
alias ll='ls -lh' # Detailed list
alias la='ll -a' # Show hidden files
alias lla='ls -a' # Simple show all files
if type -q lazygit
    alias lg='lazygit'
end

atuin init fish | source
fzf --fish | source
zoxide init --cmd cd fish | source
starship init fish | source

# --- Homebrew ---
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
set -gx HOMEBREW_NO_ENV_HINTS 1

# --- Path ---
fish_add_path ~/.cargo/bin ~/.bun/bin

auto_theme

# bindings
bind \cr _atuin_search
bind -M insert \cr _atuin_search
