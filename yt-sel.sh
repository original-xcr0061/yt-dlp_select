#!/bin/bash

## Refer to YT-DLP wiki page for more information. https://github.com/yt-dlp/yt-dlp/wiki

##############################################
#          YT-DLP - DOWNLOAD QUALITY         #
#               SELECT SCRIPT                #
#                                            #
##############################################
#                  by XCR0061                #
##############################################

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
echo "  #           YT-DLP Script.          # "
echo "  ##################################### "
echo ""
tput sgr0

##############################################
############### Script Setup #################

## Exit If any command returns a non-zero
set -o errexit
##  Exit if an uninitialized variable is used
set -u

## Uncomment For debugging
#set -o xtrace

## Set Video output Directory (Refer to yt-dlp documentation for setting default output Directory)
outputdir="$HOME/Videos"

## Set Audio output Directory
audiodir="$HOME/Music/01_YT-DLP-mp3"

##############################################

## Check if above Directories exist
if [ ! -d "$outputdir" ] || [ ! -d "$audiodir" ]; then
    echo -e "\nPlease Update Setup or Create Directories"
    echo -e "-- Either Directory \"$outputdir\" or \"$audiodir\" does not exist --"
    echo
    exit 1
fi

## Request URL and check if valid
read -p "$(tput setaf 6) $(tput bold)Please Enter URL: $(tput sgr0)" URL
echo

if [[ $URL =~ ^https?:// ]] ; then
    echo "MENU:"
else
    echo "Invalid URL"
    echo
    exit 1
fi

## MENU Options (4) & selection prompt
PS3="$(tput setaf 6) $(tput bold)Please Select your Choice: $(tput sgr0) "

options=("Best available Quality - Full Video" "1080p HD - Full Video" "Audio Only - 192kbps MP3 Output" "Quit")
select opt in "${options[@]}"
do
    case $opt in

        ## Option 1
        "Best available Quality - Full Video")

            ## Download Best Video & Audio then merge into mp4 container
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading Full Video:$(tput rmul) $(tput sgr0)"
            yt-dlp -f "bv[ext=mp4]+ba[ext=m4a]/b" --merge-output-format mp4 -o "$outputdir/%(title)s.%(ext)s" "$URL"
            echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
            echo
            break
            ;;

        ## Option 2
        "1080p HD - Full Video")

            ## Download 1080 Video & Audio then merge into mp4 container
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading 1080p:$(tput rmul) $(tput sgr0)"
            yt-dlp -S res:1080,ext:mp4:m4a --merge-output-format mp4 -o "$outputdir/%(title)s.%(ext)s" "$URL"
            echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
            echo
            break
            ;;

        ## Option 3
        "Audio Only - 192kbps MP3 Output")

            ## Download the m4a file
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading Audio only:$(tput rmul) $(tput sgr0)"
            yt-dlp -f 'ba[ext=m4a]' -o "$outputdir/%(title)s.%(ext)s" "$URL"

            ## Get the downloaded filename & convert to MP3
            inputfile="$(yt-dlp --get-filename -f 'bestaudio[ext=m4a]' -o "$outputdir/%(title)s.%(ext)s" "$URL")"
            ffmpeg -i "$inputfile" -b:a 192k "${inputfile%.m4a}.mp3"
            echo

            ## Check if the conversion to mp3 was successful
            if [ $? -eq 0 ] ; then

                ## Delete downloaded file and move MP3 to audiodir selected in setup
                echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nCleaning up and Moving MP3 file to Folder: \"$audiodir\"$(tput rmul) $(tput sgr0)"
                echo
                outputfile="${inputfile%.m4a}.mp3"
                rm -v "$inputfile"
                mv -v "$outputfile" "$audiodir/"
                echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
            else
                echo
                echo "Conversion failed. Original file retained."
                echo
                exit 1
            fi

            echo
            break
            ;;

        ## Option 4
        "Quit")
            echo
            break
            ;;

        ## If unavailable option was selected
        *)
            echo "...Invalid option"
            echo
            ;;
    esac
done
