# Glorious 256 color
alias tmux="TERM=xterm-256color tmux"

# Secret tmux magic
settitle() {
  printf "\033k$*\033\\"
}

# Parse anything that can be passed to remote shell commands, including flags
# and the hostname, and just return what tmux should display as the window name
parse_host() {
  sed_statements[0]='s/-p *[0-9]*//g'    # ignore port flag
  sed_statements[1]='s/-A//g'            # ignore agent forwarding flag
 #sed_statements[2]='s/[^ @]*@//g'       # ignore usernames
  sed_statements[2]="s/${USER}@//g"      # ignore username if same
  sed_statements[3]="s/$1[ ]*//g"        # ignore the actual command
  sed_statements[3]="s:-i .*/(.*):-i \1:g" # condense -i filepath

  # ignore the last domain if there is more than one, it's usually unimportant
  sed_statements[4]='s/([a-zA-Z\-\.]+)\.[a-zA-Z\-]+/\1/g'

  sed_arguments=""
  for i in $(seq 0 $((${#sed_statements[@]} - 1))); do
    sed_arguments="${sed_arguments} -e '${sed_statements[$i]}'"
  done

  echo "${*:2}" | eval sed -r $sed_arguments
}

# Wrap remote shell commands with a function that renames tmux windows with
# condensed information about the remote shell
remote_shell_wrapper() {
  # If a Ctrl-C is ever sent, make sure tmux window naming goes back to the
  # default.  This fixes the window name not reverting when Ctrl-C'ing during
  # password input for ssh.
  trap 'tmux set-window-option automatic-rename on > /dev/null' 2

  settitle $(parse_host $*)
  command $1 ${*:2}

  # revert tmux window name to default
  tmux set-window-option automatic-rename on > /dev/null
}

# Commands to wrap
ssh() {
  remote_shell_wrapper ssh "$@"
}

mosh() {
  remote_shell_wrapper mosh "$@"
}
