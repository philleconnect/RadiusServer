#!/bin/bash

# check if environment variables are set with -e option:
if [[ -z "$RADIUS_LISTEN_IP_RANGE" ]]; then
    echo -n >&2 "Error: Container not configured and RADIUS_LISTEN_IP_RANGE not set. "
    echo >&2 "Did you forget to add -e RADIUS_LISTEN_IP_RANGE=... ?"
    exit 1
fi
if [[ -z "$RADIUS_PASSWORD" ]]; then
    echo -n >&2 "Error: Container not configured and RADIUS_PASSWORD not set. "
    echo >&2 "Did you forget to add -e RADIUS_PASSWORD=... ?"
    exit 1
fi
if [[ -z "$SLAPD_PASSWORD" ]]; then
    echo -n >&2 "Error: Container not configured and SLAPD_PASSWORD not set. "
    echo >&2 "Did you forget to add -e SLAPD_PASSWORD=... ?"
    exit 1
fi
if [[ -z "$SLAPD_DOMAIN0" ]]; then
        echo -n"SLAPD_DOMAIN0 not set."
        echo -n"I am using 'local'"
        SLAPD_DOMAIN0='local'
fi
if [[ -z "$SLAPD_DOMAIN1" ]]; then
    echo -n"SLAPD_DOMAIN1 not set."
    echo -n"I am using 'ldap'"
    SLAPD_DOMAIN1='ldap'
fi

# set the environment variables for slapd:
sed -i "s|SLAPD_PASSWORD|$SLAPD_PASSWORD|g" /root/ldap
sed -i "s|SLAPD_DOMAIN0|$SLAPD_DOMAIN0|g" /root/ldap
sed -i "s|SLAPD_DOMAIN1|$SLAPD_DOMAIN1|g" /root/ldap
cp -r /root/ldap /etc/freeradius/3.0/mods-enabled/ldap

sed -i "s|RADIUS_LISTEN_IP_RANGE|$RADIUS_LISTEN_IP_RANGE|g" /etc/freeradius/3.0/clients.conf
sed -i "s|RADIUS_PASSWORD|$RADIUS_PASSWORD|g" /etc/freeradius/3.0/clients.conf

if ( $RADIUS_REQUIRE_TEACHER ); then
    #if [ -f /root/users.bak ]; then
    #    cp /root/users.bak /etc/freeradius/3.0/users
    #else
    #    cp /etc/freeradius/3.0/users /root/users.bak
    #fi
    #cat /root/users >> /etc/freeradius/3.0/users
    if [ ! -f /root/default.bak ]; then
        cp /etc/freeradius/3.0/sites-enabled/default /root/default.bak
    fi
    cp /root/default /etc/freeradius/3.0/sites-enabled/default
    echo "I configured radius to authenticate only teachers"
else
    #if [ -f /root/users.bak ]; then
    #    cp /root/users.bak /etc/freeradius/3.0/users
    #fi
    if [ -f /root/default.bak ]; then
        cp /root/default.bak /etc/freeradius/3.0/sites-enabled/default
    fi
    echo "I configured radius to authenticate any user"
fi


freeradius -f
#service freeradius start
#while true; do sleep 1; done # keep container running for debugging...
