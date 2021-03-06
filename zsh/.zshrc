# Environment {{{

[[ -f ~/.zshenv ]] && source ~/.zshenv
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export BROWSER="firefox"
export EDITOR="nvim"
export TERM='xterm'

# }}}

#[[ -z "$SSH_CONNECTION" ]] && xset b off # Disable beeps
# Look {{{

if [[ -z "$SSH_CONNECTION" ]] ; then
# Theme defaults {{{

# dynamic-colors binaries
export PATH="$HOME/.urxvt/dynamic-colors/bin:$PATH"
dynamic-colors init

# }}}
# Theme-specific {{{

# Solarized-light {{{

# Commands {{{

# ls
eval `dircolors ~/.urxvt/dircolors-solarized/dircolors.ansi-light`

# less (ref.1)
export LESS_TERMCAP_mb=$'\e[5m'           # begin blinking
export LESS_TERMCAP_md=$'\e[35m'          # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[1;30;106m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[4;32m'        # begin underline
export LESS="-M -R"

# TODO: yaourt
# export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35""

# }}}

# }}}

# }}}
fi

cowthink $(fortune -c) # Cow greeting you on launch
export PS1="%~ $ " # Status in terminal
# Right-side statusline {{{

# Git functions {{{

function git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function git_current_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(git_dirty)]/"
}
git_status() {
    # If not an ssh mountpoint (this would be too slow to respond)
    if [[ ! -n "$(mount | grep "$(pwd -P) type fuse\.sshfs" )" ]] then
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# }}}
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_status) $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# }}}

# }}}
# Input {{{

# General {{{

# Emacs keybindings by default
# Don't recommend to use vim keybindings except for big inline scripts
bindkey -e

# transition between modes takes 0.1s instead of 0.4s
export KEYTIMEOUT=1

# }}}
# Keymaps {{{

# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# inputrc mappings {{{

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# }}}

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# Bang! Previous Command Hotkeys
# print previous command but only the first nth arguments
# Alt+1, Alt+2 ...etc
# http://www.softpanorama.org/Scripting/Shellorama/bash_command_history_reuse.shtml#Bang_commands
bindkey -s '\e1' "!:0 \t"        # last command
bindkey -s '\e2' "!:0-1 \t"      # last command + 1st argument
bindkey -s '\e3' "!:0-2 \t"      # last command + 1st-2nd argument
bindkey -s '\e4' "!:0-3 \t"      # last command + 1st-3rd argument
bindkey -s '\e5' "!:0-4 \t"      # last command + 1st-4th argument
bindkey -s '\e`' "!:0- \t"       # all but the last argument
bindkey -s '\e9' "!:0 !:2* \t"   # all but the 1st argument (aka 2nd word)

# }}}
# Completions (ref.2) {{{

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        avahi ftp mysql systemd-bus-proxy usbmux bacula git nobody \
        systemd-journal-gateway uuidd bin ntp systemd-journal-remote \
        colord http polkitd systemd-journal-upload daemon kdm postfix \
        systemd-network dbus postgres systemd-resolve deluge \
        systemd-timesync mail rtkit test

# ... unless we really want to.
zstyle '*' single-ignored show

# ssh - config host entries {{{
zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:hosts' hosts $_ssh_config
# }}}

# }}}

# }}}
# Typing and completion {{{

# cd, writing only path to directory
setopt autocd
# extended globbing (regex-like, ex. filename.{png,jpg})
setopt extendedglob

# zsh completion
autoload -Uz compinit
compinit
# Disable the need of `rehash` on new executable in $PATH
setopt nohashdirs
# auto-correction
setopt correctall

# Auto-rehash on completion (in case new binaries were added to $PATH)
zstyle ":completion:*:commands" rehash 1

# Use bash-completion, if available
autoload bashcompinit
bashcompinit
if [ -f /etc/bash_completion ]; then source /etc/bash_completion; fi

# Specific completions {{{

# dynamic-colors
[[ -z "$SSH_CONNECTION" ]] && source $HOME/.urxvt/dynamic-colors/completions/dynamic-colors.zsh
# wp-cli
if [ -f /usr/share/bash-completion/completions/wp ]; then source /usr/share/bash-completion/completions/wp; fi

# }}}

# }}}
# History {{{

# append to history file
setopt appendhistory
# don't put duplicate lines in the history
setopt hist_ignore_all_dups
# space-preceding commands are not written to history
#setopt hist_ignore_space

# limits
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# }}}

# Plugins {{{

export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# fzf completion
source "/usr/share/fzf/key-bindings.zsh"
source "/usr/share/fzf/completion.zsh"

