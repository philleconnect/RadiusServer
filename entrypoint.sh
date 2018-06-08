#!/bin/bash

# check if environment variables are set with -e option:
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
if [[ -z "$SLAPD_ORGANIZATION" ]]; then
    echo -n"SLAPD_ORGANIZATION not set."
    echo -n"I am using 'My School'"
    SLAPD_ORGANIZATION='My School'
fi

# set the environment variables for slapd:
sed -i "s|SLAPD_PASSWORD|$SLAPD_PASSWORD|g" /root/ldap
sed -i "s|SLAPD_DOMAIN0|$SLAPD_DOMAIN0|g" /root/ldap
sed -i "s|SLAPD_DOMAIN1|$SLAPD_DOMAIN1|g" /root/ldap

cp /root/ldap /etc/freeradius/3.0/mods-enabled/ldap

service freeradius start

while true; do sleep 1; done # keep container running for debugging...
