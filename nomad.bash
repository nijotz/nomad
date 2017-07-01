#!/usr/bin/env bash

# Some shell configs are executable and their output is added to the shell's rc
# file. This enables those executable configs to still output information using
# another file descriptor
function nomad_log {
  echo "- ${*:2}" >&3
}
export -f nomad_log

exec $1
