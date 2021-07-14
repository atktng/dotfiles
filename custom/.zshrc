# prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Add-ons rely on environemnts
if [ -f "${HOME}/.zshrc.addon" ]; then
    source "${HOME}/.zshrc.addon"
fi

# Aliases
alias watch='watch '
alias k='kubectl'
alias awsp='source _awsp'
alias g='git'
alias l='ls -ltr --color=auto'
alias so='source'
alias v='vim'
alias vza='vim ~/.zshrc.addon'
alias vz='cd ~/github/atktng/dotfiles && vim custom/.zshrc'
alias soz='source ~/.zshrc'
alias c='cdr'
alias h='fc -lt "%F %T" 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias diff='diff -U1'
alias -g G='| grep -i'
alias -g L='| less'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'

# Vim keybind
bindkey -v

# Editor
export EDITOR=vim

# Disable beep
unsetopt BEEP

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# cdr
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-default true

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

# URL encode
uenc() {echo $1 | nkf -WwMQ | sed 's/=$//g' | tr = % | tr -d '\n'}

# direnv
if command -v direnv 1>/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# pipenv
# https://pipenv-fork.readthedocs.io/en/latest/advanced.html#custom-virtual-environment-location
export PIPENV_VENV_IN_PROJECT=true

# goenv
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
if command -v goenv 1>/dev/null 2>&1; then
    eval "$(goenv init -)"
fi
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
complete -F __start_kubectl k
autoload -U colors; colors
[ ! -f ${HOME}/zsh-kubectl-prompt/kubectl.zsh ] && git clone https://github.com/superbrothers/zsh-kubectl-prompt.git
[ -f ${HOME}/zsh-kubectl-prompt/kubectl.zsh ] && source ${HOME}/zsh-kubectl-prompt/kubectl.zsh
RPROMPT='%{$fg[cyan]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# Docker rootless mode
# https://docs.docker.com/engine/security/rootless/
if [[ "$(systemctl --user is-active docker.service)" = "active" ]]; then
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
fi

# Flutter
# https://flutter.dev/docs/get-started/install/linux#install-flutter-manuallyexport
PATH="$PATH:${HOME}/flutter/bin"

# WSL
if uname -r | grep -i 'microsoft' 1>/dev/null 2>&1; then
    # X Server's location (https://github.com/microsoft/WSL/issues/4106#issuecomment-501885675)
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0

    # appendWindowsPath=false (https://docs.microsoft.com/en-us/windows/wsl/wsl-config)
    # cd $HOME/win_bin && ln -s /path/to/windows_command
    export PATH=$PATH:$HOME/win_bin
fi

