# ------------------------
# history settings
# ------------------------
# $env.config.history.*
$env.config.history = {
  file_format: sqlite
  max_size: 5_000
  sync_on_enter: true
  isolation: true
}
# ----------------------
# Miscellaneous Settings
# ----------------------

# Disable the welcome banner at startup
$env.config.show_banner = false

# ---------------------------
# Commandline Editor Settings
# ---------------------------

$env.config.edit_mode = "vi" # use vi mode

# Editor
$env.config.buffer_editor = "nvim"

# cursor shape
# "block", "underscore", "line", "blink_block", "blink_underscore", "blink_line", 或 "inherit"
$env.config.cursor_shape.emacs = "inherit" #  emacs mode
$env.config.cursor_shape.vi_insert = "blink_line" #  vi-insert mode
$env.config.cursor_shape.vi_normal = "block" #  normal vi mode

# --------------------
# Completions Behavior
# --------------------
# $env.config.completions.*
# Apply to the Nushell completion system

# algorithm (string): "prefix", "substring" or "fuzzy"
$env.config.completions.algorithm = "prefix"

# result sorted based on their fuzzy score.
$env.config.completions.sort = "smart"

# --------------------
# External Completions
# --------------------
# completions.external.*

# set fish completer
let fish_completer = {|spans|
  fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
  | from tsv --flexible --noheaders --no-infer
  | rename value description
  | update value {|row|
    let value = $row.value
    let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any { $in in $value }
    if ($need_quote and ($value | path exists)) {
      let expanded_path = if ($value starts-with ~) { $value | path expand --no-symlink } else { $value }
      $'"($expanded_path | str replace --all "\"" "\\\"")"'
    } else { $value }
  }
}

# set carapace completer
let carapace_completer = {|spans: list<string>|
  carapace $spans.0 nushell ...$spans
  | from json
  | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

# Multiple completer
# Default use carapace
let external_completer = {|spans|
  let expanded_alias = scope aliases
  | where name == $spans.0
  | get -o 0.expansion

  let spans = if $expanded_alias != null {
    $spans
    | skip 1
    | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }

  match $spans.0 {
    git => $fish_completer
    mise => $fish_completer
    asdf => $fish_completer
    _ => $carapace_completer
  } | do $in $spans
}

$env.config = {
  completions: {
    external: {
      enable: true # enable external completions
      completer: $external_completer
    }
  }
}

# -------------
# Table Display
# -------------

$env.config.footer_mode = "auto"

# table theme/mode

$env.config.table.mode = "rounded"

# show column index
$env.config.table.index_mode = "always"

# show empty
$env.config.table.show_empty = true

# padding in each column
$env.config.table.padding.left = 1
$env.config.table.padding.right = 1

# trim.*: How to display content
#         when exceed the terminal width.
$env.config.table.trim = {
  methodology: "truncating"
  truncating_suffix: "..."
}

# header not on separator:
$env.config.table.header_on_separator = false

# -----------
# Keybindings
# -----------
# keybindings (list): A list of user-defined keybindings

$env.config.keybindings ++= [
  {
    name: modechange
    modifier: control
    keycode: "char_["
    mode: [vi_normal vi_insert]
    event: {send: vichangemode mode: normal}
  }
]

# ---------------------------------------------------------------------------------------
# Environment Variables
# ---------------------------------------------------------------------------------------

# PROMPT_*
# --------
# Prompt configuration

# PROMPT_COMMAND
# --------------
# $env.PROMPT_COMMAND = "Nushell"
# Simple example - Dynamic closure displaying the path:
# $env.PROMPT_COMMAND = {|| pwd}

# PROMPT_INDICATOR*
# -----------------
# The prompt indicators are environmental variables that represent
# the state of the prompt. The specified character(s) will appear
# immediately following the PROMPT_COMMAND

# When in Emacs mode (default):
$env.PROMPT_INDICATOR = "> "

# When in normal vi mode:
$env.PROMPT_INDICATOR_VI_NORMAL = "> "
# When in vi insert-mode:
$env.PROMPT_INDICATOR_VI_INSERT = ": "

# When a commandline extends across multiple lines:
$env.PROMPT_MULTILINE_INDICATOR = "::: "

$env.path ++= ["/usr/local/bin" "~/.cargo/bin" "/opt/homebrew/bin"]

$env.TOPIARY_CONFIG_FILE = "/Users/jenkin/topiary-nushell/languages.ncl"
$env.TOPIARY_LANGUAGE_DIR = "/Users/jenkin/topiary-nushell/languages"
source ./catppuccin_mocha.nu
