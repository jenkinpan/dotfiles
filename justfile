sys-info:
   @echo "This is an {{ arch() }} Mac."

cache-clean:
   cargo cache -a
   brew cleanup

check-updates:
   brew outdated
   rustup check


