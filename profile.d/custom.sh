if [ "$PS1" ]; then

  [ -f "/etc/envtag.name" ]  && TAG="[$(cat /etc/envtag.name)]"
  [ -f "/etc/envtag.color" ] && TAG_COLOR="$(cat /etc/envtag.color)"

  _PS1_C_RED="\x01$(tput setaf 1)\x02"
  _PS1_C_GREEN="\x01$(tput setaf 2)\x02"
  _PS1_C_RESET="\x01$(tput sgr0)\x02"

  _show_rc_in_ps1() {
    local err=$?
    if [ $err -eq 0 ]; then
      echo -ne "${_PS1_C_GREEN}"
    else
      echo -ne "${_PS1_C_RED}"
    fi
    echo -e "rc:$err${_PS1_C_RESET}"
    return $err
  }

  PS1="[\$(_show_rc_in_ps1) \u@\h \W]\\$ "

  # append history file instead overwriting
  # update LINES/COLUMNS if necessary
  shopt -s histappend checkwinsize

  # keep lots of history
  HISTFILESIZE=1000000
  HISTSIZE=100000
  # keep timestamps
  HISTTIMEFORMAT='%F %T %z '
  # store history after each command
  PROMPT_COMMAND='history -a'

fi