# }}}
# Package-specific {{{

# NPM / Yarn {{{

# user-level global node modules
export PATH="$HOME/.node_modules/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
# add filename completion on second argument
# functions[_yarn]=${functions[_yarn]//"'1: :_yarn_commands_scripts' '\*"/"'1: :_yarn_commands_scripts' '2: :_files' '\*"}

# }}}
# i3wm {{{

export PATH="$HOME/.i3/bin:$PATH"

# }}}
# Less {{{

export LESSHISTFILE=/dev/null # no .lesshst file

# }}}
# Ruby {{{

#export GEM_HOME=~/.gem/ruby/2.2.0
export PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin:$HOME/.gem/ruby/2.1.0/bin:$HOME/.gem/ruby/2.2.0/bin

# }}}
# RVM {{{

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"

# }}}
# ZMV {{{

# http://onethingwell.org/post/24608988305/zmv
autoload zmv

# }}}
# Conda {{{

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/dmitriy/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dmitriy/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dmitriy/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dmitriy/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# }}}
# Composer / wp-cli {{{
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
source 
# }}}

# }}}
# Aliases (options and variations for existing, convenient shortcuts) {{{

# Default options {{{

alias tmux='tmux -2'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'                    # reports disk usage
alias du='du -c -h'                 # folder disk usage
alias diff='colordiff'              # requires colordiff package
alias info='info --vi-keys'
alias ping='ping -c 5'              # ping 5 times
alias feh='feh -.'

# }}}
# Variations {{{

# ls {{{

alias ls='ls -hF --color=auto'

alias ll='ls -l'
alias lr='ls -R'                    # recursive ls
alias la='ll -a'

alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date

alias lm='la | more'

# Sudo
alias sls='sudo ls -hF --color=auto'
alias sll='sudo ls -hFl --color=auto'
alias sll='sudo ls -hFla --color=auto'

# }}}
# Systemctl {{{

alias sy="sudo systemctl"
alias sys="sudo systemctl start"
alias sysp="sudo systemctl stop"
alias syst="sudo systemctl status"
alias syr="sudo systemctl restart"
alias sye="sudo systemctl enable"
alias syd="sudo systemctl disable"
alias sus="systemctl --user start"
alias susp="systemctl --user stop"
alias sust="systemctl --user status"
alias sur="systemctl --user restart"
alias sue="systemctl --user enable"
alias sud="systemctl --user disable"
alias sydr="sudo systemctl daemon-reload"

# }}}
# Yay {{{

(( $+commands[yay] )) && package_manager='yay' || package_manager='sudo pacman'
alias y="  $package_manager"                  # default action       - yay
alias ys=" $package_manager -S"               # '[s]ync'             - install one or more packages
alias yu=" $package_manager -Syu"             # '[u]pdate'           - upgrade all packages to their newest version
alias yua="$package_manager -Syua"            # '[u]pdate with [aur]'- upgrade all packages to their newest version + aur
alias yr=" $package_manager -Rs"              # '[r]emove'           - uninstall one or more packages
alias yc=" $package_manager -Scc"             # '[c]lean cache'      - delete all not currently installed package files
alias yss="$package_manager -Ss"              # '[Ss]earch'           - search for a package using one or more keywords
alias yi=" $package_manager -Si"              # '[i]nfo'             - show information about a package
alias ylo="$package_manager -Qdt"             # '[l]ist [o]rphans'   - list all packages which are orphaned
alias ylf="$package_manager -Ql"              # '[l]ist [f]iles'     - list all files installed by a given package
# Use Reflector to populate mirrorlist with fastest mirrors
alias yrefresh="sudo reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias yunlock="sudo rm /var/lib/pacman/db.lck"

# }}}

# }}}
# Convenient shortcuts {{{

# TODO: Timer / when it will suspend
function sleepin() { echo "System going to suspend in $1"; eval "sleep $1 && systemctl suspend" }
# Wine {{{

alias wine32="WINEARCH=win32 WINEPREFIX=~/.wine32 wine"
function photoshop() { eval "WINEARCH=win32 WINEPREFIX=~/.wine32 wine 'C:\\Program Files\\Photoshop\\Photoshop.exe' Z:$(readlink -f $1)" }
# }}}
# Sudo apps and actions {{{

if [ $UID -ne 0 ]; then
  alias svim='sudo -e'
  alias root='sudo su'
  alias scat='sudo cat'
  alias reboot='sudo systemctl reboot'
  alias poweroff='sudo systemctl poweroff'
  alias netctl='sudo netctl'
fi

# }}}
# Filesystem {{{

# Navigation
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'

# stat
alias du1='du --max-depth=1'

