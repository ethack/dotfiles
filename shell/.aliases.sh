exists () {
	#type $1 &> /dev/null
    command -v $1 >/dev/null 2>&1
}

# files
# alias ls="ls --human-readable --classify --group-directories-first --color=auto"
alias l='ls'
alias ll='ls -l'
alias la='ls -l -a'
alias ..='cd ..'
alias ...='cd ../..'
alias mv='mv -i'
alias mb='mv'
alias mkdir="mkdir -p"
alias df="df -h --total"
alias dud="du -sh -d 1 --total"

if exists rg; then
  alias grep="rg"
else
  alias grep="grep --color --extended-regexp"
fi

# System tools that should always use sudo
alias apt="sudo apt"
alias aptitude="sudo aptitude"
alias systemctl="sudo systemctl"

# git
alias gs='git status -s'
alias gll='git pull'
alias gllo='git pull origin'
alias gsh='git push'
alias gshf='git push -f'
alias gshfo='git push -f origin'
alias gsho='git push origin'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gb='git branch'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias ga='git add'
alias gd='git diff'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gm='git merge'
alias gy='git yolo && git push'

# vim
alias vimrc='$EDITOR ~/.vimrc'
alias vi='vim'
alias bim='vim'

# Docker
alias dk='docker'
alias dkc='docker-compose'

alias md5='md5sum'
alias iip="ip addr | ip.py"
alias eip='curl icanhazip.com'

alias digs='dig +short'
alias spf='dig +short txt'

# LastPass
# alias lc='~/bin/lpass2clip.sh'
# Pass
#alias p='pass'
#alias pc='pass show --clip'
#alias pe='pass edit'
alias pc='sleep 1.0; xdotool type "$(xclip -o -selection clipboard)"'

alias serve='python3 -m http.server'

alias screenshot="gnome-screenshot --area --clipboard"
alias scs="gnome-screenshot --area --clipboard"
