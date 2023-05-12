#!/bin/bash
# ----------------------------------------------------------------------------
# -- Create Symlinks to ~/.dotfiles ------------------------------------------
#
# This file replaces the user's existing configuration files with those
# contained in this directory (via symbolic links.)
#
# A backup folder is created to store the original files.
#
# ----------------------------------------------------------------------------


# -- Common settings ---------------------------------------------------------
#
user=$( echo "$USER" )
homedir=$( echo "$HOME")
timestamp=$(date +%Y%m%d_%H%M%S)


# -- Script source and destinations ------------------------------------------
#
script_dir="$(dirname $(readlink -f $0))"
config_dirname=".dotfiles"
new_config_location=${homedir}/${config_dirname}
backup_folder_name="${homedir}/BACKUP_${user}_config_files_${timestamp}"


# -- Color scheme ------------------------------------------------------------
#
col_red='\033[0;91m'
col_green='\033[0;92m'
col_yellow='\033[0;93m'
col_magenta='\033[0;95m'
col_cyan='\033[0;96m'
col_none='\033[0m'


# -- File commands (move/link) ------------------------------------------------
#
CMD_COPY="cp -rf "
CMD_COPY_DEEP="cp -rfL "
CMD_RM="rm -rf "
CMD_MV="mv -f "
CMD_LINK="ln -sf "


# -- Script Exit-Handler:  Normal exit -------------------------------------
#
function finish_success {
  echo -e "${col_cyan}-------------------------------------------------------------------${col_none}"
  echo -e "${col_green} >> SUCCESS${col_none}:  ${col_yellow}Complete!${col_none}"
  echo ""
}

# -- Script Exit-Handler:  Abnormal exit -------------------------------------
#
function finish_failed {
  echo -e "${col_cyan}-------------------------------------------------------------------${col_none}"
  echo -e "${col_red} >> ERROR${col_none}:  ${col_yellow}Abnormal exit - Incomplete${col_none}"
  echo ""
}

# -- TRAP:  Trap non-0 exits  ------------------------------------------------
#
trap '[ "$?" -eq 0 ] || finish_failed'  EXIT



# -- Begin Processing  -------------------------------------------------------
#
echo ""
echo -e "${col_cyan}-------------------------------------------------------------------${col_none}"
echo -e "${col_yellow} Replacing [USER=${col_magenta}${user}${col_yellow}]'s config files..${col_none}"
echo -e "${col_cyan}-------------------------------------------------------------------${col_none}"


# -- STAGE 1:  Backup Existing Files -----------------------------------------
#


# -- Create a backup folder in the user's homedir ----------------------------
#
echo -e " ${col_yellow}::${col_none} Creating backup folder :  ${col_cyan}${backup_folder_name}${col_none}"
mkdir -p  ${backup_folder_name} >& /dev/null


# -- Check for fatal error ---------------------------------------------------
#
if [[ ! -d ${backup_folder_name} ]]; then
  echo -e "    ${col_red}ERROR${col_none}: Could not create backup folder! [${col_red}fatal${col_none}]"
  exit -1
fi
echo ""


# -- Copy configuration files: .dotfiles -------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Archiving config files :  ${col_cyan}${config_dirname}${col_none} ${col_yellow}>>${col_none} "

if [[ -d  ${new_config_location} ]]; then
  ${CMD_COPY_DEEP}  ${new_config_location}         ${backup_folder_name}/
  ${CMD_RM}         ${new_config_location} 
  echo -e "[${col_green} SUCCESS ${col_none}]"
else
  echo -e "[${col_yellow} SKIPPED ${col_none}]"
fi


# -- Copy configuration files: BASH ------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Archiving config files :  ${col_cyan}Bash${col_none}      ${col_yellow}>>${col_none} "

if [[ -f ${homedir}/.bashrc ]]; then
  ${CMD_COPY_DEEP}  ${homedir}/.bashrc             ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.bashrc

  ${CMD_COPY_DEEP}  ${homedir}/.bash_profile       ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.bash_profile

  ${CMD_COPY_DEEP}  ${homedir}/.bash_logout        ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.bash_logout

  ${CMD_COPY_DEEP}  ${homedir}/.bash_config_files  ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.bash_config_files

  echo -e "[${col_green} SUCCESS ${col_none}]"
