#!/usr/bin/env fish

# Some shell configs are executable and their output is added to the shell's rc
# file. This enables those executable configs to still output information using
# another file descriptor
function nomad_log
  echo "- $argv[2..-1]" >&3
end

eval $1
