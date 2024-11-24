# mpv-playlists-manager
## Manage playlists for mpv from your linux terminal

## About mpm
Manage playlists that mpv reads either online or from local files/directories, 
youtube-dl/yt-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will (if you want to) convert them in five different formats:
aac, flac, mp3, ogg, or wav. You can switch encoders by editing the config file (mpmrc),
and many more options to control mpv, ffmpeg, yt-dlp and download/playlists directories etc...

**Please read it before first run and change settings to your likings.**

- [help](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/help)

- [Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md)


[Youtube dedicated channel](https://www.youtube.com/@mpv-playlists-manager-mv8sh/featured)

## can be launch also from these commands

```
mpm -c|--config   # edit mpm config
mpm -e|--edit <?> # edit a playlist from a list; or with an argument:
                    mpm --edit <myPlaylistName> (no extension suffix).
mpm -h|--help     # launches less /usr/local/share/doc/mpm/help
mpm -l|--load <?> # launches the play/download function; or with an argument:
                    mpm --load <myPlaylistName> (no extension suffix).
mpm -f|--local    # load local files/folder(s)
mpm -v|--version  # prints mpm version
```

## Please update your mpmrc file on each release
When upgrading mpm, a ~/.config/mpm/mpmrc.diff will be created and merged with your mpmrc file, of course a backup will be generated under mpmrc.orig. Remember some of the changes are **crucial**...
To launch mpm **faster**, in your ~/.{bashrc,zshrc} add:
```
source ~/.config/mpm/mpmrc
source ~/.config/mpm/themerc
```

## Changelog:
- Added a test in _CopyMediaUrl function to check audio availability when pasting links.
- Added new window size settings in ~/.config/mpm/mpmrc when copying link in web pages.
```
copy_width=1260
copy_height=380
```

- Added a new script (somabox) to listen to somafm.com radio stations through _LoadLocalMenu option. Place it in your $PATH.
- Added also an option to load radio playlists files (.pls,.m3u, etc...) if you store them in a specific folder, fill in this option in your configuration file:
```
radio_dir="/path/to/web_radio_dir"
```

- Added [mpvc_tui_cheatsheet](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/mpmrc#L166) variable in mpmrc in case your mpv tui program isn't ncmpvc and you have a cheatsheet to check at some point.
  - Use the full path for that.
- Added [_ManualsMenu](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/_ManualsMenu.png) function so you can get help configuring mpmrc.
  - Just press 'M' in the main window to access this feature.

## Recent additions
- Mpv terminal user interface can be used to pick & choose playlist items while mpv is running.

  Such as:
  - [mpvc](https://github.com/lwilletts/mpvc)   (available in the AUR)
  - [ncmpvc](https://gitlab.com/mpv-ipc/ncmpvc) (available in the AUR) ([cheatsheet](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/ncmpvc_cheatsheet))

  as usual set it in your mpmrc file.
```
# experimental
# can be yes (mpvc tui) no (stop mpv by typing Q),
# or empty (mpv infos in the terminal).
use_mpvc="no"
# change your mpv Terminal User Interface here
# mpvc_tui="ncmpvc"
mpvc_tui="<your_mpv_tui_here>"
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/ncmpvc_integration.png)

## Integrated programs settings in mpmrc file
- I also provide a new script (somabox) to listen to somafm.com radio stations through option 5). Place it in your $PATH,
and change mpmrc setting to 'yes'
```
use_somabox="no"
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/somabox_v0.3.png)
- As mentioned above mpv command line tools and terminal interface.
- ffmpeg, mpv, ytfzf & yt-dlp options can be set in your mpmrc through their respective bash arrays.
- Audio & Videos directories are defined in your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/mpmrc#L54) file (change them according to your locales).

## Using fzf
- Two methods are offered here:
  - If the **fzf** package is installed it will be used to search and copy audio/video urls from youtube,
  and to queue up local files.
  - In addition you can also use the **ytfzf** script
  if it is in your $PATH, options are available in the mpmrc file.

- In your mpmrc file activate it.

```
use_fzf="yes"
```

## Audio conversion done faster with parallel
- If installed, **parallel** will launch multiple ffmpeg instances to speed up audio conversion.
- Just enable it in your mpmrc file

```
use_parallel="yes"
```
- If not installed then we'll use xargs -P (number of process) {} ffmpeg....which is also fast, otherwise ffmpeg treat files one by one. Make sure parallel_conversion is set to yes in your mpmrc file.
```
parallel_conversion="yes"
```

## Themes
- A [themerc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/themerc) file is available to insert as many as you want "themes" instead of bloating up your mpmrc.

default theme will use your ~/.Xresources colors or your terminal preferences.

- When in mpmrc $mpvc_tui is empty, we can use hjkl keys in the main window for mpv control.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/mpm_v2.1-6.png)


```
# edit your own theme in "$XDG_CONFIG_HOME"/mpm/themerc.
# apply your prefered colorscheme...
# AVAILABLE THEMES: default, blacksea, dracula, gruvbox, gotham, jellybeans,
# monokai, pistachio, nord, TokyoNight, solarized, vacuous, zenburn, zorange
THEME="default"
```

- To find out how to convert hex colors in rgb colors, open your prefered color picker
and look at "red green blue" fields.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/color_picker.png)

More screenshots [here](https://github.com/archusXIV/mpv-playlists-manager/tree/main/mpm_screenshots)

## Wmctrl settings
For a better experience I **recommend** a minimum terminal size of 1260x738 because of the youtube-dl
outputs that let you choose desired audio/video formats, if you want an automatic terminal
resizing just install **wmctrl** an the script will take care of that for you.
If you're a tiling window manager user, make it float or give it more room in the stack.
```
wmctrl -r :ACTIVE: -e 5,-1,-1,1260,738
        -----------   -- -- -- --- ---
             |         | |  |   |   |---> Window height
             |         | |  |   |-------> Window width             
             |         | |  |-----------> Window Y coordinates
             |         | |--------------> Window X coordinates
             |         |----------------> Gravity
             |--------------------------> Apply to the active window
```
## Why ranger file manager?
(it can be any terminal file manager)
Because we are terminal users so we can navigate across our local media files.
You will also need some dependencies to make it functional, for example displaying image/video thumbnails preview
with [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer). Make sure $XDG_CONFIG_HOME/ranger/scope.sh is executable.
```
FILEMANAGER="ranger"
```

Requests and contributions? Why not, have fun.

# Dependencies
- [ffmpeg](https://ffmpeg.org/)
- [jq](https://stedolan.github.io/jq/)
- [mpv](https://mpv.io/)
- [socat](http://www.dest-unreach.org/socat/) (to control mpv)
- [vim](https://www.vim.org/) (or any terminal text editor)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# Optionals
(recommanded for better experience)
- [fzf](https://github.com/junegunn/fzf), [ytfzf](https://github.com/pystardust/ytfzf)
- [mpvc](https://github.com/lwilletts/mpvc) [ncmpvc](https://gitlab.com/mpv-ipc/ncmpvc)
- [parallel](https://www.gnu.org/software/parallel/)
- [ranger](https://github.com/ranger/ranger) (see the help option for details)
- [ueberzug](https://github.com/ueber-devel/ueberzug) (might be in your distro's repo)
- [w3m](https://w3m.sourceforge.net/) (to display thumbnails in URxvt/xterm)
- [wmctrl](https://github.com/dancor/wmctrl)
- [youtube-dl](https://github.com/ytdl-org/youtube-dl)

# Installation
Run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective destinations.
The install script will detect if mpm is already installed and in that case the prompt will be: [R]emove or [U]pgrade mpm? 

Otherwise the simple install function will run and create ~/.config/mpm/{mpmrc,themerc} files.
- Please check the [README_FIRST](https://github.com/archusXIV/mpv-playlists-manager/blob/main/README_FIRST) before first run.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
```
## Credits
I would like to thanks all the devs that put their great work in the softwares I use and that I have implemented in this project and especially mister Brian Jhan Fox the father of the Bourne-Again SHell, even if I don't always use it the right way.