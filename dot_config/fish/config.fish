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

set -g fish_vi_key_bindings

# --- Cursor styles ---
set -gx fish_vi_force_cursor 1
set -gx fish_cursor_default block
set -gx fish_cursor_insert line blink
set -gx fish_cursor_visual block
set -gx fish_cursor_replace_one underscore

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
fish_add_path /Applications/Obsidian.app/Contents/MacOS

auto_theme

function spf
    # 检测 macOS 外观：暗色模式下该命令返回 "Dark"，亮色模式会报错/为空
    set -l config ~/.config/superfile/config.toml # 用 `spf pl` 确认你的真实路径
    if defaults read -g AppleInterfaceStyle 2>/dev/null | string match -q Dark
        sed -i '' 's/^theme = .*/theme = "catppuccin-mocha"/' $config
    else
        sed -i '' 's/^theme = .*/theme = "catppuccin-latte"/' $config
    end
    command spf $argv
end

# bindings
bind \cr _atuin_search
bind -M insert \cr _atuin_search

# Mole shell completion
set -l output (mole completion fish 2>/dev/null); and echo "$output" | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Hermes Agent — ensure ~/.local/bin is on PATH
fish_add_path "$HOME/.local/bin"

# Pi
fish_add_path "/Users/jenkin/.local/share/mise/installs/node/24.21.0/bin"
