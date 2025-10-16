module completions {
  # check for updates to globally installed Cargo packages
  export extern "cargo-fresh" [
    --verbose (-v) # show detailed information
    --updates-only (-u) # only show packages with available updates
    --no-interactive # not interactive mode (default: interactive mode)
    --include-prerelease # include-prerelease（alpha、beta、rc等）
    --help (-h) # Print help
    --version (-V) # Print version
    ...args: string
  ]

  def "nu-complete cargo-fresh completion shell" [] {
    ["bash" "zsh" "fish" "powershell" "elvish" "nushell"]
  }

  # generate shell completion scripts
  export extern "cargo-fresh completion" [
    shell: string@"nu-complete cargo-fresh completion shell"
    --help (-h) # Print help (see more with '--help')
  ]
}

export use completions *
