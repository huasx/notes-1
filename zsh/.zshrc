# Path to your oh-my-zsh installation.
export ZSH=/Users/fifsky/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git composer docker docker-compose osx zsh-autosuggestions)

# User configuration

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/go/bin:~/.composer/vendor/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export DEFAULT_USER="$(whoami)"
#忽略重复的命令
export HISTCONTROL=ignoredups
export NODE_PATH="/usr/local/lib/node_modules/"
source /usr/local/lib/z.sh

export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
export NVM_DIR="/Users/fifsky/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -la'

plugins+=(zsh-completions)
autoload -Uz compinit && compinit -i

export APP_ENV="local"
export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=/Users/fifsky/go/
export GOBIN=$GOROOT/bin
export GOARCH=amd64
export GOOS=darwin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin


#set go path
gop(){
	currpath=`pwd`/
    gopath=${currpath%src/*}

	if [[ ${gopath} = "" ]];then
		echo "path not found src"
	else
        export GOPATH=${currpath%src/*}
		echo current ${GOPATH}
    fi
}

# set proxy
proxy () {
	export ALL_PROXY="socks5://127.0.0.1:1080"
	export HTTP_PROXY="socks5://127.0.0.1:1080"
	export HTTPS_PROXY="socks5://127.0.0.1:1080"
	echo "Proxy on"
}

# unset proxy
unproxy () {
	unset ALL_PROXY
	unset HTTP_PROXY
	unset HTTPS_PROXY
	echo "Proxy off"
}

#go get to current vendor path
gopkg () {
    bak_go_path=${GOPATH}
    curr_path=`pwd`
    echo -e "\033[34m[GOPATH]\033[0m" ${bak_go_path}
    echo -e "\033[34m[CURR PATH]\033[0m" ${curr_path}
    export GOPATH=~/.govendor
    rm -rf ~/.govendor
    echo -e "\033[34m[GO GET]\033[0m" $@
    go get -v $@
    rsync -a --exclude=".git/" ~/.govendor/src/ ${curr_path}/vendor/
    export GOPATH=${bak_go_path}
    echo -e "\033[34m[DONE]\033[0m"
}
