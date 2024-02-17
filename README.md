# mpv-playlists-manager
## Manage playlists for mpv from your linux terminal

## About mpm
This program is just a personal project, and I wrote it as a normy Linux user, it is simple (hum, not so much today lol)
The goal is to manage playlists that mpv reads either online or from local files/directories, 
youtube-dl/yt-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will (if you want to) convert them in four different formats,
mp3, flac, ogg, or wav. You can switch encoders by editing the config file (mpmrc).

In order to use mpm you **have** to create a symlink as follow:
```
ln -s /usr/bin/yt-dlp ~/.local/bin/youtube-dl # (if ~/.local/bin is in your $PATH)
```

- [help](https://github.com/archusXIV/mpv-playlists-manager/blob/main/help)

- [Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md)


Older version but still valide video (french spoken) link: https://www.youtube.com/watch?v=7OWO1vRL77A

```
mpm -c # edit mpm config
mpm -e # edit a playlist from a list
mpm -h # launches less /usr/local/share/doc/mpm/help
mpm -l # launches the play/download function
mpm -p # launches the load local function
mpm -v # prints mpm version
```
## Please update your mpmrc file on each release
When upgrading mpm, a ~/.config/mpm/mpmrc.diff will be created so you can merge new additions.

## New in version 1.6-2
- Launching local folder/files function simplified.
- Bugs fixed, little things here & there.

## recent additions
- ffmpeg, mpv, ytfzf & yt-dlp command line options can be set in your mpmrc through their respective bash arrays.
- Audio & Videos directories are defined in your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpmrc#L46) file (change them according to your locales).
- Editing playlists is done using two methods:

  - firstly by adding or removing urls manually with your chosen editor.

  - secondly by removing titles from a prompt (corresponding urls will be removed).
- Enable/disable checking for mpm updates in your mpmrc.

## Using fzf
- Two methods are offered here:
  If the fzf package is installed it will be used to search and copy audio/video urls from youtube.
  In addition you can also use the [ytfzf](https://github.com/pystardust/ytfzf) script
  if it is in your $PATH, it's options are available in the mpmrc file.

- In your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpmrc#L80) file activate it.

```
use_fzf="yes"
```

## Audio conversion done faster with parallel
- If installed, [parallel](https://www.gnu.org/software/parallel/) will launch multiple ffmpeg instances to speed up audio conversion.
- Just enable it in your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpmrc#L105) file

```
use_parallel="yes"
```

## Themes
- A [themerc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/themerc) file is available to insert as many as you want "themes" instead of bloating up your mpmrc.

default theme will use your ~/.Xresources colors or your terminal preferences.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/mpm_v1.6-2.png)


```
# edit your own theme in "$XDG_CONFIG_HOME"/mpm/themerc.
# apply your prefered colorscheme...
# AVAILABLE THEMES: default, dracula, blacksea, chocolat-pistache,
# gruvbox, gotham, monokai, TokyoNight, solarized, vacuous, zenburn

THEME="default"
```

- To find out how to convert hex colors in rgb colors, open your prefered color picker
and look at "red green blue" fields.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/color_picker.png)

More screenshots [here](https://github.com/archusXIV/mpv-playlists-manager/tree/main/mpm_screenshots)

For a better experience I **recommend** a minimum terminal size of 1260x738 because of the youtube-dl
outputs that let you choose desired audio/video formats, if you want an automatic terminal
resizing just install [wmctrl](https://github.com/dancor/wmctrl) an the script will take care of
that for you.
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
Because we are terminal users so we can navigate across our local media files to queue them in mpv.
You will also need some dependencies to make it functional, for example displaying image/video thumbnails preview
with [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer). Make sure $XDG_CONFIG_HOME/ranger/scope.sh is executable.
I also provide my ranger config directory to get you started if you're noob, drag it in ~/.config. Please use the help option for more information.

Requests and contributions? Why not, have fun.

# dependencies
- [ffmpeg](https://ffmpeg.org/)
- [fzf](https://github.com/junegunn/fzf), [ytfzf](https://github.com/pystardust/ytfzf) (optional)
- [jq](https://stedolan.github.io/jq/)
- [mpv](https://mpv.io/)
- [parallel](https://www.gnu.org/software/parallel/) (optional)
- [ranger](https://github.com/ranger/ranger) (optional, see the help option for details)
- [ueberzug](https://github.com/ueber-devel/ueberzug) (optional) might be in your distro's repo
- [vim](https://www.vim.org/) (set as the MPMEDITOR)
- [w3m](https://w3m.sourceforge.net/) (optional)
- [wmctrl](https://github.com/dancor/wmctrl) (optional)
- [youtube-dl](https://github.com/ytdl-org/youtube-dl)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)

# installation
Run the install.sh script as root, by default /usr/local/bin /usr/local/lib are the
respective used locations.
The install script will detect if mpm is already installed and in that case the prompt will be: [R]emove or [U]pgrade mpm? 

Otherwise the simple install function will run and create ~/.config/mpm/{mpmrc,themerc} files.
- Please check the [README_FIRST](https://github.com/archusXIV/mpv-playlists-manager/blob/main/README_FIRST) before first run.
```
git clone https://github.com/archusXIV/mpv-playlists-manager.git
cd mpv-playlists-manager
chmod +x install.sh
sudo ./install.sh
```