# .bashrc
# ----------------------------------------------------------------------------
# -- BASH Resources Configuration --------------------------------------------
#
#  This file configures the current (interactive) BASH shell.
#
# ----------------------------------------------------------------------------


# -- If not running interactively, don't do anything -------------------------
case $- in
    *i*) ;;
      *) return;;
esac


# -- Source global definitions -----------------------------------------------
if [ -f /etc/bashrc ]; then
      . /etc/bashrc
fi


# -- History settings --------------------------------------------------------
shopt -s histappend
HISTSIZE=2000
HISTFILESIZE=2000000
HISTCONTROL=ignoreboth


# -- Update the values of LINES and COLUMNS after windows resize -------------
shopt -s checkwinsize


# -- Make less more friendly for non-text input files, see lesspipe(1) -------
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# -- Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# -- Force a color-prompt configuration --------------------------------------
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi


# -- Setup git-prompt variables ----------------------------------------------
if [ -f ~/.bash_config_files/.git_prompt ]; then
 source ~/.bash_config_files/.git_prompt
fi


# -- Define the Bash prompt --------------------------------------------------
if [ "$color_prompt" = yes ]; then
   if [[ -f ~/.bash_config_files/.bash_prompt ]]; then
        source ~/.bash_config_files/.bash_prompt
   else
      PS1='\n\[\033[01;34m\]\w\[\033[00m\]\n[\d \@] \[\033[01;32m\]\u @ \h\[\033[00m\]:  '
   fi
else
    PS1='\n$\u @ \h:\w\$ '
fi
unset color_prompt force_color_prompt


# -- If xterm, set the title to 'user @ host: dir' ---------------------------
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u @ \h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# -- Enable programmable completion features ---------------------------------
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
   source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
   source   /etc/bash_completion
  fi
fi

# -- Add user's executable files to PATH -------------------------------------
if [ -d $HOME/scripts ]; then
  PATH="$HOME/scripts:$PATH"
fi

if [ -d $HOME/bin ]; then
  PATH="$HOME/bin:$PATH"
fi


# -- Source aliases ----------------------------------------------------------
if [ -f ~/.bash_config_files/.bash_aliases ]; then
 source ~/.bash_config_files/.bash_aliases
fi


# -- Source functions --------------------------------------------------------
if [ -f ~/.bash_config_files/.bash_functions ]; then
 source ~/.bash_config_files/.bash_functions
fi


# -- Source any per-host custom settings -------------------------------------
if [ -f ~/.bash_settings_custom ]; then
 source ~/.bash_settings_custom
fi


# -- Finally, display login greeting -----------------------------------------
if [ -f ~/.bash_config_files/.bash_greeting ]; then
 source ~/.bash_config_files/.bash_greeting
fi


# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------
