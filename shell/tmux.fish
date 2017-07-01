# Glorious 256 color
alias tmux='env TERM=xterm-256color tmux'

function settitle
  printf "\033k$argv\033\\ "
end

function parse_host
  # Parse anything that can be passed to the command, including flags and the
  # hostname, and just return what tmux should display as the window name

  set regex = ''
  set regex = $regex 's/-p *[0-9]*//g'      # ignore port flag
  set regex = $regex 's/-A//g'              # ignore agent forwarding flag
 #set regex = $regex 's/[^ @]*@//g'         # ignore usernames
  set regex = $regex 's/$USER@//g'          # ignore username if same
  set regex = $regex 's/$1[ ]*//g'          # ignore the actual command
  set regex = $regex 's:-i .*/(.*):-i \1:g' # condense -i filepath

  # ignore the last domain if there is more than one, it's usually unimportant
  set sed_statements[5] 's/([a-zA-Z\-\.]+)\.[a-zA-Z\-]+/\1/g'

  set sed_arguments ""
  for regex in $sed_statements
    set sed_arguments "$sed_arguments -e '$regex'"
  end

  echo $argv[2..-1] | eval sed -r $sed_arguments
end

function remote_shell_wrapper
  # If a Ctrl-C is ever sent, make sure tmux window naming goes back to the
  # default.  This fixes the window name not reverting when Ctrl-C'ing during
  # password input for ssh.
  function tmux_default_naming --on-signal INT
    tmux set-window-option automatic-rename on > /dev/null
  end

  settitle (parse_host $argv)
  eval (command -s $argv[1]) $argv[2..-1]

  # revert tmux window name to default
  tmux set-window-option automatic-rename on > /dev/null
end

function ssh
  remote_shell_wrapper ssh "$argv"
end

function mosh
  remote_shell_wrapper mosh "$argv"
end
