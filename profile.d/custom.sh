if [ "$PS1" ]; then

  [ -f "/etc/systag.name" ]  && TAG="[$(cat /etc/systag.name)]"
  [ -f "/etc/systag.color" ] && TAG_COLOR="$(cat /etc/systag.color)"

  PS1="\[$TAG_COLOR\]$TAG\[\e[0m\][\u@\h \W]\\$ "

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
