# ----------------------------------------------------------------------------
# -- BASH logout -------------------------------------------------------------
#
#  This script is executed when an interactive BASH login shell exits
#
# ----------------------------------------------------------------------------

# Local colors
BLK='\033[0;90m'
RED='\033[0;91m'
GRN='\033[0;92m'
YEL='\033[0;93m'
BLU='\033[0;94m'
MAG='\033[0;95m'
CYN='\033[0;96m'
WHT='\033[0;97m'
OFF='\033[0m'

# Timestamp (current)
export TIME_AT_LOGOUT=`date '+%F %r'`

# Display
echo -e ""
echo -e "--------------------------------------------------------------------"
echo -e " Disconnecting ${MAG}$user${OFF} @ ${MAG}$(hostname)${OFF}.."
echo -e "   - Login  : ${YEL}$TIME_AT_LOGIN ${OFF}"
echo -e "   - Logout : ${YEL}$TIME_AT_LOGOUT${OFF}"
echo -e "--------------------------------------------------------------------"
echo -e ""

# Delay and exit
sleep 1.5


# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------
