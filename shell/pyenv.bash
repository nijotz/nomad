export PYENV_ROOT="$HOME/.pyenv"
if [[ -z "$PYENV_ROOT" ]]; then
  nomad_log info "could not find pyenv root; exiting"
  exit 0
fi

nomad_log info "found pyenv root; configuring"

cat << EOF
export PYENV_ROOT="$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