else
  echo -e "[${col_yellow} SKIPPED ${col_none}]"
fi


# -- Copy configuration files: VIM -------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Archiving config files :  ${col_cyan}Vim${col_none}       ${col_yellow}>>${col_none} "

if [[ -f ${homedir}/.vimrc ]]; then
  ${CMD_COPY_DEEP}  ${homedir}/.vimrc              ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.vimrc

  ${CMD_COPY_DEEP}  ${homedir}/.vim                ${backup_folder_name}/
  ${CMD_RM}         ${homedir}/.vim
  echo -e "[${col_green} SUCCESS ${col_none}]"
else
  echo -e "[${col_yellow} SKIPPED ${col_none}]"
fi


# -- Copy configuration files: FONTS ------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Archiving config files :  ${col_cyan}Fonts${col_none}     ${col_yellow}>>${col_none} "
if [[ -d ${homedir}/.fonts ]]; then
  ${CMD_COPY_DEEP}  ${homedir}/.fonts              ${backup_folder_name}/
  echo -e "[${col_green} SUCCESS ${col_none}]"
else
  echo -e "[${col_yellow} SKIPPED ${col_none}]"
fi

# DEBUG
#read -p "Press [Enter] key to continue..."


# -- STAGE 2:  Replace Files -------------------------------------------------
#
echo ""


# -- Replace configuration files: .dotfiles ----------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Replacing config files :  ${col_cyan}${config_dirname}${col_none} ${col_yellow}>>${col_none} "

#  echo "executing:  ${CMD_COPY}  ${script_dir}   ${new_config_location}"
  ${CMD_COPY_DEEP}  ${script_dir}                             ${new_config_location}
  echo -e "[${col_green} SUCCESS ${col_none}]"


# -- Replace configuration files: BASH ---------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Replacing config files :  ${col_cyan}Bash${col_none}      ${col_yellow}>>${col_none} "

  ${CMD_LINK}  ${new_config_location}/bash/.bashrc            ${homedir}/
  ${CMD_LINK}  ${new_config_location}/bash/.bash_profile      ${homedir}/
  ${CMD_LINK}  ${new_config_location}/bash/.bash_logout       ${homedir}/
  ${CMD_LINK}  ${new_config_location}/bash/.bash_config_files ${homedir}/
  echo -e "[${col_green} SUCCESS ${col_none}]"


# -- Replace configuration files: VIM ----------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Replacing config files :  ${col_cyan}Vim${col_none}       ${col_yellow}>>${col_none} "

  ${CMD_LINK}  ${new_config_location}/vim/.vimrc              ${homedir}/
  ${CMD_LINK}  ${new_config_location}/vim/.vim                ${homedir}/
  echo -e "[${col_green} SUCCESS ${col_none}]"


# -- Replace configuration files: FONTS --------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Replacing config files :  ${col_cyan}Fonts${col_none}     ${col_yellow}>>${col_none} "

  ${CMD_LINK}  ${new_config_location}/fonts/.fonts            ${homedir}/
  echo -e "[${col_green} SUCCESS ${col_none}]"



# -- STAGE 3:  Activate config ------------------------------------------------
#
echo ""


# -- Activate config: BASH ---------------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Activating config files:  ${col_cyan}Bash${col_none}      ${col_yellow}>>${col_none} "

  echo -e "[${col_magenta} Enter 'source ~/.bashrc' to activate ${col_none}]"


# -- Activate config: VIM ----------------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Activating config files:  ${col_cyan}Vim${col_none}       ${col_yellow}>>${col_none} "

  echo -e "[${col_yellow} SKIPPED ${col_none}]"



# -- Activate config: FONTS --------------------------------------------------
#
echo -n -e " ${col_yellow}::${col_none} Activating config files:  ${col_cyan}Fonts${col_none}     ${col_yellow}>>${col_none} "

  echo -e "[${col_yellow} SKIPPED ${col_none}]"


# -- Finished Processing (normally) ------------------------------------------
#
finish_success



# -- End of File  ------------------------------------------------------------
#" ----------------------------------------------------------------------------
