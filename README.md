# mpv-playlists-manager
## Manage playlists for mpv from your linux terminal

## About mpm
Manage playlists that mpv reads either online or from local files/directories,
yt-dlp is used to download videos or just audio and in that case if we choose webm links,
ffmpeg will (if you want to) convert them in five different formats:
aac, flac, mp3, ogg, or wav. You can switch encoders by editing the config file (mpmrc),
and many more options to control mpv, ffmpeg, yt-dlp and download/playlists directories etc...

**Please read it before first run and change settings to your likings.**

- [help](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/help)

- [Supported websites](https://github.com/ytdl-org/youtube-dl/blob/master/docs/supportedsites.md)

[Youtube dedicated channel](https://www.youtube.com/@mpv-playlists-manager-mv8sh/featured)

**For installation, configuration and more please see the** [wiki page](https://github.com/archusXIV/mpv-playlists-manager/wiki)

## Please update your mpmrc file on each release
When upgrading mpm, a ~/.config/mpm/mpmrc.diff will be created and merged with your mpmrc file, of course a backup will be generated under mpmrc.orig. Remember some of the changes are **crucial**...

## Changelog: version 2.6-0
- Change the parallel_animation=progress to be more accurate.
- Added _SelectLocalFiles{,Options} functions in case use_fzf=no.
- Fixed bug in _FzfLoadMultiplePlaylists while downloading a playlist as audio.
- Added _LoadMultiplePlaylists function used when use_fzf is set to no in our config.

## Mpv interfaces
- Mpv terminal user interface can be used to pick & choose playlist items while mpv is running.

  Such as:
  - [mpvc](https://github.com/lwilletts/mpvc)   (available in the AUR)
  - [ncmpvc](https://gitlab.com/mpv-ipc/ncmpvc) (available in the AUR) ([cheatsheet](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/ncmpvc_cheatsheet))

  as usual set it in your mpmrc file.
```bash
# experimental
# can be yes (mpvc tui) no (control mpv using shortcuts, press B for details),
# or empty (mpv infos in the terminal).
use_mpvc="no"
# change your mpv Terminal User Interface here
# mpvc_tui="ncmpvc"
mpvc_tui="<your_mpv_tui_here>"
```
  - Or...
```bash
# Colors can be change in ~/.config/mpm/themerc.
mpvc_tui="native"
```
![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/mpm_player_v1.2.png)

## Integrated programs settings in mpmrc file
- I also provide a new script (somabox) to listen to somafm.com radio stations through option 5). Place it in your $PATH,
and change mpmrc setting to 'yes'
```bash
use_somabox="yes"
```

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/somabox_v0.7.png)
- As mentioned above mpv command line tools and terminal interface.
- ffmpeg, mpv, ytfzf & yt-dlp options can be set in your mpmrc through their respective bash arrays.
- Audio & Videos directories are defined in your [mpmrc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/mpmrc#L77) file (change them according to your locales).

## Themes
- A [themerc](https://github.com/archusXIV/mpv-playlists-manager/blob/main/doc/themerc) file is available to insert as many as you want "themes" instead of bloating up your mpmrc.

default theme will use your ~/.Xresources colors or your terminal preferences.

- When in mpmrc $mpvc_tui is empty, we can use hjkl keys in the main window for mpv control.

<table width="100%">
  <tr>
    <th>Retro</th>
    <th>Solarized</th>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/retro.png" />
    </td>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/solarized.png" />
    </td>
  </tr>
  <tr>
    <th>TokyoNight</th>
    <th>C64</th>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/tokyonight.png" />
    </td>
    <td width="50%">
      <img src="https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/c64.png" />
    </td>
  </tr>
</table>

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

- To find out how to convert hex colors in rgb colors, open your prefered color picker
and look at "red green blue" fields.

![screenshot](https://github.com/archusXIV/mpv-playlists-manager/blob/main/screenshots/color_picker.png)

More screenshots [here](https://github.com/archusXIV/mpv-playlists-manager/tree/main/screenshots)

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
