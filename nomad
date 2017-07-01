#!/bin/bash

set -e

function link_cfgs {
  for cfg in ~/.nomad/cfgs/*; do
    target=~/.$(basename $cfg)
    [ -h $target ] || ln -s $cfg $target
  done;
}

function sync_submodules {
  pushd ~/.nomad/ > /dev/null
  git submodule sync
  git submodule init
  git submodule update
  popd > /dev/null
}

# Process a shell's enabled configs into a rc file for that shell
function collect_enabled {
  shell=$1
  files=$(cat ~/.nomad/cfg/$shell-enabled)
  new_config=~/.nomad/cfg/config.$shell.temp

  for file in $files; do
    file=~/.nomad/shell/$file
    echo "Processing $file"
    if [[ -x "$file" ]]; then
      # Enables the nomad_log function
      exec 3>&1
      output=$(~/.nomad/nomad.$shell $file)
    else
      output=$(cat $file)
    fi
    echo '####' >> $new_config
    echo \## $(echo $file) >> $new_config
    echo '####' >> $new_config
    echo "$output" >> $new_config
    echo >> $new_config
  done

  mv ~/.nomad/cfg/config.$shell{.temp,}
}

# Some configurations needs to be available to other scripts. For example,
# homebrew configuration is needed by other scripts. So, as they are loaded
# into the rc file, also load them into the current environment for other
# scripts to make use of
function nomad_echo_and_eval {
  input=`cat`
  echo "$input"
  eval "$input"
}
export -f nomad_echo_and_eval

function init {
  mkdir -p ~/.nomad/cfg/
  ls ~/.nomad/shell/*.bash > ~/.nomad/cfg/bash-enabled
  ls ~/.nomad/shell/*.fish > ~/.nomad/cfg/fish-enabled
}

function infect_rc {
  unique=uijooQu2
  [ -e ~/.bashrc ] && sed -i -e "/.*${unique}.*/d" ~/.bashrc
  [ -e ~/.config/fish/config.fish ] && sed -i -e "/.*${unique}.*/d" ~/.config/fish/config.fish
  echo "source ~/.nomad/cfg/config.bash #uijooQu2" >> ~/.bashrc
  mkdir -p ~/.config/fish/
  echo "source ~/.nomad/cfg/config.fish #uijooQu2" >> ~/.config/fish/config.fish
}

infect_rc
collect_enabled bash
collect_enabled fish
