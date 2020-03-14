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
export PATH="$(du "$HOME/.scripts/" --exclude ".scripts/external" | cut -f2 | tr '\n' ':' | sed 's|:*$||' | sed 's|\/$||'):$PATH"

#------------------------------
# Aliases
#------------------------------
[[ -f $HOME/.shell_aliases ]] && source $HOME/.shell_aliases
alias x='startx'
alias ssh='TERM=xterm-256color ssh'
alias ddd='sudo dd status=progress bs=64k'
alias sc='sudo systemctl'
alias p='sudo pacman'
alias pp='pacaur'
alias v='vim'
alias V='sudo vim'
alias diff='diff -u --color=always'
alias dk='docker'
alias kc='kubectl'
alias ka='sudo kubeadm'
alias kn='kubens'
alias kx='kubectx'
alias ydl='youtube-dl'
alias share='quickshare default'

#------------------------------
# Variables
#------------------------------
export TERMINAL="alacritty"
export EDITOR="vim"
export FILEMANAGER="nnn"
export MAILER="neomutt"
[[ $(command -v iceweasel) ]] && export BROWSER="iceweasel" || export BROWSER="firefox"

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
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

# kubectl autocompletion for zsh (lazy load)
kubectl () {
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

# Load nnn configuration
NNN_CONFIG_FILE="$HOME/.config/nnn/config"
[ -f "$NNN_CONFIG_FILE" ] && \
  source "$NNN_CONFIG_FILE"

# Force HIDPI factor
export WINIT_HIDPI_FACTOR=1.0

# GTK theme
export GTK_THEME=numix-black:dark

# Qt theme
export QT_PLATFORMTHEME=qt5ct
export QT_PLATFORM_PLUGIN=qt5ct
export QT_QPA_PLATFORMTHEME=qt5ct

#xz multithread
export XZ_OPT="-T 0"

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Gradle
export GRADLE_HOME="$HOME/.local/share/gradle"

# Android
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Vagrant provider
export VAGRANT_DEFAULT_PROVIDER=libvirt

# Node related paths
export NODE_PATH="$HOME"/.local/share/node_modules
export NVM_DIR="$HOME"/.local/share/nvm
