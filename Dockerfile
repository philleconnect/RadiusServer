FROM debian:stretch-slim

MAINTAINER Dirk Winkel <it@polarwinkel.de>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION "1"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends freeradius freeradius-ldap freeradius-utils nano

COPY clients.conf /etc/freeradius/3.0/clients.conf.2
RUN cat /etc/freeradius/3.0/clients.conf.2 >> /etc/freeradius/3.0/clients.conf
COPY users /etc/freeradius/3.0/users.2
RUN cat /etc/freeradius/3.0/users.2 >> /etc/freeradius/3.0/users
COPY ldapmod.conf /root/ldap
COPY entrypoint.sh /

CMD "./entrypoint.sh"
