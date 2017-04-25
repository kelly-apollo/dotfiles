# get local ip
function ip
  ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
end

# simple server in HTTP
alias ss="python -m SimpleHTTPServer"

# mkdir and cd to
function mkdircd
  mkdir $argv
  cd $argv
end
