#!/bin/sh

read -rp ' [I]nstall or [U]ninstall: ' respons
case "$respons" in
    i|I)    cp -f mpm /usr/local/bin/mpm
            mkdir -p /usr/local/lib/mpm
            cp -r -f ./lib/* /usr/local/lib/mpm
            
            chmod 755 /usr/local/lib/mpm/*
            chmod 755 /usr/local/bin/mpm
            
            printf '%s\n' "for usage run: mpm --help"
    ;;
    u|U)    rm -rf /usr/local/bin/mpm
            rm -rf /usr/local/lib/mpm
            
            printf '%s\n' "hope you liked it anyway..."
    ;;
esac
