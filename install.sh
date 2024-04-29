#!/bin/bash
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# version 1.8-6

# shellcheck disable=SC2154
_diffRc() {
    # we execute this file as root so we need to provide the right username
    read -r -p ' Please enter your username: ' username
    local CONF_DIR MPMRC THEMERC
    CONF_DIR="/home/$username/.config/mpm"
    MPMRC="$CONF_DIR/mpmrc"
    THEMERC="$CONF_DIR/themerc"
    
    if [[ -f $MPMRC && -f $THEMERC ]]; then

        diff -U 9999999 "$MPMRC" doc/mpmrc > "$MPMRC".diff

        diff -U 9999999 "$THEMERC" doc/themerc > "$THEMERC".diff

        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc.diff created.\e[0m\n'
        printf '\e[38;2;206;34;30m~/.config/mpm/themerc.diff created.\e[0m\n'

    elif [[ -f $MPMRC && ! -f $THEMERC ]]; then

        diff -U 9999999 "$MPMRC" doc/mpmrc > "$MPMRC".diff

        cp doc/themerc "$CONF_DIR"

        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc.diff created.\e[0m\n'
        printf '\e[38;2;206;34;30m~/.config/mpm/themerc created.\e[0m\n'
    else
        mkdir --parents "$CONF_DIR"
        cp doc/{mpmrc,themerc} "$CONF_DIR"
        
        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc created, edit your settings there.\e[0m\n'
    fi

    chown -R 1000:1000 "$CONF_DIR"

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
    printf '%s\n' "for usage run: mpm --help"
}

_uninstall() {
    rm --verbose --recursive --force /usr/local/bin/mpm
    rm --verbose --recursive --force /usr/local/lib/mpm
    rm --verbose --recursive --force /usr/local/share/doc/mpm
    rm --verbose --recursive --force /usr/share/licenses/mpm

    printf '%s\n' "hope you liked it anyway..."
}

date
printf '\n'
if [[ -x /usr/local/bin/mpm ]] && [[ -d /usr/local/lib/mpm ]]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: '
    case "$REPLY" in
        r|R)
            _uninstall
        ;;
        u|U)
            if [[ $(find ./lib -type f | wc -l) = \
                $(find /usr/local/lib/mpm -type f | wc -l) ]]; then
                _uninstall
                _install
            elif [[ $(find ./lib -type f | wc -l) != \
                $(find /usr/local/lib/mpm -type f | wc -l) ]]; then
                _uninstall
                _install
            fi
        ;;
        *)
            echo " Wrong option $REPLY, try again." && exit 1
        ;;
    esac
else
    _install
fi
