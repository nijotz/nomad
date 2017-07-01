function fish_greeting
end

function fish_prompt
  set exitstatus $status
  set exitcolor normal
  set exitsymbol " ✓ "
  if test $exitstatus -ne 0
    set exitcolor red
    set exitsymbol (echo -n (printf "%03d" $exitstatus))
  end

  set now (date +" %H %M %S" | sed -e 's/ 0/ /g' -e 's/^ //' | tr ' ' '\n')
  set hextime (printf '0x%02X:%02X:%02X' $now)

  set_color green;      echo -n [
  set_color $exitcolor; echo -n $exitsymbol
  set_color cyan;       echo -n (pretty_cmd_duration)
  set_color yellow;     echo -n $hextime
  set_color purple;     echo -n (whoami)
  set_color green;      echo -n @
  set_color blue;       echo -n (hostname -s)
  set_color cyan;       echo -n (prompt_pwd)
  __informative_git_prompt
  set_color green;      echo -n ]

  set_color yellow;
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
         echo -n '~c '
      case insert
        echo -n '~> '
      case replace_one
        echo -n '~r '
      case visual
        echo -n '~v '
    end
  else
    echo -n '~> '
  end

  set_color normal
end

function fish_mode_prompt
end

function pretty_cmd_duration
  set -l SEC 1000
  set -l MIN 60000
  set -l HOUR 3600000
  set -l DAY 86400000

  set -l num_days (math "$CMD_DURATION / $DAY")
  set -l num_hours (math "$CMD_DURATION % $DAY / $HOUR")
  set -l num_mins (math "$CMD_DURATION % $HOUR / $MIN")
  set -l num_secs (math "$CMD_DURATION % $MIN / $SEC")
  set -l num_millis (math "$CMD_DURATION % $SEC")

  set -l time_str ''
  set -l num_millis_pretty ''
  if [ $num_days -gt 0 ]
    set time_str {$time_str}{$num_days}"d"
  end
  if [ $num_hours -gt 0 ]
    set time_str {$time_str}{$num_hours}"h"
  end
  if [ $num_mins -gt 0 ]
    set time_str {$time_str}{$num_mins}"m"
  end
  set num_millis_pretty (printf '%03d' $num_millis)
  set time_str {$time_str}{$num_secs}s{$num_millis_pretty}
  echo $time_str
end
