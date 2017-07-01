if command -v pyenv > /dev/null; then
  nomad_log info "found pyenv; configuring"
else
  exit 0
fi

nomad_echo_and_eval << EOF
$(pyenv init -)
$(pyenv virtualenv-init -)
EOF
