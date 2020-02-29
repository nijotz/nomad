if [ -f $(brew --prefix)/opt/fzf/install ]; then
  nomad_log info "found fzf; configuring"
else
  nomad_log info "fzf not found; skipping"
  exit 0
fi

nomad_echo_and_eval << EOF
# Setup fzf
if [[ ! "\$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="\${PATH}:/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ \$- == *i* ]] && source /usr/local/opt/fzf/shell/completion.bash 2> /dev/null

# Key bindings
source /usr/local/opt/fzf/shell/key-bindings.bash
EOF
