#!/usr/bin/env bash

# Some configurations needs to be available to other scripts. For example,
# homebrew configuration is needed by other scripts. So, as they are loaded
# into the rc file, also load them into the current environment for other
# scripts to make use of
function nomad_echo_and_eval {
  input=$(cat)
  echo "$input"
  eval "$input"
}
export -f nomad_echo_and_eval

# Some shell configs are executable and their output is added to the shell's rc
# file. This enables those executable configs to still output information using
# another file descriptor
function nomad_log {
  echo "- ${*:2}" >&3
}
export -f nomad_log

exec $1
