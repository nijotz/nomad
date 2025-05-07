brew_prefix=$(brew --prefix 2>/dev/null)
if [[ -z "$brew_prefix" ]]; then
  nomad_log info "homebrew binary not found"
  exit 0
fi

nomad_log info "found homebrew binary; configuring coreutils"

nomad_echo_and_eval << EOF
# I'm used to the GNU version of utils
export PATH=$(brew --prefix coreutils)/libexec/gnubin:\$PATH

# Need the man pages for the GNU coreutils
export MANPATH=$(brew --prefix coreutils)/libexec/gnuman:\$MANPATH
EOF
