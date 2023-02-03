# mpv-playlists-manager
Manage playlists for mpv from your terminal.
Video link: https://www.youtube.com/watch?v=7OWO1vRL77A
```
user@linux ~ $
mpm --help
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_v0.9-7.png)


This program is just a personal project, it can be written in a better way,
in another language but the goal is simply to manage playlists that mpv can read
either online or from local files/directories.

youtube-dl/yp-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will convert them in four different formats,
mp3, flac, ogg, or wav.

Requests and contributions are welcomed, have fun.

# dependencies
- [ffmpeg](https://ffmpeg.org/)
- [jq](https://stedolan.github.io/jq/)
- [mpv](https://mpv.io/)
- [ranger](https://github.com/ranger/ranger) (see the help  option for details)
- [vim](https://www.vim.org/) (set as the EDITOR)
- [youtube-dl](https://youtube-dl.org/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# installation

Before installing, please check paths variables in function /lib/_LoadLoacal
and then run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective used locations, feel free to change them.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
Re-run the install script to uninstall.
```
