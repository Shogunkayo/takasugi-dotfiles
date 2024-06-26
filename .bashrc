#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="nvim"
export VISUAL="nvim"
export GOPATH="~/github/go"

clone() {
	git -C ~/github clone $1 && cd ~/github/"$(basename "$_" .git)"
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nv='nvim'
alias ff="fastfetch"
alias yt="~/code/scripts/youtube.sh"

PS1='\W \$ '

eval "$(zoxide init --cmd cd bash)"

# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}
bind '"\C-o":"lfcd\C-m"'  # bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pYr0/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pYr0/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pYr0/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pYr0/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

