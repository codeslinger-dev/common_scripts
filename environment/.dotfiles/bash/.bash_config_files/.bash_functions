# ----------------------------------------------------------------------------
# -- BASH Functions ----------------------------------------------------------
#
# This file defines the command functions to be used in a Bash session.
#
# This file is intended to be "sourced" by .bashrc:
#
#    if [ -f /<path>/.bash_functions ]; then
#     source /<path>/.bash_functions
#    fi
#
# ----------------------------------------------------------------------------

function func_f() { grep -F -I -s -r -n --color --include="$2" "$1" ./; }

function func_fs()
{
  # Show input params
  echo ""
  echo "Searching.."
  echo " - search string   = \"${1}\""
  echo " - search files    = \"${2}\""
  echo " - search results  ="
  echo ""

  # perform search
  start_time=$SECONDS
  func_f "$1" "$2"
  stop_time=$SECONDS
  duration=$( echo ${stop_time} - ${start_time} | bc -l)

  # Show output params
  echo ""
  echo "Searching.. Done!"
  echo " - total time      =  ${duration}s"
}


# Return a colour that contrasts with the given colour
# Bash only does integer division, so keep it integral
function contrast_colour ()
 {
    local r g b luminance
    colour="$1"

    if (( colour < 16 )); then # Initial 16 ANSI colours
        (( colour == 0 )) && printf "15" || printf "0"
        return
    fi

    # Greyscale # rgb_R = rgb_G = rgb_B = (number - 232) * 10 + 8
    if (( colour > 231 )); then # Greyscale ramp
        (( colour < 244 )) && printf "15" || printf "0"
        return
    fi

    # All other colours:
    # 6x6x6 colour cube = 16 + 36*R + 6*G + B  # Where RGB are [0..5]
    # See http://stackoverflow.com/a/27165165/5353461

    # r=$(( (colour-16) / 36 ))
    g=$(( ((colour-16) % 36) / 6 ))
    # b=$(( (colour-16) % 6 ))

    # If luminance is bright, print number in black, white otherwise.
    # Green contributes 587/1000 to human perceived luminance - ITU R-REC-BT.601
    (( g > 2)) && printf "0" || printf "15"
    return
}

# Print a coloured block with the number of that colour
function print_colour ()
{
    local colour="$1" contrast
    contrast=$(contrast_colour "$1")
    printf "\e[48;5;%sm" "$colour"                # Start block of colour
    printf "\e[38;5;%sm%3d" "$contrast" "$colour" # In contrast, print number
    printf "\e[0m "                               # Reset colour
}

# Starting at $1, print a run of $2 colours
function print_run ()
{
    local i
    for (( i = "$1"; i < "$1" + "$2" && i < printable_colours; i++ )) do
        print_colour "$i"
    done
    printf "  "
}

# Print blocks of colours
function print_blocks()
{
    local start="$1" i
    local end="$2" # inclusive
    local block_cols="$3"
    local block_rows="$4"
    local blocks_per_line="$5"
    local block_length=$((block_cols * block_rows))

    # Print sets of blocks
    for (( i = start; i <= end; i += (blocks_per_line-1) * block_length )) do
        printf "\n" # Space before each set of blocks
        # For each block row
        for (( row = 0; row < block_rows; row++ )) do
            # Print block columns for all blocks on the line
            for (( block = 0; block < blocks_per_line; block++ )) do
                print_run $(( i + (block * block_length) )) "$block_cols"
            done
            (( i += block_cols )) # Prepare to print the next row
            printf "\n"
        done
    done
}

#
# Print 256 colors and values
function print_shell_colors()
{
  printable_colours=256

  printf "\n"
  printf "%s \n" "---------------------------------------------------------------------------"
  printf "%s \n" " Bash's available 256-color palette"
  printf "%s \n" "---------------------------------------------------------------------------"
  printf "\n"

  print_run 0 16               # first 16 colours are spread over the whole spectrum
  printf "\n"
  print_blocks  16 231  6 6 3  # 6x6x6 colour cube between 16 and 231 inclusive
  print_blocks 232 255 12 2 1  # 24 shades of grey

  printf "\n"
  printf "%s \n" "---------------------------------------------------------------------------"
  printf "\n"

}




# -- End of File  ------------------------------------------------------------
# ----------------------------------------------------------------------------

