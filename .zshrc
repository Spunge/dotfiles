# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="johan"

#export NODE_ENV=development

export CGO_CFLAGS="-I/home/johan/deps/sqlite/ -I/home/johan/deps/dqlite/include/"
export CGO_LDFLAGS="-L/home/johan/deps/sqlite/.libs/ -L/home/johan/deps/dqlite/.libs/"
export LD_LIBRARY_PATH="/home/johan/deps/sqlite/.libs/:/home/johan/deps/dqlite/.libs/"

export MAKEFLAGS=-j8
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

export ETCDCTL_ENDPOINTS="https://127.0.0.1:2379"
export ETCDCTL_CA_FILE="/home/johan/Projects/Code/forest/module/etcd3/test/certs/certs/ca.crt"
export ETCDCTL_CERT_FILE="/home/johan/Projects/Code/forest/module/etcd3/test/certs/certs/etcd0.localhost.crt"
export ETCDCTL_KEY_FILE="/home/johan/Projects/Code/forest/module/etcd3/test/certs/private/etcd0.localhost.key"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias htop="TERM=screen htop"

# Set to this to use case-sensitive completion
#CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial)

DISABLE_UPDATE_PROMPT=true

# Host specific config
if [ $(hostname) != 'helios' ]; then
	DISABLE_AUTO_UPDATE=true
else
	alias ping="prettyping"
fi

source $ZSH/oh-my-zsh.sh
 
# Customize to your needs...
export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

# Fix TERM var to fix colors
TERM=xterm-256color
###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###
