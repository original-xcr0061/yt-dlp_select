# YT-DLP Select Script

A user-friendly Bash script to download videos and audio from YouTube (and other supported platforms) using [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [ffmpeg](https://ffmpeg.org/). The script allows selection of video/audio quality, format, and MP3 conversion with a consistent 256kbps output.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Menu Options](#menu-options)
- [Directory Setup](#directory-setup)
- [Notes](#notes)
- [References](#references)
- [License](#license)

## Features

- Downloads the **best available video and audio** and merges them into an MP4 container.  
- Allows custom selection of **video and audio format IDs** for advanced users.  
- Downloads audio-only streams and converts them to **256kbps MP3**.  
- Provides a clean, user-friendly **menu interface**.  
- Automatically handles file naming and merging with `ffmpeg`.  
- Includes error handling for invalid URLs, missing directories, or failed downloads.

## Requirements

- **Bash** (tested on Linux and macOS)  
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) (latest version recommended)  
- [ffmpeg](https://ffmpeg.org/) (required for audio conversion and merging)  
- Internet connection for downloading media

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/original-xcr0061/yt-dlp_select
   cd yt-dlp-select
   ```

2. Make the script executable:

   ```bash
   chmod +x yt-dlp-sel.sh
   ```

3. Ensure `yt-dlp` and `ffmpeg` are installed and accessible in your `PATH`. For example, on Ubuntu:

   ```bash
   sudo apt update
   sudo apt install yt-dlp ffmpeg
   ```

## Usage

Run the script:

```bash
./yt-dlp-sel.sh
```

1. Enter the **URL** of the video or audio content you want to download.
2. Select an option from the **menu**.

## Menu Options

### 1. Best Available Quality – Full Video

- Downloads the **best video and audio streams** available.
- Automatically merges them into an **MP4** container using `ffmpeg`.

### 2. Custom Format – Choose Video & Audio

- Displays all available **video and audio formats** for the provided URL.
- Prompts the user to input a **video format ID** and an **audio format ID**.
- Merges the selected streams into an **MP4** container.

### 3. Audio Only – 256kbps MP3 Output

- Downloads the **best audio-only stream**.
- Converts it to a **256kbps MP3** file using `ffmpeg`.
- Moves the final MP3 file to the designated **audio directory**.

### 4. Quit

- Exits the script.

## Directory Setup

Before running the script, ensure the following directories exist (or update them in the script):

```bash
# Video output directory
outputdir="$HOME/Videos"

# Audio output directory
audiodir="$HOME/Music/01_YT-DLP-mp3"
```

The script will exit with an error if these directories do not exist.

## Notes

- The script requires valid URLs starting with `http://` or `https://`.
- For **Custom Format** (Option 2), format IDs are displayed, and **both a video and audio ID are required**.
- MP3 conversion uses a constant bitrate of **256kbps**; the output quality is limited by the original audio source.
- Original video/audio streams are saved to `$outputdir`; converted MP3 files are moved to `$audiodir`.
- Errors during download or conversion are reported, and the script exits gracefully.

## References

- [yt-dlp Official Documentation](https://github.com/yt-dlp/yt-dlp)
- [ffmpeg Official Documentation](https://ffmpeg.org/documentation.html)

## License

This script is licensed under the **MIT License**. See the `LICENSE` file for details.

*Developed by XCR0061*
