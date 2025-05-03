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
# Dependencies
- [ffmpeg](https://ffmpeg.org/), [jq](https://stedolan.github.io/jq/), [mpv](https://mpv.io/), [socat](http://www.dest-unreach.org/socat/), [vim](https://www.vim.org/) (or any terminal text editor), [yt-dlp](https://github.com/yt-dlp/yt-dlp)

## Optionals
(recommanded for better experience)
- [fzf](https://github.com/junegunn/fzf), [ytfzf](https://github.com/pystardust/ytfzf), [mpvc](https://github.com/lwilletts/mpvc), [ncmpvc](https://gitlab.com/mpv-ipc/ncmpvc), [parallel](https://www.gnu.org/software/parallel/), [ranger](https://github.com/ranger/ranger) (or any terminal file manager), [ueberzug](https://github.com/ueber-devel/ueberzug), [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer), [youtube-dl](https://github.com/ytdl-org/youtube-dl)

## mpm can be launched also with these commands:

```
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

## Please update your mpmrc file on each release
When upgrading mpm, a ~/.config/mpm/mpmrc.diff will be created and merged with your mpmrc file, of course a backup will be generated under mpmrc.orig. Remember some of the changes are **crucial**...
To launch mpm **faster**, in your ~/.{bashrc,zshrc} add:
```
source ~/.config/mpm/mpmrc
source ~/.config/mpm/themerc
```

## Changelog:
- Fixed bug when removing links/titles from temporary lists.
- Added an option to check and upgrade mpm version, just type mpm --upgrade
- Now we can change the background color, just edit the bg variable in ~/.config/mpm/themerc, section "_Theme" on each options (themes names).

## Mpv interfaces
- Mpv terminal user interface can be used to pick & choose playlist items while mpv is running.

  Such as:
  - [mpvc](https://github.com/lwilletts/mpvc)   (available in the AUR)
  - [ncmpvc](https://gitlab.com/mpv-ipc/ncmpvc) (available in the AUR) ([cheatsheet](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/ncmpvc_cheatsheet))

  as usual set it in your mpmrc file.
```
# experimental
# can be yes (mpvc tui) no (control mpv using shortcuts, press B for details),
# or empty (mpv infos in the terminal).
use_mpvc="no"
# change your mpv Terminal User Interface here
# mpvc_tui="ncmpvc"
mpvc_tui="<your_mpv_tui_here>"
```
  - Or...
```
# Colors can be change in ~/.config/mpm/themerc.
mpvc_tui="native"
```
![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/mpm_player_v1.2.png)

## Integrated programs settings in mpmrc file
- I also provide a new script (somabox) to listen to somafm.com radio stations through option 5). Place it in your $PATH,
and change mpmrc setting to 'yes'
```
use_somabox="yes"
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/somabox_v0.7.png)
- As mentioned above mpv command line tools and terminal interface.
- ffmpeg, mpv, ytfzf & yt-dlp options can be set in your mpmrc through their respective bash arrays.
- Audio & Videos directories are defined in your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/mpmrc#L63) file (change them according to your locales).

## Using fzf
- Two methods are offered here:
  - If the **fzf** package is installed it will be used to search and copy audio/video urls from youtube,
  and to queue up local files.
  - In addition you can also use the **ytfzf** script (no longer maintained...)
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

<!-- ![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/mpm_v2.3-4.png) -->
<table width="100%">
  <tr>
    <th>Nord</th>
    <th>Solarized</th>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/nord.png" />
    </td>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/solarized.png" />
    </td>
  </tr>
  <tr>
    <th>TokyoNight</th>
    <th>C64</th>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/tokyonight.png" />
    </td>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/c64.png" />
    </td>
  </tr>
</table>

```
# apply your prefered colorscheme...
# !!! Change or add inside the below mainThemes array existing themes
# in ~/.config/mpm/themerc (_Theme function)!!!
mainThemes=(
    default blacksea dracula gotham
    gruvbox jellybeans monokai pistachio
    solarized TokyoNight vacuous zenburn
)
THEME="default"
```
Same thing for the native mpv tui.

```
# !!! Change or add inside the below nativeThemes array existing themes
# in ~/.config/mpm/themerc (_NativePlayerColors function)!!!
nativeThemes=( default c64 dark gruvbox molokai nord seoul256 )
native_tui_colors=default
```

- To find out how to convert hex colors in rgb colors, open your prefered color picker
and look at "red green blue" fields.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/mpm_screenshots/color_picker.png)

More screenshots [here](https://github.com/archusXIV/mpv-playlists-manager/tree/main/mpm_screenshots)

## Why ranger file manager?
(it can be any terminal file manager)
Because we are terminal users so we can navigate across our local media files.
You will also need some dependencies to make it functional, for example displaying image/video thumbnails preview
with [ffmpegthumbnailer](https://github.com/dirkvdb/ffmpegthumbnailer). Make sure $XDG_CONFIG_HOME/ranger/scope.sh is executable.
```
FILEMANAGER="ranger"
```

Requests and contributions? Why not, have fun.

## Credits
I would like to thanks all the devs that put their great work in the softwares I use and that I have implemented in this project and especially mister Brian Jhan Fox the father of the Bourne-Again SHell, even if I don't always use it the right way.