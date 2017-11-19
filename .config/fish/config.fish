# go
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOPATH/bin

# tool
source ~/.config/fish/custom/git.fish
source ~/.config/fish/custom/docker.fish
source ~/.config/fish/custom/work.fish
source ~/.config/fish/custom/shortcut.fish

# tmux
set -U FZF_TMUX 0
set -gx EVENT_NOKQUEUE 1

set -gx EDITOR vim
set -gx PATH ~/bin/ $PATH
if test -d ~/.gem/ruby/2.0.0/bin
    set -gx PATH ~/.gem/ruby/2.0.0/bin $PATH
end

function reload
    source ~/.config/fish/config.fish
end

alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias em="emacs -nw"
alias config="vim ~/.config/fish/config.fish"
alias cnpm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
end

# theme
set fish_color_search_match --background=ededed
set fish_pager_color_completion black
set fish_pager_color_prefix 327dda
set fish_pager_color_description 327dda
