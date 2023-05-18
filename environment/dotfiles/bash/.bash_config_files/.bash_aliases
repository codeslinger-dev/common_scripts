# ----------------------------------------------------------------------------
# -- BASH Aliases ------------------------------------------------------------
#
# This file defines the command aliases to be used in a Bash session.
#
# This file is intended to be "sourced" by .bashrc:
#
#    if [ -f /<path>/.bash_aliases ]; then
#     source /<path>/.bash_aliases
#    fi
#
# ----------------------------------------------------------------------------


# -- Use color, if supported -------------------------------------------------
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  # Common commands
  alias    ls='ls --color=auto'
  alias  grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias  diff='diff --color=auto'

  # GCC output:
  #
  #       error=01;31  |  error markers         |  Bold Red
  #     warning=01;35  |  warning markers       |  Bold Magenta
  #        note=01;36  |  note markers          |  Bold Cyan
  #       caret=01;32  |  caret line            |  Bold Green
  #       locus=01     |  location information  |  Bold
  #       quote=01     |  quoted text           |  Bold
  #
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

fi

# Alias for function that displays the
# ANSI-terminal color palette codes
alias print-terminal-colors='print_ansi_colors'

# Move up directories
alias  ..='cd ..'
alias ...='cd ../..'

# Some more 'ls' aliases
#  - groups dot-files together
alias  l='LC_COLLATE=C ls  -lF'
alias ll='LC_COLLATE=C ls -AlF'
alias la='LC_COLLATE=C ls -alF'

# Bash shortcuts
alias  s='source ~/.bashrc'
alias  h='history'
alias hs='history | grep'

# GVIM shortcuts
alias    e='gvim'
alias edit='gvim'

# Force 'less' to interpret terminal color codes by default
alias less='less -R'

# Show just my running processes
alias psme="ps -aef | grep ${USER}"

# Type "please" to add sudo to your previous command
alias please='sudo $(fc -ln -1)'

# Launch Web Browsers
alias   ffox='firefox       &> /dev/null &'
alias chrome='google-chrome &> /dev/null &'

# Search aliases (defined in .bash_functions)
alias   f='func_find'
alias  fs='func_find_stats'
alias  fu='func_find_undecorated'

alias  ff='func_find_follow'
alias ffs='func_find_follow_stats'
alias ffu='func_find_follow_undecorated'

# Enables simple aliases to be sudo'ed.
#  - ref: http://www.gnu.org/software/bash/manual/bashref.html#Aliases
alias sudo='sudo ';

# Use colordiff, if available
if type 'colordiff' &> /dev/null; then
    alias diff='colordiff'
fi

# Gather system hardware specs and dump them to a local HTML file
alias dump-hw-specs='sudo lshw -html > ./hardware_specs.html; echo "Created file => ./hardware_specs.html"'

# xterm
alias   x='xterm_with_color "white"'
alias  x1='xterm_with_color "red"'
alias  x2='xterm_with_color "blue"'
alias  x3='xterm_with_color "green"'
alias  xc='xterm_with_color'


# -- Source GIT aliases ------------------------------------------------------
if [ -f  ~/.bash_config_files/.bash_aliases_git ]; then
  source ~/.bash_config_files/.bash_aliases_git
fi


# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------
