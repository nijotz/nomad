HOMEBREW_PREFIX=$(brew --prefix)

if [ -f ${HOMEBREW_PREFIX}/opt/fzf/install ]; then
  nomad_log info "found fzf; configuring"
else
  nomad_log info "fzf not found; skipping"
  exit 0
fi

nomad_echo_and_eval << EOF
# Setup fzf
if [[ ! "\$PATH" == *${HOMEBREW_PREFIX}/opt/fzf/bin* ]]; then
  export PATH="\${PATH}:${HOMEBREW_PREFIX}/opt/fzf/bin"
fi

# Auto-completion
[[ \$- == *i* ]] && source ${HOMEBREW_PREFIX}/opt/fzf/shell/completion.bash 2> /dev/null

# Key bindings
source ${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.bash
EOF
