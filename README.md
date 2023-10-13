# mpv-playlists-manager
## Manage playlists for mpv from your linux terminal.
Older version but still valide video (french spoken) link: https://www.youtube.com/watch?v=7OWO1vRL77A

```
mpm -c # edit mpm config
mpm -e # edit a playlist from a list
mpm -h # launches less /usr/local/share/doc/mpm/help
mpm -l # launches the play/download function
mpm -p # launches the load local function
mpm -v # prints mpm version
```
## New in version 1.3-4
- If you exit the script by typing "x", and if temporary lists exist you will be prompted to save them.
- New way to save a playlist as described in version 1.3-2 but in a more secured way...by entering a number greater than your total playlists collection. For example if you have 22 saved playlists, just enter 23 and you' ll be prompted to type a name for the new one.
- If you enter an existing playlist number or name, a red prompt appears for confirmation.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/saving_a_playlist_as_an_existing_one.png)


## New in version 1.3-3
- When downloading a few links from a video playlist, a subdirectory named as the playlist will be created,
  so we know which file is from.
  
  /videos_dir/myplaylist_name_dir/some_file.mp4.
- Minor code review.

## version 1.3-4 main screen.
![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/mpm_v1.3-4.png)
More screenshots [here](https://github.com/archusXIV/mpv-playlists-manager/tree/main/mpm_screenshots)

This program is just a personal project, and I wrote it as a normy Linux user (it is simple),
The goal is to manage self created playlists that mpv reads either online or from local files/directories.

youtube-dl/yp-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will (if you want to) convert them in four different formats,
mp3, flac, ogg, or wav. You can switch encoders by editing the config file (mpmrc).

- [help](https://github.com/archusXIV/mpv-playlists-manager/blob/main/help)

- [Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md)

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
- [ueberzug](https://github.com/seebye/ueberzug) (optional) might be in your distro's repo
- [vim](https://www.vim.org/) (set as the MPMEDITOR)
- [w3m](https://w3m.sourceforge.net/) (optional)
- [wmctrl](https://www.freedesktop.org/wiki/Software/wmctrl/) (optional)
- [youtube-dl](https://youtube-dl.org/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# installation
Before installing, please check paths variables in [function /lib/_LoadLocal](/lib/_LoadLocal)
and then run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective used locations, feel free to change them in the install script and line 29 in mpm itself.
The install script will detect if mpm is already installed and in that case the prompt will be: [R]emove or [U]pgrade mpm? 
Otherwise the simple install function will run.
- Please check the [README_FIRST](https://github.com/archusXIV/mpv-playlists-manager/blob/main/README_FIRST) before first run.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
mkdir -p ~/.config/mpm
cp -f ./mpmrc ~/.config/mpm/mpmrc
```
