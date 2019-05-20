if command -v pyenv > /dev/null; then
  nomad_log info "found pyenv; configuring"
else
  exit 0
fi

pyenv_root=$(pyenv root)
if [[ -z "$pyenv_root" ]]; then
  nomad_log error "could not find pyenv root"
  exit 1
fi

nomad_echo_and_eval << EOF
$(pyenv init - --no-rehash)
$(pyenv virtualenv-init -)
EOF
