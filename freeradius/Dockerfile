FROM debian:stretch-slim

MAINTAINER Dirk Winkel <it@polarwinkel.de>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION "1"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends freeradius freeradius-ldap freeradius-utils nano

COPY clients.conf /root/clients.conf
COPY users /root/users
COPY ldap /root/ldap
COPY default /root/default
RUN cat /root/clients.conf >> /etc/freeradius/3.0/clients.conf

COPY entrypoint.sh /

CMD "./entrypoint.sh"
