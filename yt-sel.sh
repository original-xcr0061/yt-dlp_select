#!/bin/bash

# Refer to YT-DLP wiki page for more information. https://github.com/yt-dlp/yt-dlp/wiki

#########################################
#       YT-DLP - DOWNLOAD QUALITY       #
#           SELECTIONS                  #
#                                       #
#########################################
#           by XCR0061                  #
#########################################

set -o errexit
#set -o xtrace

clear
tput setaf 208
echo "  ##################################### "
echo "  #   ____  ______________________    # "
echo "  #   \   \/  /\_   ___ \______   \   # "
echo "  #    \     / /    \  \/|       _/   # "
echo "  #    /     \ \     \___|    |   \   # "
echo "  #   /___/\  \ \______  /____|_  /   # "
echo "  #         \_/        \/       \/    # "
echo "  ##################################### "
echo "  #        YT-DLP Quality select.     # "
echo "  ##################################### "
echo ""
tput sgr0

PS3="$(tput setaf 6) $(tput bold)Please Select your Choice: $(tput sgr0) "
options=("Best Quality - Full Video" "Best Quality - Audio Only" "720p" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Best Quality - Full Video")
            tput setaf 6
            echo -e "$(tput bold) $(tput smul)\nDownloading Best Quality......$(tput rmul)"
            tput sgr0
            echo ""
            read -p "Please Enter/Paste URL: " url
            echo ""
            yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4 "$url"
            echo ""
            break
            ;;
        "Best Quality - Audio Only")
            tput setaf 6
            echo -e "$(tput bold) $(tput smul)\nNot yet available, still doing research!!$(tput rmul)"    
            tput sgr0
            echo ""
            echo ""
            ;;
        "720p")
            tput setaf 6
            echo -e "$(tput bold) $(tput smul)\nNot yet available, still doing research!!$(tput rmul)"    
            tput sgr0
            sleep 2
            echo ""
            echo ""
            ;;
        "Quit")
            echo ""
            break
            ;;
        *) echo "...Invalid option"
            echo ""
            ;;
    esac
done

