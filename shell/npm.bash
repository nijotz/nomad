npm_bin=$(command -v npm)
if [ ! $? ]; then 
  nomad_log info "npm command not found; skipping setup"
  exit
fi

npm_bin_root=$(npm bin -g)
npm_bin_local=$(npm bin)
nomad_log info "found npm root bin directory: $npm_bin_root"
nomad_log info "found npm local bin directory: $npm_bin_local"
nomad_log info "adding npm directories to PATH"

nomad_echo_and_eval << EOF
# Setup npm bin directories
export PATH=$npm_bin_root:$npm_bin_local:\$PATH
EOF
