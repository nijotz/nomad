#!/usr/bin/env fish

set npm_bin (command -v npm)
if test $status
  nomad_log info "npm command not found; skipping setup"
  exit
end

set npm_bin_root (npm bin -g)
set npm_bin_local (npm bin)
nomad_log info "found npm root bin directory: $npm_bin_root"
nomad_log info "found npm local bin directory: $npm_local_root"
nomad_log info "addming npm directories to PATH"

echo "# Setup npm bin directories"
echo "set PATH $npm_bin_root $npm_bin_local \$PATH"
