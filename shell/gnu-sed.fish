# I don't want to have to type gsed
set PATH (brew --prefix)/opt/gnu-sed/libexec/gnubin $PATH

# Need the man pages for the GNU sed
set MANPATH (brew --prefix)/opt/gnu-sed/libexec/gnuman:$MANPATH
