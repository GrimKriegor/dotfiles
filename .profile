#------------------------------
# .dotfiles operations
#------------------------------

alias dfc='cd ~/.dotfiles'
alias dfi='echo "Initializing dotfiles" && workdir=$(pwd) && cd ~/.dotfiles && bash ./init.sh && cd $workdir'
alias dfu='echo "Updating dotfiles" && workdir=$(pwd) && cd ~/.dotfiles && git pull && cd $workdir'
alias dfuu='echo "Updating dotfiles" && workdir=$(pwd) && cd ~/.dotfiles && git pull --recurse-submodules && cd $workdir'


#------------------------------
# User scripts
#------------------------------

export PATH="$(du "$HOME/.local/bin/scripts/" --exclude ".local/bin/scripts/external" | cut -f2 | tr '\n' ':' | sed 's|:*$||' | sed 's|\/$||'):$PATH"


#------------------------------
# Subalias function
#------------------------------

subalias() {
    local cmd body name
    name="${1%%=*}"
    cmd="${name%_*}"
    body="${1#*=}"
    eval "$cmd"'() {
        local cmd='"$cmd"' subcmd="$1"
        if type "${cmd}_${subcmd}" >/dev/null 2>&1; then
            shift
            "${cmd}_${subcmd}" "$@"
        elif type "${cmd}_${subcmd}_subalias" >/dev/null 2>&1; then
            shift
            "${cmd}_${subcmd}_subalias" "$@"
        elif type "${cmd}_subalias" >/dev/null 2>&1; then
            "${cmd}_subalias" "$@"
        else
            command "$cmd" "$@"
        fi
    }'
    if test "$body" != "$1"; then
        eval "${name}_subalias"'() { '"$body"'; }'
    fi
}


#------------------------------
# Aliases
#------------------------------

[[ -f $HOME/.shell_aliases ]] && source $HOME/.shell_aliases
alias x='startx'
alias ssh='TERM=xterm-256color ssh'
alias ddd='sudo dd status=progress bs=64k'
alias sc='sudo systemctl'
alias p='sudo pacman'
alias pp='paru'
alias v='vim'
alias V='sudo vim'
alias gvim='term vim'
alias diff='diff -u --color=always'
alias dk='docker'
alias pm='podman'
alias ccl='sudo crictl'
alias zkc='zkcluster'
alias kc='kubectl'
alias mkc='minikube kubectl'
alias kkc='k3s kubectl'
alias kn='kubens'
alias kx='kubectx'
alias ydl='youtube-dl'
alias share='quickshare default'
alias xz='xz --verbose'
subalias git_gud="echo Already gud!"


#------------------------------
# exp(ort)i(f)i(nstalled) function by Gerivian
#------------------------------

expii() {
  j="$1"; shift
  for i in "$@"; do
    command -v "${i%% *}" >/dev/null 2>&1 &&
    export "$j"="$i" && break
  done
}


#------------------------------
# Variables
#------------------------------

expii TERMINAL alacritty xterm
expii EDITOR vim nvim vim.tiny vi
expii FILEMANAGER nnn pcmanfm
expii MAILER neomutt mutt
expii BROWSER iceweasel firefox
expii LAUNCHER rofi dmenu


#------------------------------
# Window title
#------------------------------

case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () {
      print -Pn "\e]0;[%n@%M][%~]%# ($1)\a"
    }
    ;;
  screen|screen-256color)
    precmd () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac


#------------------------------
# Additional autocompletion
#------------------------------

kubectl() {
    command kubectl $*
    if [[ -z $KUBECTL_COMPLETE ]]
    then
        source <(command kubectl completion zsh)
        KUBECTL_COMPLETE=true
    fi
}


#------------------------------
# Program configuration
#------------------------------

# pass
export PASSWORD_STORE_DIR="$HOME/.pass"

# nnn
NNN_CONFIG_FILE="$HOME/.config/nnn/config"
[ -f "$NNN_CONFIG_FILE" ] && \
  source "$NNN_CONFIG_FILE"

# GTK
export GTK_THEME=numix-black:dark

# Qt
export QT_PLATFORMTHEME=qt5ct
export QT_PLATFORM_PLUGIN=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

# xz
export XZ_OPT="-T 0"

# Mozilla
export MOZ_X11_EGL=1
export MOZ_ENABLE_WAYLAND=0
export MOZ_WEBRENDER=1

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Gradle
export GRADLE_HOME="$HOME/.local/share/gradle"

# Android
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Kubernetes
export KUBECONFIG=$HOME/.kube/config

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# Node
export PATH=$PATH:$HOME/.npm-packages/bin

# vedutils
export PATH=$PATH:$HOME/.local/bin/scripts/external/vedutils/vedutils
export PATH=$PATH:$HOME/.local/bin/scripts/external/vedutils/contrib


#------------------------------
# Start Xorg
#------------------------------

if [[ -z "$DISPLAY" ]] && [[ $(tty) = "/dev/tty1" ]]; then
  startx
  logout
fi
