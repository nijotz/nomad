# Specific to homebrew
NVMSH=/usr/local/opt/nvm/nvm.sh
if [ -f $NVMSH ]; then
  nomad_log info "found nvm.sh; configuring"
else
  nomad_log info "no nvm.sh found; skipping"
  exit 0
fi

nomad_echo_and_eval << EOF
export NVM_DIR=$HOME/.nvm
source $NVMSH
EOF
