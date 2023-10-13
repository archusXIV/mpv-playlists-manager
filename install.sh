#!/bin/bash
# This script will install/upgrade/remove mpm (mpv-playlists-manager).
# version 1.3-4

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
if [ -x /usr/local/bin/mpm ] && [ -d /usr/local/lib/mpm ]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: ' answer
    case "$answer" in
        r|R)
            _uninstall
        ;;
        u|U)
            if [ "$(find ./lib -type f | wc -l)" = \
                "$(find /usr/local/lib/mpm -type f | wc -l)" ]; then
                _uninstall
                _install
            elif [ "$(find ./lib -type f | wc -l)" != \
                "$(find /usr/local/lib/mpm -type f | wc -l)" ]; then
                _uninstall
                _install
            fi
        ;;
    esac
else
    _install
fi
