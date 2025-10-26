mkdir ($nu.data-dir | path join "vendor/autoload")
# Startship init
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# Zoxide init
zoxide init --cmd cd nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
# Mise init
mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")
# Atuin Init remove Atuin as it can be replaced by nushell default history search
# atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/atuin.nu")

# aliases
alias cls = clear

# list files
alias ll = ls -l
alias la = ls -a
alias lla = ls -la

# config alias
alias cnu = config nu # config config.nu
alias cen = config env # config env.nu

# lg to open LazyGit if installed
def lg [] { if (which lazygit | is-not-empty) { lazygit } }

# Show system info on startup
fastfetch --config examples/14
