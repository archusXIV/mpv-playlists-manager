#!/bin/bash
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# version 2.2-8

# shellcheck disable=SC2154
red=$'\e[38;2;206;34;30m';
endColor=$'\e[0m';

_diffRc() {
    # we execute this file as root so we need to provide the right username
    # to give ownership back to the right user.
    read -r -p ' Please enter your username: ' username
    local CONF_DIR MPMRC usergroup
    CONF_DIR="/home/$username/.config/mpm"
    MPMRC="$CONF_DIR/mpmrc"
    usergroup=$(
        awk -F':' -v user="$username" '$0 ~ user { print $3":"$4 }' < /etc/passwd
    )

    if [[ -f $MPMRC ]]; then

        diff -u "$MPMRC" doc/mpmrc > "$MPMRC".diff

        patch -b "$MPMRC" < "$MPMRC".diff

        printf '%s\n' " ${red}~/.config/mpm/mpmrc.diff created," \
        " original file has been saved as mpmrc.orig.${endColor}"
        printf '\n'
        tail -n 5 ./README_FIRST
        printf '\n'
        read -r -p " ${red}Edit $MPMRC now? [Y/n] enter editor name: ${endColor}" edit editor
        case "$edit" in
            Y|y)
                cd "$CONF_DIR" && {
                    if [[ $editor == vim ]]; then
                        vim -d "$MPMRC" "$MPMRC".orig
                    else
                        "$editor" "$MPMRC" "$MPMRC".orig
                    fi
                }
            ;;
            n|N)
                chown -R "$grpuser" "$CONF_DIR" && exit 0
            ;;
            *)
                printf '%s\n' \
                " ${red}Ok don't forget to update it before first run.${endColor}"
            ;;
        esac
    else
        mkdir --parents "$CONF_DIR"
        cp doc/{mpmrc,themerc} "$CONF_DIR"
        
        printf '%s\n' " ${red}~/.config/mpm/mpmrc created." \
        " Please edit your mpmrc file before first run.${endColor}"
    fi

    chown -R "$usergroup" "$CONF_DIR"

}

_install() {
    cp --verbose --force ./mpm /usr/local/bin
    mkdir --verbose --parents /usr/local/lib/mpm && \
    cp --verbose --recursive --force ./lib/* /usr/local/lib/mpm/
    mkdir --verbose --parents /usr/local/share/doc/mpm && {
        cp --verbose --force doc/* /usr/local/share/doc/mpm/
        cp --verbose --force README.md /usr/local/share/doc/mpm
    }
    mkdir --verbose --parents /usr/share/licenses/mpm && \
    cp --verbose --force ./LICENSE /usr/share/licenses/mpm/LICENSE
    
    chmod 755 /usr/local/lib/mpm/*
    chmod 755 /usr/local/bin/mpm

    _diffRc
}

_uninstall() {
    rm --verbose --recursive --force /usr/local/bin/mpm
    rm --verbose --recursive --force /usr/local/lib/mpm
    rm --verbose --recursive --force /usr/local/share/doc/mpm
    rm --verbose --recursive --force /usr/share/licenses/mpm
}

date
printf '\n'
if [[ -x /usr/local/bin/mpm ]] && [[ -d /usr/local/lib/mpm ]]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: '
    case "$REPLY" in
        r|R)
            _uninstall
            printf '%s\n' "hope you liked it anyway..."
        ;;
        u|U)
            _uninstall
            _install
            printf '%s\n' "for usage run: mpm --help"
        ;;
        *)
            printf '%s\n' " Wrong option $REPLY, try again." && exit 1
        ;;
    esac
else
    _install
fi