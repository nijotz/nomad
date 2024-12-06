brew_prefix=$(brew --prefix 2>/dev/null)
if [[ "$brew_prefix" ]]; then
  export NVM_DIR="${brew_prefix}/opt/nvm"
elif [[ -f ~/.nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
fi

NVMSH=${NVM_DIR}/nvm.sh

if [[ -f $NVMSH ]]; then
  nomad_log info "found nvm.sh; configuring"
  nomad_echo_and_eval << EOF
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
EOF
else
  nomad_log info "no nvm.sh found; skipping"
fi