# search
alias ff='find . -name $*'
alias hist='history | grep'         # requires an argument
alias pgg='ps -Af | grep'           # requires an argument

# }}}
# Xclip {{{

alias xc='xclip -selection clipboard'	# copy to clipboard, ctrl+c, ctrl+shift+c
alias xcp='xclip -selection clipboard -o'	# paste from clipboard, ctrl+v, ctrl+shift+v
alias xcs='xclip -selection primary -o'	# paste from highlight, middle click, shift+insert

# }}}

# }}}
# Corrections {{{

alias cd..='cd ..'

# }}}
# Extra {{{

alias da='date "+%A, %B %d, %Y [%T]"'
alias openports='ss --all --numeric --processes --ipv4 --ipv6'

# }}}

# }}}
# Functions (more complex than aliases) {{{

# Open file manager in current directory, optional repeat count
f() { for i in {1..${1:=1}}; do nohup nautilus . >/dev/null 2>&1&; done }
# Open your terminal in current directory, optional repeat count
n() { for i in {1..${1:=1}}; do nohup $TERM >/dev/null 2>&1&; done }

# mkdir -p + cd
mkcd() { dir="$*"; mkdir -p "$dir" && cd "$dir"; }
# TODO
duc() { find -maxdepth ${1:=1} -type d | while read -r dir; do printf "%s:\t" "$dir"; find "$dir" -type f | wc -l; done }

# grep with short line truncation
greps() { grep -iRIoE ".{0,20}$1.{0,20}" $2 }

# Alias for {{{
  _aliases="$(alias -Lr 2>/dev/null || alias)"

  alias_for() {
    [[ $1 =~ '[[:punct:]]' ]] && return
    local found="$( echo "$_aliases" | sed -nE "/^alias ${1}='?(.+)/s//\\1/p" )"
    [[ -n $found ]] && echo "${found%\'}"
  }
# }}}
# Workarounds (app restarts, etc..) {{{

function erc { $EDITOR ~/.zshrc; rerc }
function rerc { source ~/.zshrc }
function repulse { pulseaudio -k && pulseaudio --start }
function remouse { sudo modprobe -r psmouse; sudo modprobe psmouse; }
function rexneur { pkill xneur && xneur & }
function repacman { sudo rm /var/lib/pacman/db.lck; }

# }}}

# }}}

zstyle :compinstall filename '/home/dmitriy/.zshrc'
# Launch tmux by default
[[ -z "$TMUX" ]] && tmux new

# References {{{

# ref. 1. solarized theme ANSI escape color codes {{{

# Base colors:
# see http://ethanschoonover.com/solarized

# ANSI escape color codes:
# simple - see http://www.hamiltonlabs.com/userguide/30-AnsiEscapeSequences.htm
# more extensive - see "SGR parameters" and "Color table" at
# http://en.wikipedia.org/wiki/ANSI_escape_code

# Color combinations:
#
#   ANSI Color code       Solarized
#   ~~~~~~~~~~~~~~~       ~~~~~~~~~
#   00    none
#   30    black           base2
#   01;30 bright black    base3
#   31    red             red
#   01;31 bright red      orange
#   32    green           green
#   01;32 bright green    base1
#   33    yellow          yellow
#   01;33 bright yellow   base0
#   34    blue            blue
#   01;34 bright blue     base00
#   35    magenta         magenta
#   01;35 bright magenta  violet
#   36    cyan            cyan
#   01;36 bright cyan     base01
#   37    white           base02
#   01;37 bright white    base03
#
# * for background, use '4' instead of '3' as a first digit
#                   or '10' instead of '01;3' for bright type

# }}}
# ref. 2. zsh completions {{{
# Some code copied from here: (originally, cherry-picked from oh-my-zsh)
# https://github.com/clvv/dotfiles/blob/master/.zsh/completion.zsh
# }}}

# }}}
# Server-specific {{{
[[ -f ~/rc.zsh ]] && source ~/rc.zsh
# }}}

## Profiling {{{

## set the trace prompt to include seconds, nanoseconds, script name and line number
#zmodload zsh/datetime
#setopt promptsubst
#PS4='+$EPOCHREALTIME %N:%i> '
## save file stderr to file descriptor 3 and redirect stderr (including trace
## output) to a file with the script's PID as an extension
#exec 3>&2 2>/tmp/startlog.$$
## set options to turn on tracing and expansion of commands contained in the prompt
#setopt xtrace prompt_subst

## }}}
## Profiling end {{{

## turn off tracing
#unsetopt xtrace
## restore stderr to the value saved in FD 3
#exec 2>&3 3>&-

## }}}

