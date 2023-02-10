#!/bin/sh

bin="/usr/local/bin"
lib="/usr/local/lib/mpm"

read -rn1 -p ' [I]nstall or [U]ninstall: '
echo ""
case "$REPLY" in
    i*|I*)
        cp -vf mpm "$bin"
    
        mkdir -vp "$lib" && \
        cp -vrf ./lib/* "$lib"
            
        mkdir -vp /usr/share/licenses/mpm && \
        cp -vf ./LICENSE /usr/share/licenses/mpm/LICENSE
            
        chmod 755 "$lib"/*
        chmod 755 "$bin"/mpm
            
        printf '%s\n' "for usage run: mpm --help"
    ;;
    u*|U*)
        rm -vf "$bin"/mpm
        rm -vrf "$lib"
        rm -vrf /usr/share/licenses/mpm
            
        printf '%s\n' "hope you liked it anyway..."
    ;;
esac
