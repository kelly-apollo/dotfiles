# git
alias gg="git log"
alias gb="git branch"
alias gc="git commit -m"
alias gs="git status"
alias gpp="git push -u origin (current_branch)"
alias gmm="git merge origin/master"
alias gm="git merge --no-ff"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gcm="git checkout master"

function gq
    git add -A
    git commit -a -m $argv
end

function gcd
    git checkout .
    git clean -df
end

function gco
    git checkout $argv
end

function gcot
  git checkout -b $argv
  git push -u origin (git branch ^/dev/null | grep \* | sed 's/* //')
end

function gcl
  git clone $argv
  cd (basename $argv .git)
end
