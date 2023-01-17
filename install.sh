#!/bin/sh

read -rn1 -p ' [I]nstall or [U]ninstall: '
echo ""
case "$REPLY" in
    i|I)    cp -f mpm /usr/local/bin/mpm
    
            mkdir -p /usr/local/lib/mpm && \
            cp -r -f ./lib/* /usr/local/lib/mpm
            
            mkdir -p /usr/share/licenses/mpm && \
            cp -f ./LICENSE /usr/share/licenses/mpm/LICENSE
            
            chmod 755 /usr/local/lib/mpm/*
            chmod 755 /usr/local/bin/mpm
            
            printf '%s\n' "for usage run: mpm --help"
    ;;
    u|U)    rm -f /usr/local/bin/mpm
            rm -rf /usr/local/lib/mpm
            rm -rf /usr/share/licenses/mpm
            
            printf '%s\n' "hope you liked it anyway..."
    ;;
esac
