#!/usr/bin/env bash

# Script name: install.sh version 2.6-0
# Author: Barret E <https://github.com/archusXIV/mpv-playlists-manager>
# Licensed under the GPLv2
#
# You need root privileges to execute this file.
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# It also will copy/modify files in ~/.config/mpm/{mpmrc,themerc}.

red=$'\e[38;2;206;34;30m';
endColor=$'\e[0m';

[[ $(whoami) != 'root' ]] && {
    echo " ${red}This script must be run as root.${endColor}"
    exit 1
}

read -rp ' Please enter your username: ' username
CONF_DIR="/home/$username/.config/mpm"
MPMRC="$CONF_DIR/mpmrc"
THEMERC="$CONF_DIR/themerc"
# we execute this file as root so we need to provide the right username
# to give ownership back to the right user.
usergroup=$(
        awk -F':' -v user="$username" '
            $0 ~ user { print $3":"$4 }
        ' < /etc/passwd
)

_editConfig() {
    printf '%s\n' " ${red}~/.config/mpm/mpmrc.diff created," \
    " original file has been saved as mpmrc.orig.${endColor}"
    tail -n 7 ./README_FIRST
    printf '\n'
    read -rp " ${red}Edit $MPMRC now? [Y/n] enter an editor name (eg: y vim): ${endColor}" \
    edit editor
    case "$edit" in
        [yY])
            cd "$CONF_DIR" && {
                if [[ $editor == vim ]]; then
                    vim -d "$MPMRC" "$MPMRC".orig
                else
                    "$editor" "$MPMRC" "$MPMRC".orig
                fi
            }
            chown -R "$usergroup" "$CONF_DIR" && exit 0
        ;;
        [nN])
            # setting ownership back to the user
            chown -R "$usergroup" "$CONF_DIR" && exit 0
        ;;
        *)
            printf '%s\n' \
            " ${red}Ok don't forget to update it before first run.${endColor}"
        ;;
    esac
}

_diffRc() {

    if [[ -f $MPMRC && -f $THEMERC ]]; then
        diff -u "$MPMRC" doc/mpmrc > "$MPMRC".diff
        patch -b "$MPMRC" < "$MPMRC".diff
        diff -u "$THEMERC" doc/themerc > "$THEMERC".diff
        patch -b "$THEMERC" < "$THEMERC".diff
        _editConfig
    elif [[ -f $MPMRC ]]; then
        diff -u "$MPMRC" doc/mpmrc > "$MPMRC".diff
        patch -b "$MPMRC" < "$MPMRC".diff
        _editConfig
    else
        mkdir --parents "$CONF_DIR"
        cp doc/{mpmrc,themerc} "$CONF_DIR"
        printf '%s\n' " ${red}~/.config/mpm/mpmrc created." \
        " Please edit your mpmrc file before first run.${endColor}"
        chown -R "$usergroup" "$CONF_DIR"
    fi

}

_install() {

    cp --verbose --force ./mpm /usr/local/bin
    mkdir --verbose --parents /usr/local/lib/mpm && \
    cp --verbose --recursive --force ./lib/* /usr/local/lib/mpm/
    mkdir --verbose --parents /usr/local/share/doc/mpm/extra && {
        cp --verbose --force {doc/*,README.md,README_FIRST} /usr/local/share/doc/mpm/
        cp --verbose --force --recursive extra/* /usr/local/share/doc/mpm/extra/
    }
    mkdir --verbose --parents /usr/share/licenses/mpm && \
    cp --verbose --force ./LICENSE /usr/share/licenses/mpm/LICENSE
    mkdir --verbose --parents /usr/local/man/man1 && \
    cp --verbose --force ./man/mpm.1 /usr/local/man/man1/mpm.1

    chmod 755 /usr/local/lib/mpm/*
    chmod 755 /usr/local/bin/mpm

    _diffRc

}

_uninstall() {

    rm --verbose --recursive --force /usr/local/bin/mpm
    rm --verbose --recursive --force /usr/local/lib/mpm
    rm --verbose --recursive --force /usr/local/share/doc/mpm
    rm --verbose --recursive --force /usr/share/licenses/mpm
    rm --verbose --force /usr/local/man/man1/{mpm.1,mpm.1.gz}

}

printf '\n'
if [[ -x /usr/local/bin/mpm ]] && [[ -d /usr/local/lib/mpm ]]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: '
    case "$REPLY" in
        [rR])
            _uninstall
            printf '%s\n' " hope you liked it anyway..."
        ;;
        [uU])
            _uninstall
            _install
            printf '%s\n' " for usage run: mpm --help or man mpm"
        ;;
        *)
            printf '%s\n' " Wrong option $REPLY, try again." && exit 1
        ;;
    esac
else
    _install
fi
