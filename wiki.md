# mpv-playlists-manager Wiki

Welcome to the mpm wiki! This tool helps you manage your mpv media playlists with advanced features and customization options.

## Table of Contents
- [Installation](#installation) [Dependencies](#dependencies) [Usage](#usage) [Configuration](#configuration) [Features](#features) [Themes](#themes)

## Installation

Clone the repository
```bash
git clone https://github.com/username/mpv-playlists-manager.git
```

Run the install.sh script or use the Makefile
```bash
sudo ./install.sh
# or
sudo make install && make config
```

## Dependencies

Essential dependencies:
- mpv
- yt-dlp
- ffmpeg
- socat
- a terminal text editor

Optionals but recommended:
- GNU parallel
- fzf
- mediainfo
- ytfzf
- xclip or wl-copy
- wmctrl (for terminals that do not support xterm protocols)
- ranger (default file manager)

## Usage

Without any option, mpm uses its configuration but it can be launch otherwise.
## #
```bash
mpm -c|--config   # edit mpm config
mpm -e|--edit <?> # edit a playlist from a list; or with an argument:
                    mpm --edit <myPlaylistName> (no extension suffix).
mpm -h|--help     # launches less /usr/local/share/doc/mpm/help
mpm -l|--load <?> # launches the play/download function; or with an argument:
                    mpm --load <myPlaylistName> (no extension suffix).
mpm -f|--local    # load local files/folder(s)
mpm -u|--upgrade  : whatever checking updates is enabled or not,
                    you can upgrade mpm through this option now.
mpm -v|--version  # prints mpm version
```
You may also use:
```
man mpm
```

For more detailed usage instructions, please see the [Usage guide](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/help).

## Configuration

To launch mpm **faster**, in your ~/.{bashrc,zshrc} add:
```bash
source ~/.config/mpm/mpmrc
source ~/.config/mpm/themerc
```
The configuration file is located at `~/.config/mpm/mpmrc`. Key configuration options include:

### Directory Structure
- Main Directory: `~/.local/share/mpm`
- Playlists: `~/local/share/mpm/playlists`
- Schedules: `~/local/share/mpm/schedules`
- Temporary Files: `~/local/share/mpm/tmp`

### Media Directories
- Music: `~/Music`
- Videos: `~/Videos`
- Audio downloads: `~/Music/mpm_audios`
- Video downloads: `~/Videos/mpm_videos`

## Features

### Playlist Management
- Create and edit playlists
- Play local files or directories
- Schedule downloads
- Direct downloads from YouTube
- Video ID management
- Parallel processing support for downloads and audio conversion

### Media Controls
- Integration with mpv player
- mpvc support for playback control
- Native mpv TUI interface

### Format Support
- Audio formats: AAC, FLAC, MP3, OGG, WAV
- Video support through mpv
- YouTube integration via yt-dlp

### Using fzf
- Two methods are offered here:
  - If the **fzf** package is installed it will be used to search and copy audio/video urls from youtube,
  and to queue up local files.
  - In addition you can also use the **ytfzf** script (no longer maintained...)
  if it is in your $PATH, options are available in the mpmrc file.

- In your mpmrc file activate it.

```
use_fzf="yes"
```

### Using GNU parallel
- If installed, **parallel** will launch multiple ffmpeg instances to speed up audio conversion.
- Just enable it in your mpmrc file

```bash
use_parallel="yes"
```
- If not installed then we'll use xargs -P (number of process) {} ffmpeg....which is also fast, otherwise ffmpeg treat files one by one. Make sure parallel_conversion is set to yes in your mpmrc file.
```bash
parallel_conversion="yes"
```
- Now parallel can also be used to download temporary/collection playlists.
- Just enable it in your mpmrc file
```bash
use_parallel_downloads="yes"
```
- Finaly set where parallel creates its temporary directory and configs
```bash
export PARALLEL_HOME="/tmp/parallel"
```

## Themes

Edit your themes in `~/.config/mpm/themerc`:
- default (your terminal set of colors)
- dracula
- embers
- gotham
- gruvbox
- jellybeans
- monokai
- [and more](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/themerc)...

## Applying themes

Just press Ctrl+B then proceed or edit your mpmrc file

```bash
# apply your prefered colorscheme...
# !!! Change or add inside the below mainThemes array existing themes
# in ~/.config/mpm/themerc (_Theme function)!!!
mainThemes=(
    default blacksea dracula embers gotham
    gruvbox jellybeans monokai pistachio
    solarized TokyoNight vacuous zenburn
)
THEME=default
```
Same thing for the native mpv tui.

```bash
# !!! Change or add inside the below nativeThemes array existing themes
# in ~/.config/mpm/themerc (_NativePlayerColors function)!!!
nativeThemes=( default c64 dark embers gruvbox molokai nord seoul256 )
native_tui_colors=default
```