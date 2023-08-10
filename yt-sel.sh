#!/bin/bash

## Refer to YT-DLP wiki page for more information. https://github.com/yt-dlp/yt-dlp/wiki

#########################################
#       YT-DLP - DOWNLOAD QUALITY       #
#           SELECTIONS                  #
#                                       #
#########################################
#           by XCR0061                  #
#########################################

set -o errexit

## Uncomment For debugging
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

## Request URl and check if valid
read -p "$(tput setaf 6) $(tput bold)Please Enter URL: $(tput sgr0)" URL
echo
if [[ $URL =~ ^https?:// ]]
then
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
            ## Download Video & Audio then merge
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading Full Video:$(tput rmul) $(tput sgr0)"
            yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4 "$URL"
            echo

            ## Print done
            echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
            break
            ;;

        ## Option 2
        "1080p HD - Full Video")
            ## Download Video & Audio then merge
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading 1080p:$(tput rmul) $(tput sgr0)"
            yt-dlp -S res:1080,ext:mp4:m4a --merge-output-format mp4 "$URL"
            echo

            ## Print done
            echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
            break
            ;;

        ## Option 3
        "Audio Only - 192kbps MP3 Output")
            ## Download the m4a file
            echo -e "$(tput setaf 6) $(tput bold) $(tput smul)\nDownloading Audio only:$(tput rmul) $(tput sgr0)"
            yt-dlp -f 'bestaudio[ext=m4a]' "$URL"

            ## Get the downloaded filename & convert to MP3
            filename="$(yt-dlp --get-filename -f 'bestaudio[ext=m4a]' "$URL")"
            ffmpeg -i "$filename" -b:a 192k "${filename%.m4a}.mp3"

            ## Check if the conversion was successful
            if [ $? -eq 0 ] ; then
                ## MP3 File name clean-up and move to Music folder
                echo -e "$(tput bold) $(tput smul)\nCleaning up and Moving to Music Folder: /Music/YT-DLP-mp3$(tput rmul) $(tput sgr0)"

                ## Remove space, brackets, and the hash from mp3 file
                filename2=$(ls *.mp3)
                clean_filename="${filename2%% \[*}.mp3"
                echo

                rm -v "$filename"
                echo

                if [ -d "$HOME/Music/YT-DLP-mp3" ] ; then
                    mv -v "$filename2" "$HOME/Music/YT-DLP-mp3/$clean_filename"
                    echo

                    ## Print done
                    echo -e "$(tput setaf 6) $(tput bold)\nAll Done$(tput sgr0)"
                else
                    echo "\nUnable to move mp3 file: Directory /Music/YT-DLP-mp3 does not exist"
                    exit 1
                fi
            else
                echo "Conversion failed. Original file retained."
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
