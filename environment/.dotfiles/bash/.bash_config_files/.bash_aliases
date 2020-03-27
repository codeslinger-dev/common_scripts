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

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

fi

# Alias for function that displays the
# 256-color palette for Bash, including
# values
alias show_bash_colors='print_shell_colors'


# Some more 'ls' aliases
#  - groups dot-files together
alias  l='LC_COLLATE=C ls  -lF'
alias ll='LC_COLLATE=C ls -AlF'
alias la='LC_COLLATE=C ls -alF'

# Bash shortcuts
alias s='source ~/.bashrc'
alias h='history'
alias hs='history | grep'

# GVIM shortcuts
alias e='gvim'
alias edit='gvim'

# Force 'less' to interpret terminal color codes by default
alias less='less -R'

# Show just my running processes
alias psme="ps -aef | grep ${USER}"

# Type "please" to add sudo to your previous command
alias please='sudo $(fc -ln -1)'

# Launch Web Browser
alias ff='firefox &> /dev/null &'
alias chrome='google-chrome &> /dev/null &'

# Search aliases (defined in .bash_functions)
alias  f='func_f'
alias fs='func_fs'

# Gather system hardware specs and dump them to a local HTML file
alias dump_hw_specs='sudo lshw -html > ./hardware_specs.html; echo "Created file => ./hardware_specs.html"'


# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------
