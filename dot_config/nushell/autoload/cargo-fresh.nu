module completions {

  # Check and update globally installed Cargo packages
  export extern cargo-fresh [
    --verbose(-v): string     # Show detailed information
    --updates-only(-u): string # Show only packages with updates
    --no-interactive: string  # Non-interactive mode (default is interactive mode)
    --include-prerelease: string # Include prerelease versions (alpha, beta, rc, etc.)
    --batch: string           # Batch mode - automatically update all packages without confirmation
    --filter: string          # Filter packages by name pattern (supports glob patterns)
    --help(-h)                # Print help
  ]

  def "nu-complete cargo-fresh completion shell" [] {
    [ "bash" "zsh" "fish" "powershell" "elvish" "nushell" ]
  }

  # Generate shell completion scripts
  export extern "cargo-fresh completion" [
    shell?: string@"nu-complete cargo-fresh completion shell" # Shell to generate completion script for
    --cargo-fresh             # Generate completion for cargo fresh subcommand
    --help(-h)                # Print help (see more with '--help')
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "cargo-fresh help" [
  ]

  # Generate shell completion scripts
  export extern "cargo-fresh help completion" [
  ]

  # Print this message or the help of the given subcommand(s)
  export extern "cargo-fresh help help" [
  ]

}

export use completions *
