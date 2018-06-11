FROM debian:stretch-slim

MAINTAINER Dirk Winkel <it@polarwinkel.de>

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION "1"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends freeradius freeradius-ldap freeradius-utils nano

COPY clients.conf /root/clients.conf
COPY users /root/users
COPY ldap /root/ldap

COPY entrypoint.sh /

CMD "./entrypoint.sh"
