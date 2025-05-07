brew_prefix=$(brew --prefix 2>/dev/null)
if [[ -z "$brew_prefix" ]]; then
  nomad_log info "homebrew binary not found"
  exit 0
fi

nomad_log info "found homebrew binary; configuring"
if [[ -r "$brew_prefix/etc/profile.d/bash_completion.sh" ]]; then
  echo source "$brew_prefix/etc/profile.d/bash_completion.sh" | nomad_echo_and_eval
else
  nomad_echo_and_eval << EOF
    for COMPLETION in "$brew_prefix/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
EOF
fi

echo export PATH=$(brew --prefix)/bin:\$PATH | nomad_echo_and_eval
echo 'eval "$(brew shellenv)"' | nomad_echo_and_eval
