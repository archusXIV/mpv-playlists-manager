# mpv-playlists-manager
## Manage playlists for mpv from your terminal.
Video link: https://www.youtube.com/watch?v=7OWO1vRL77A
```
user@linux ~ $ mpm --help
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_v.1.0.1.png)

First of, github mention this repository as a python project but MPM is whritten in bash,
and python because I have pushed my ranger configurations files whritten in that language.

This program is just a personal project, and I wrote it as a normy Linux user (it is simple),
The goal is to manage self created playlists that mpv reads either online or from local files/directories.

youtube-dl/yp-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will (if you want to) convert them in four different formats,
mp3, flac, ogg, or wav.

[help](https://github.com/archusXIV/mpv-playlists-manager/blob/main/help)

[Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md)

For a better experience I **recommend** a minimum terminal size of 1210x735 because of the youtube-dl
outputs that let you choose desired audio/video formats, if you want an automatic terminal
resizing just install [wmctrl](http://tripie.sweb.cz/utils/wmctrl/) an the script will take care of
that for you.
If you're a tiling window manager user, make it float or give it more room in the stack.
```
wmctrl -r :ACTIVE: -e 5,-1,-1,1210,735
        -----------   -- -- -- --- ---
             |         | |  |   |   |---> Window height
             |         | |  |   |-------> Window width             
             |         | |  |-----------> Window Y coordinates
             |         | |--------------> Window X coordinates
             |         |----------------> Gravity
             |--------------------------> Apply to the active window
```
## Why ranger file manager?
Because we are terminal users so we can navigate across our local media files to queue them in mpv.
You will also need some dependencies to make it functional, for example displaying image/video thumbnails preview
with [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer). Make sure $XDG_CONFIG_HOME/ranger/scope.sh is executable.
I also provide my ranger config directory to get you started if you're noob, drag it in ~/.config. Please use the help option for more information.

Requests and contributions? Why not, have fun.

# dependencies
- [ffmpeg](https://ffmpeg.org/)
- [jq](https://stedolan.github.io/jq/)
- [mpv](https://mpv.io/)
- [ranger](https://github.com/ranger/ranger) (optional, see the help  option for details)
- [ueberzug](https://github.com/seebye/ueberzug) (optional) might be in your distro repo
- [vim](https://www.vim.org/) (set as the EDITOR)
- [w3m](https://w3m.sourceforge.net/) (optional)
- [wmctrl](https://www.freedesktop.org/wiki/Software/wmctrl/) (optional)
- [youtube-dl](https://youtube-dl.org/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# installation
Before installing, please check paths variables in [function /lib/_LoadLocal](/lib/_LoadLocal)
and then run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective used locations, feel free to change them.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
Re-run the install script to uninstall.
```
