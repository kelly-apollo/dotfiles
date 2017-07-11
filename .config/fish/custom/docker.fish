alias dco="docker-compose"
alias dup="docker-compose up -d"
alias dps="docker-compose ps"

# bash to container
function dsh
  docker exec --detach-keys "ctrl-@" -it (docker-compose ps -q $argv) bash
end

# container's log
function dlog
  docker-compose logs --tail="20" -f $argv
end
