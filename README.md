# mpv-playlists-manager
## Manage playlists for mpv from your terminal.
Video link: https://www.youtube.com/watch?v=7OWO1vRL77A
```
user@linux ~ $
mpm --help
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_ver0.9-8.png)


This program is just a personal project, it can be written in a better way,
in another language but the goal is simply to manage playlists that mpv can read
either online or from local files/directories.

youtube-dl/yp-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will (if you want to) convert them in four different formats,
mp3, flac, ogg, or wav.

[Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md).

For a better experience I **recommend** a minimum terminal size of 1210x685 because of the youtube-dl
outputs that let you choose desired audio/video formats, if you want an automatic terminal
resizing just install [wmctrl](http://tripie.sweb.cz/utils/wmctrl/) an the script will take care of
that for you.
If you're a tiling window manager user, make it float or give it more room in the stack.
```
wmctrl -r :ACTIVE: -e 5,-1,-1,1210,685
        -----------   -- -- -- --- ---
             |         | |  |   |   |---> Window height
             |         | |  |   |-------> Window width             
             |         | |  |-----------> Window Y coordinates
             |         | |--------------> Window X coordinates
             |         |----------------> Gravity
             |--------------------------> Apply to the active window
```
Requests and contributions? Why not, have fun.

# dependencies
- [ffmpeg](https://ffmpeg.org/)
- [jq](https://stedolan.github.io/jq/)
- [mpv](https://mpv.io/)
- [ranger](https://github.com/ranger/ranger) (optional, see the help  option for details)
- [vim](https://www.vim.org/) (set as the EDITOR)
- [wmctrl](https://www.freedesktop.org/wiki/Software/wmctrl/) (optional)
- [youtube-dl](https://youtube-dl.org/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# installation
Before installing, please check paths variables in [function /lib/_LoadLoacal](/lib/_LoadLocal)
and then run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective used locations, feel free to change them.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
Re-run the install script to uninstall.
```
