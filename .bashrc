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
alias pes='su PES1UG21CS206 && cd'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias nv='nvim'
alias ff="fastfetch"

PS1='\W \$ '

eval "$(zoxide init --cmd cd bash)"
