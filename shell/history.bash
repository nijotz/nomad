# The default history settings are set to 500 lines for the file size.  If these
# configs don't ever load for some reason, the default will remove all history
# except the last 500 lines.  I don't want that so I'm moving the history file
# to a different locaiton.
export HISTFILE=~/.bash_history_all

# Unlimited history. Storage is cheap
export HISTFILESIZE=
export HISTSIZE=

# Store timestamps in the history file
export HISTTIMEFORMAT='%F %T '

# Append bash history to history file after very command.  History from other
# bash sessions can be loaded into the current session using 'history -n'
# I had 'history -n' in the PROMPT_COMMAND as well, but it became annoying
# having history from other bash sessions pop up in my current session
# unexpectedely.  I'd rather do a 'history -n' manually when I need history from
# other sessions.
export PROMPT_COMMAND="history -a"

# Append to history file rather than overwrite
shopt -s histappend
