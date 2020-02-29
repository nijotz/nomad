if command -v rbenv > /dev/null; then
  nomad_log info "found rbenv; configuring"
else
  exit 0
fi

nomad_echo_and_eval << EOF
$(rbenv init -)
EOF
