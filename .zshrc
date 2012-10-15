
# See if we can use colors.
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"


# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'argu.: %d'
zstyle ':completion:*' completer _expand _complete _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' format "%{${fg_bold[red]}%}# Completing %d%{${fg_no_bold[default]}%}:"
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z} m:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' prompt "%{${fg_bold[red]}%}# Corrections%{${fg_no_bold[default]}%}: (%e errors)"
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1024
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# enable color support of ls and also add handy aliases
alias ls='ls -G'
alias la='ls -a' # List All
alias ll='ls -l' # Long Listing
alias lsa='ls -ld .*' # List only dotfiles
alias lsbig='ls -lSh *(.) | head' # List biggest
alias lsd='ls -ld *(-/DN)' # List only directories and links to them
alias lsnew='ls -lrt *(.) | tail' # List newest
alias lsold='ls -lrt *(.) | head' # List oldest
alias lssmall='ls -lSh *(.) | head' # List smallest

export LSCOLORS='Cxfxcxdxbxegedabagacad'

# export LS_COLORS='*.swp=-1;44;37:*,v=5;34;93:*.vim=35:no=0:fi=0:di=32:ln=36:or=1;40:mi=1;40:pi=31:so=33:bd=44;37:cd=44;37:*.jpg=1;32:*.jpeg=1;32:*.JPG=1;32:*.gif=1;32:*.png=1;32:*.jpeg=1;32:*.ppm=1;32:*.pgm=1;32:*.pbm=1;32:*.c=1;32:*.C=1;33:*.h=1;33:*.cc=1;33:*.awk=1;33:*.pl=1;33:*.gz=0;33:*.tar=0;33:*.zip=0;33:*.lha=0;33:*.lzh=0;33:*.arj=0;33:*.bz2=0;33:*.tgz=0;33:*.taz=33:*.html=36:*.htm=1;34:*.doc=1;34:*.txt=1;34:*.o=1;36:*.a=1;36'

# screen cooperation
setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
        local CMD=${1[(wr)^(*=*|sudo|-*)]}
        echo -ne "\ek$CMD\e\\"
    fi
}
# Decide whether to set a screen title
if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
else
	PR_STITLE=''
fi

# Fix Home and End key
# rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
# # for xterm
# bindkey "\eOH" beginning-of-line
# bindkey "\eOF" end-of-line

# # for Konsole
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Options
setopt MAIL_WARNING
setopt NO_NOTIFY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt CDABLE_VARS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt GLOB_COMPLETE
setopt LIST_PACKED
setopt LIST_ROWS_FIRST
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt AUTO_CONTINUE
setopt LONG_LIST_JOBS

# Quickly input `../'
rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot

# Integrate zle with xclip 
kill-line() { zle .kill-line ; echo -n $CUTBUFFER | xclip -i }
zle -N kill-line # bound on C-k

yank() { LBUFFER=$LBUFFER$(xclip -o) }
zle -N yank # bound on C-y

# Custom Key Bindings
bindkey "\e;" vi-pound-insert
bindkey . rationalise-dot

# Alias
Browser="firefox"
Reader="okular"
alias sudo='A=`alias` sudo  '
alias fat="mount -o 'user,utf8,umask=000,quiet'"
okular () {/usr/bin/okular $* 2> /dev/null}
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

alias -s pdf=$Reader
alias -s eps=$Reader
alias -s djvu=$Reader
alias -s zip="unzip -l"
alias -s rar="7z l"
alias -s 7z="7z l"
alias -s tar="tar --list -f"
alias -s tgz="tar --list -f"
alias -s com=$Browser
alias -s net=$Browser
alias -s org=$Browser

#export variables
export PS1="$PR_STITLE%{${fg[cyan]}%}$SHLVL%{${fg_bold[cyan]}%}-> %{${fg_no_bold[cyan]}%}%60<...<%~%<<
%{${fg_bold[yellow]}%}%n%{${fg_bold[white]}%}@%m%#%{${fg_no_bold[default]}%} "
export RPS1="%{${fg_no_bold[red]}%}%(?..(%?%))%{${fg_no_bold[default]}%}"

export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:$PATH"
#export PAGER="most"

#HOMEBREW
export HOMEBREW_CC="clang"

#alias for cloudy
#alias cloudy='~/Documents/UK/Ferland/cloudy/trunk/source/cloudy.exe'
#alias nmcloudy='~/Documents/UK/Ferland/cloudy/newmole/source/cloudy.exe'
#alias modcloudy='~/Documents/UK/Ferland/cloudy/trunk/modifiedsource/cloudy.exe'
#alias modnmcloudy='~/Documents/UK/Ferland/cloudy/newmole/modifiedsource/cloudy.exe'
#alias c08='~/Documents/UK/Ferland/cloudy/c08.01/source/cloudy.exe'
#alias wycloudy='~/Documents/UK/Ferland/cloudy/WangYe/source/cloudy.exe'

#alias for server
alias cloud9='ssh wangye0206@cloud9.pa.uky.edu'
alias radegund='ssh wangye0206@radegund.pa.uky.edu'
alias wolkje='ssh wangye0206@wolkje.pa.uky.edu'
alias ukyhpc='ssh ywa224@dlx.uky.edu'
