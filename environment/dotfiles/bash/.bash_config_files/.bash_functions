# ----------------------------------------------------------------------------
# -- BASH Functions ----------------------------------------------------------
#
# This file defines the command functions to be used in a Bash session.
#
# This file is intended to be "sourced" by .bashrc:
#
#    if [ -f <path>/.bash_functions ]; then
#     source <path>/.bash_functions
#    fi
#
#  Notes:  Bash functions can be defined multiple ways:
#
#           1) A function name with parentheses:
#                  my_function() {
#                    echo "My Function"
#                  }
#
#           2) A function name with parentheses on a single line:
#                  my_function() { echo "My Function"; }
#
#           3) Using the keyword 'function' (parentheses optional):
#                  function my_function() {
#                    echo "My Function"
#                  }
#
# ----------------------------------------------------------------------------
FILE_SOURCED_FUNCTIONS=TRUE


# -- Fetch this file's directory ---------------------------------------------
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )



# -- Source Common functions -------------------------------------------------
if [ -z $FILE_SOURCED_FUNCTIONS_COMMON ]; then
   if [ -f  ${SCRIPT_DIR}/.bash_functions_common ]; then
     source ${SCRIPT_DIR}/.bash_functions_common
   fi
fi


# -- Source Search functions -------------------------------------------------
if [ -z $FILE_SOURCED_FUNCTIONS_SEARCH ]; then
   if [ -f  ${SCRIPT_DIR}/.bash_functions_search ]; then
     source ${SCRIPT_DIR}/.bash_functions_search
   fi
fi


# -- Source GIT functions ----------------------------------------------------
if [ -z $FILE_SOURCED_FUNCTIONS_GIT ]; then
   if [ -f  ${SCRIPT_DIR}/.bash_functions_git ]; then
     source ${SCRIPT_DIR}/.bash_functions_git
   fi
fi



# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------

