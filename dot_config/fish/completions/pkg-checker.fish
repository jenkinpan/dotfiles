# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_pkg_checker_global_optspecs
	string join \n v/verbose u/updates-only no-interactive include-prerelease h/help V/version
end

function __fish_pkg_checker_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_pkg_checker_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_pkg_checker_using_subcommand
	set -l cmd (__fish_pkg_checker_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -s v -l verbose -d '显示详细信息'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -s u -l updates-only -d '只显示有更新的包'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -l no-interactive -d '非交互模式（默认是交互模式）'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -l include-prerelease -d '包含预发布版本（alpha、beta、rc等）'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -s h -l help -d 'Print help'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -s V -l version -d 'Print version'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -f -a "completion" -d '生成 shell 补全脚本'
complete -c pkg-checker -n "__fish_pkg_checker_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -s h -l help -d 'Print help (see more with \'--help\')'
# 添加 shell 选项补全
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "bash" -d 'Bash shell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "zsh" -d 'Zsh shell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "fish" -d 'Fish shell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "powershell" -d 'PowerShell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "elvish" -d 'Elvish shell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand completion" -f -a "nushell" -d 'Nushell'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand help; and not __fish_seen_subcommand_from completion help" -f -a "completion" -d '生成 shell 补全脚本'
complete -c pkg-checker -n "__fish_pkg_checker_using_subcommand help; and not __fish_seen_subcommand_from completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
