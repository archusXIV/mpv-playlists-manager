#!/bin/bash

bin="/usr/local/bin"
lib="/usr/local/lib/mpm"

_install() {
    cp -vf mpm "$bin"
    mkdir -vp "$lib" && \
    cp -vrf ./lib/* "$lib"
            
    mkdir -vp /usr/share/licenses/mpm && \
    cp -vf ./LICENSE /usr/share/licenses/mpm/LICENSE
            
    chmod 755 "$lib"/*
    chmod 755 "$bin"/mpm
            
    printf '%s\n' "for usage run: mpm --help"
    printf '%s\n' "install.log created."
}

_uninstall() {
    rm -vf "$bin"/mpm
    rm -vrf "$lib"
    rm -vrf /usr/share/licenses/mpm
            
    printf '%s\n' "hope you liked it anyway..."
    printf '%s\n' "install.log created."
}

{
date
printf '%s\n'
if [ -x "$bin"/mpm ] && [ -d "$lib" ]; then
    read -rn 1 -p ' [R]emove or [U]pgrade mpm?: ' answer
    case "$answer" in
        r|R)
            _uninstall
        ;;
        u|U)
            if [ "$(find ./lib -type f | wc -l)" = \
                "$(find "$lib" -type f | wc -l)" ]; then
                _uninstall
                _install
            elif [ "$(find ./lib -type f | wc -l)" != \
                "$(find "$lib" -type f | wc -l)" ]; then
                _uninstall
                _install
            fi
        ;;
    esac
else
    _install
fi
} > install.log
