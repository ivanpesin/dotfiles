# ---

alias ls='ls -G'
alias ll='ls -lG'

export GOPATH=$HOME/Documents/Projects/golang

# append history file instead overwriting
shopt -s histappend
# store lots of commands
HISTFILESIZE=1000000
HISTSIZE=100000
# for own machine ignoreboth, for servers
HISTCONTROL=ignoreboth
# keep timestamps
HISTTIMEFORMAT='%F %T %z '
# store history after each command
PROMPT_COMMAND='history -a'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


export PS1="[\u@\h \W]\\$ "

powerline() {
    # From: https://github.com/riobard/bash-powerline
    # Colorscheme
    readonly RESET='\[\033[m\]'
    readonly COLOR_CWD='\[\033[0;34m\]' # blue
    readonly COLOR_CYAN='\[\033[0;36m\]' # cyan
    readonly COLOR_GREEN='\[\033[0;32m\]' # green
    readonly COLOR_RED='\[\033[0;31m\]' # red

    readonly SYMBOL_GIT_BRANCH='⑂'
    readonly SYMBOL_GIT_MODIFIED='*'
    readonly SYMBOL_GIT_PUSH='↑'
    readonly SYMBOL_GIT_PULL='↓'

    git_info() {
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$COLOR_GREEN$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo
        ref=$COLOR_CYAN$ref$RESET

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$COLOR_RED$SYMBOL_GIT_MODIFIED$RESET$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks "
    }

    set_ps1() {
        err=$?
        if [ $err -eq 0 ]; then
            local symbol="\\$ $RESET"
        else
            local symbol="$COLOR_RED(rc=$err)\\$ $RESET"
        fi

        PS1="[\u@\h \W]$(git_info)$symbol"
    }

    PROMPT_COMMAND="set_ps1; $PROMPT_COMMAND"
}

powerline
unset powerline
