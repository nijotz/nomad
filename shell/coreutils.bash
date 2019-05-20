brew_prefix=$(brew --prefix)
if [[ -z "$brew_prefix" ]]; then
  nomad_log info "homebrew binary not found"
  exit 0
fi

nomad_log info "found homebrew binary; configuring coreutils"

mkdir -p ~/.nomad/coreutils/bin
mkdir -p ~/.nomad/coreutils/man/man1

ln -s $brew_prefix/opt/coreutils/libexec/gnubin/ls ~/.nomad/coreutils/bin/
ln -s $brew_prefix/opt/coreutils/libexec/gnuman/man1/ls.1 ~/.nomad/coreutils/man/man1/

nomad_echo_and_eval << EOF
# I'm used to the GNU version of utils
export PATH=~/.nomad/coreutils/bin:\$PATH

# Need the man pages for the GNU coreutils
export MANPATH=~/.nomad/coreutils/man:\$MANPATH
EOF
