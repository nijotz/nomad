brew_prefix=$(brew --prefix 2>/dev/null)
if [[ -z "$brew_prefix" ]]; then
  nomad_log info "homebrew binary not found"
  exit 0
fi

nomad_log info "found homebrew binary; configuring GNU sed"

nomad_echo_and_eval << EOF
# I don't want to have to type 'gsed'
export PATH=$brew_prefix/opt/gnu-sed/libexec/gnubin:\$PATH

# Need the man pages for the GNU sed
export MANPATH=$brew_prefix/opt/gnu-sed/libexec/gnuman:\$MANPATH
EOF
