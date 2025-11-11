# My bash config. Not much to see here; just some pretty standard stuff.

### EXPORT
export TERM="xterm-256color"           
export HISTCONTROL=ignoredups:erasedups
export EDITOR="emacsclient -t -a ''"   
export VISUAL="emacsclient -c -a emacs"

### SET MANPAGER

### "nvim" as manpager
export MANPAGER="nvim +Man!"

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### SETTING OTHER ENVIRONMENT VARIABLES
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi
export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/xmonad" # xmonad.hs is expected to stay here
export XMONAD_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/xmonad"
export XMONAD_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/xmonad"

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ALIASES ###

# vifmrun to vifm
alias vifm="$XDG_CONFIG_HOME/vifm/scripts/vifmrun"

# emacs
alias emacs="emacsclient -c -a 'emacs'" # GUI versions of Emacs
alias em="/usr/bin/emacs -nw" # Terminal version of Emacs
alias rem="killall emacs || echo 'Emacs server not running'; /usr/bin/emacs --daemon" # Kill Emacs and restart daemon..

# Changing "ls" to "eza"
alias ls='eza --icons -al --color=always --group-directories-first' # my preferred listing
alias la='eza --icons -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza --icons -l --color=always --group-directories-first'  # long format
alias lt='eza --icons -aT --color=always --group-directories-first' # tree listing
alias l.='eza --icons -al --color=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza --icons -al --color=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza --icons -al --color=always --group-directories-first ../../../' # ls on directory 3 levels up

# adding flags
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

### SETTING THE STARSHIP PROMPT ###
eval "$(starship init bash)"

### FZF ###
# Enables the following keybindings:
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
eval "$(fzf --bash)"

. "/home/jc/.deno/env"
# fnm
FNM_PATH="/home/jc/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
