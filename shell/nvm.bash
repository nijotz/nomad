brew_prefix=$(brew --prefix 2>/dev/null)
if [[ "$brew_prefix" ]]; then
  NVMSH=$(brew --prefix)/opt/nvm/nvm.sh
elif [[ -f ~/.nvm/nvm.sh ]]; then
  NVMSH=~/.nvm/nvm.sh
fi

if [[ -f $NVMSH ]]; then
  nomad_log info "found nvm.sh; configuring"
  nomad_echo_and_eval << EOF
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF
else
  nomad_log info "no nvm.sh found; skipping"
  exit 0
fi
