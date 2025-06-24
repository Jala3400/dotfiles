# modified version of the default .bashrc file for wsl.
# improved prompt and added some aliases.

#  ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
# PROMPT_DIRTRIM=4
# Función para abreviar la ruta
prompt_command() {
    local start='\[\e[32m\]┌──(\[\e[94;1m\]'$(whoami)'@'$(hostname)'\[\e[0;32m\])-[\[\e[38;5;46;1m\]'$(short_path)'\[\e[0;32m\]]'
    local date="\[\e[38;5;46;1m\][$(date +%H:%M:%S)]"
    # local git_info=$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1 "-[%s]")
    local git_info=''
    local filler="·"
    # Calculate visible length without color codes
    local visible_start=$(echo -e "${start}" | sed 's/\\\[\([^]]*\)\\\]//g')
    local visible_date=$(echo -e "${date}" | sed 's/\\\[\([^]]*\)\\\]//g')
    local filler_length=$((COLUMNS - ${#visible_start} - ${#visible_date} - ${#git_info}))
    local fill=""
    for ((i=0; i<filler_length; i++)); do
        fill+="$filler"
    done
    PS1="${start}\[\e[38;5;22m\]${fill}${git_info}${date}\n\[\e[32m\]╰─\[\e[94;1m\]\$ \[\e[0m\]"
}

short_path() {
    local path="${PWD/#$HOME/\~}" # Reemplaza $HOME con ~
    local IFS='/'
    local parts=($path)
    local short=""
    local last_n=3 # Número de directorios finales a mostrar completos

    for ((i=0; i<${#parts[@]}; i++)); do
        if [[ "$i" -lt $((${#parts[@]} - $last_n)) ]]; then
            if [[ "${parts[i]}" == "~" ]]; then
                short+="~/"
            else
                short+="${parts[i]:0:4}/" # Toma la primera letra
            fi
        else
            short+="${parts[i]}/" # Muestra el resto completo
        fi
    done

    echo "${short%/}" # Quita el último "/"
}

# Define el nuevo PS1
# PS1='\[\e[1;32m\]\u@\h:\[\e[1;34m\]$(short_path)\[\e[0m\]\$ '
if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1='\[\e[38;5;39m\][\[\e[38;5;214m\]\u\[\e[38;5;39m\]@\[\e[38;5;214m\]\h \[\e[38;5;82m\]\w\[\e[38;5;39m\]]\n\[\e[38;5;208m\]λ \[\e[0m\]'
    # PS1='\[\e[32m\]┌──(\[\e[94;1m\]\u\[\e[94m\]@\[\e[94m\]\h\[\e[0;32m\])-[\[\e[38;5;46;1m\]$(short_path)\[\e[0;32m\]]$(GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWDIRTYSTATE=1 __git_ps1 "-[%s]")\[\e[32m\]\n\[\e[32m\]╰─[\A]-\[\e[94;1m\]\$ \[\e[0m\]'
    PROMPT_COMMAND=prompt_command
    PS1=''
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export LS_COLORS='di=34:fi=0:ln=36:pi=33:so=35:bd=45;37:cd=45;37:or=31;40'
export EXA_COLORS='di=1;34:fi=0;37:ln=36;1:pi=33;1:so=35;1:bd=45;37:cd=45;37:or=31;40'

alias fd='dir=$(find . -type d | fzf --preview "exa -1 --color=always {}") && [ -n "$dir" ] && cd "$dir"'
alias fzf='fzf --height 40% --layout=reverse --border --ansi --preview "bat --color=always --line-range :500 {}"'

alias cls='clear'
alias c='clear'

alias cd..="cd .."
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../..'
alias ...........='cd ../../../../../../../../../..'
alias ............='cd ../../../../../../../../../../..'

alias h='history'
alias hg='history | grep'
alias hf='history | fzf'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gp='git pull'