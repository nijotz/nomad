# I'm used to the GNU version of utils
export PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH

# Need the man pages for the GNU coreutils
export MANPATH=$(brew --prefix)/opt/coreutils/libexec/gnuman:${MANPATH}
