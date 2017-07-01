alias grep='grep --color=auto'
if [ $(uname -s) == 'Darwin' ] && [ $(which ls) != '/bin/ls' ]; then
  alias ls='ls --color=auto'
fi
