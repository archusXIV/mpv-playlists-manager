#!/bin/bash
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# version 1.4-7

_diffRc() {
    
    read -r -p ' Please enter your username: ' user
    local MPMRC_DIR MPMRC THEMERC
    MPMRC_DIR="/home/$user/.config/mpm"
    MPMRC="$MPMRC_DIR/mpmrc"
    THEMERC="$MPMRC_DIR/themerc"
    
    if [[ -f $MPMRC && -f $THEMERC ]]; then

        diff -U 9999999 "$MPMRC" \
        ./mpmrc > "$MPMRC".diff

        diff -U 9999999 "$THEMERC" \
        ./themerc > "$THEMERC".diff

        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc.diff created.\e[0m\n'
        printf '\e[38;2;206;34;30m~/.config/mpm/themerc.diff created.\e[0m\n'

    elif [[ -f $MPMRC && ! -f $THEMERC ]]; then

        diff -U 9999999 "$MPMRC" \
        ./mpmrc > "$MPMRC".diff

        cp ./themerc "$MPMRC_DIR"

        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc.diff created.\e[0m\n'
        printf '\e[38;2;206;34;30m~/.config/mpm/themerc created.\e[0m\n'
    else
        mkdir --parents "$MPMRC_DIR"
        cp ./{mpmrc,themerc} "$MPMRC_DIR"
        
        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc created, edit your settings there.\e[0m\n'
    fi

    chown -R 1000:1000 "$MPMRC_DIR"

}

_install() {
    cp -vf mpm /usr/local/bin
    mkdir -vp /usr/local/lib/mpm && \
    cp -vrf ./lib/* /usr/local/lib/mpm/
    mkdir --parents /usr/local/share/doc/mpm && \
    cp -vf ./{help,mpmrc,README.md,themerc} /usr/local/share/doc/mpm
    
    mkdir -vp /usr/share/licenses/mpm && \
    cp -vf ./LICENSE /usr/share/licenses/mpm/LICENSE

    chmod 755 /usr/local/lib/mpm/*
    chmod 755 /usr/local/bin/mpm

    _diffRc
    printf '%s\n' "for usage run: mpm --help"
}

_uninstall() {
    rm -vf /usr/local/bin/mpm
    rm -vrf /usr/local/lib/mpm
    rm -vrf /usr/share/licenses/mpm
    rm -vrf /usr/local/share/doc/mpm

    printf '%s\n' "hope you liked it anyway..."
}

date
printf '\n'
if [[ -x /usr/local/bin/mpm ]] && [[ -d /usr/local/lib/mpm ]]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: ' answer
    case "$answer" in
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
    esac
else
    _install
fi