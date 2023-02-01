if type brew &>/dev/null
then
  nomad_log info "found homebrew binary; configuring"
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    echo source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" | nomad_echo_and_eval
  else
    nomad_echo_and_eval << EOF
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
EOF
  fi
fi

${HOMEBREW_PREFIX}/bin/brew shellenv | nomad_echo_and_eval
