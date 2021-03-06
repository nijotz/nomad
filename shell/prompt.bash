print_pre_prompt() {
  hextime=$(printf '0x%02X:%02X:%02X' $(date +" %H %M %S" | sed 's/ 0/ /g'))
  virtualenv=$(echo $VIRTUAL_ENV | sed -e 's_.*/\(.*\)$_(\1)_')
  PS1=$(echo '32[31\!33${hextime}35\u32@34\h37${virtualenv}36\w32]\$00 ' | sed -E 's_([0-9]{2})_\\[\\e[\1m\\]_g')
}

PROMPT_COMMAND="${PROMPT_COMMAND}; print_pre_prompt"
