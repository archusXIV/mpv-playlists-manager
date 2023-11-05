#!/bin/bash
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# version 1.3-7

_diffMpmrc() {
    read -r -p ' Please enter your username: ' user
    local MPMRC="/home/$user/.config/mpm/mpmrc"
    if [[ -f $MPMRC ]]; then
        diff -U 9999999 ./mpmrc \
        "$MPMRC" > "$MPMRC".diff
        chown 1000:1000 "$MPMRC".diff
        printf '\e[38;2;206;34;30m~/.config/mpm/mpmrc.diff created, PLEASE UPDATE YOUR MPMRC FILE.\e[0m\n'
    else
        mkdir -p /home/"$user"/.config/mpm
        cp -f ./mpmrc "$MPMRC"
        chown -R 1000:1000 /home/"$user"/.config/mpm
    fi
}

_install() {
    cp -vf mpm /usr/local/bin
    mkdir -vp /usr/local/lib/mpm && \
    cp -vrf ./lib/* /usr/local/lib/mpm/
    mkdir -p /usr/local/share/doc/mpm && \
    cp -vf {help,mpmrc,README.md} /usr/local/share/doc/mpm
    
    mkdir -vp /usr/share/licenses/mpm && \
    cp -vf ./LICENSE /usr/share/licenses/mpm/LICENSE

    chmod 755 /usr/local/lib/mpm/*
    chmod 755 /usr/local/bin/mpm

    _diffMpmrc
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