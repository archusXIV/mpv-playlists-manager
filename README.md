# mpv-playlists-manager
manage playlists for mpv

This program is just a personal project, it can be written in a better way,
in another language but the goal is simply to manage playlists that mpv can read
either online or from local files/directories.

youtube-dl/yp-dlp is used to download videos or just audio and in that case if
we choose webm links, ffmpeg will convert them in mp3/320kbps.

I'm open to requests and contributions, have fun.

# dependencies

ffmpeg
jq
mpv
ranger
youtube-dl
yt-dlp

# installation

Just run the install.sh script, by default /usr/local/bin /usr/local/lib are the
respective used locations, feel free to change them.
