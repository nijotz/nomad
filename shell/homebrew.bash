nomad_echo_and_eval << EOF
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:\$PATH
EOF

brew_prefix=$(brew --prefix)
if [[ -z "$brew_prefix" ]]; then
  nomad_log info "homebrew binary not found"
  exit 0
fi
nomad_log info "found homebrew binary; looking for completion dir"

bash_completion_dir="$brew_prefix/etc/bash_completion"
if [[ ! -d "$bash_completion_dir" && ! -L "$bash_completion_dir" ]]; then
  nomad_log info "completion dir not found"
  exit
fi

nomad_log info "completion dir found; adding to rc"
nomad_echo_and_eval << EOF
source $(brew --prefix)/etc/bash_completion
EOF
