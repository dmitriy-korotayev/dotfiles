# Shell environment {{{

# Defaults {{{

export LANG="en_US.utf-8"
export LC_ALL="en_US.utf-8"
export BROWSER="google-chrome:chromium"
export EDITOR="vim"

# }}}
# Extended functionality {{{

shopt -s autocd  # cd, writing only path to directory
shopt -s extglob # extended glob

# Use bash-completion, if available
if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi

# History file options {{{

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# limits
export HISTFILESIZE=10000
export HISTSIZE=10000

# append to history file
shopt -s histappend

export PROMPT_COMMAND='history -a'

# }}}

# }}}
# Look {{{

export PS1="\W \$ " # Status in terminal
cowthink $(fortune) # Cow greeting you on launch

# }}}

# }}}
# Package-specific {{{

# Ruby {{{

export GEM_HOME=~/.gem/ruby/2.1.0
PATH=$PATH:$HOME/.gem/ruby/2.0.0/bin:$HOME/.gem/ruby/2.1.0/bin

# }}}
# PHPBrew {{{

source ~/.phpbrew/bashrc
export PHPBREW_SET_PROMPT=1

# }}}

# }}}
# Aliases (options and variations for existing, convenient shortcuts) {{{

# Default options for existing {{{

alias mkdir='mkdir -p -v'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'                    # reports disk usage
alias du='du -c -h'                 # folder disk usage
alias diff='colordiff'              # requires colordiff package
alias info='info --vi-keys'
alias ping='ping -c 5'              # ping 5 times

# }}}
# Variations {{{

# ls {{{

alias ls='ls -hF --color=auto'

alias ll='ls -l'
alias lr='ls -R'                    # recursive ls
alias la='ll -A'

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

# }}}
# Yaourt {{{

alias y="sudo yaourt"              # default action       - Yaourt
alias ys="sudo yaourt -S"          # '[s]ync'             - install one or more packages
alias yu="sudo yaourt -Syu"        # '[u]pdate'           - upgrade all packages to their newest version
alias yua="sudo yaourt -Syua"      # '[u]pdate with [aur]'- upgrade all packages to their newest version + aur
alias yr="sudo yaourt -Rs"         # '[r]emove'           - uninstall one or more packages
alias yss="yaourt -Ss"             # '[Ss]earch'           - search for a package using one or more keywords
alias yi="yaourt -Si"              # '[i]nfo'             - show information about a package
alias ylo="yaourt -Qdt"            # '[l]ist [o]rphans'   - list all packages which are orphaned
alias yc="sudo yaourt -Scc"        # '[c]lean cache'      - delete all not currently installed package files
alias ylf="yaourt -Ql"             # '[l]ist [f]iles'     - list all files installed by a given package

# }}}
alias wine32="WINEARCH=win32 WINEPREFIX=~/.wine32 wine"

# }}}
# Convenient shortcuts {{{

alias nt='yakuake-session -w "$(pwd)"' # New tab with current directory
# Wine {{{
alias photoshop = 'WINEARCH=win32 WINEPREFIX=~/.wine32 wine "C:\\Program Files\\Adobe\\Adobe Photoshop CS6\\Photoshop.exe"' #Z:%f
# }}}
# Sudo {{{

if [ $UID -ne 0 ]; then
  alias svim='sudo vim'
  alias root='sudo su'
  alias scat='sudo cat'
  alias reboot='sudo systemctl reboot'
  alias poweroff='sudo systemctl poweroff'
  alias netctl='sudo netctl'
fi

# }}}
# Directories {{{

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
# Work {{{

alias c='app/console' # usual symfony console

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

function mkcd { dir="$*"; mkdir -p "$dir" && cd "$dir"; }
# Resets {{{

function rekde { rm /var/tmp/kdecache-dmitriy/plasma_theme_default_v2.0.kcache; kquitapp plasma-desktop; sleep 1; plasma-desktop; }
function remouse { sudo modprobe -r psmouse; sudo modprobe psmouse; }
function rekmix { pkill kmix; kmix & }
function rexneur { pkill xneur; xneur & }
function repacman { sudo rm /var/lib/pacman/db.lck; }

# }}}
# .workscript function {{{

work() {
  # Helpful
  die() { echo $1; exit 666; }
  shopt -s expand_aliases

  # Script defaults
  dir=`pwd`
  script=".workscript"

  # Input and inclusion
  [ "$1" == "stop" ] && action='stop' || action='start'
  [ -f $dir/$script ] || die "$script doesn't exist"
  [ -x $dir/$script ] || die "$script can't be executed, check permissions"

  # Get function from file (function name, colon and indented code
  echo $(grep -P "^$action:\n(\s\s.+)(\n?^\w+:.+)?\Z" .workscript) # TODO: not working

  #source $dir/$script

  ## Executions
}

# }}}

# }}}
