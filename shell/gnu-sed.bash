# I don't want to have to type gsed
export PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH

# Need the man pages for the GNU sed
export MANPATH=$(brew --prefix)/opt/gnu-sed/libexec/gnuman:$MANPATH