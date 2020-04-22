FROM debian:bullseye
# replace ^ with below for raspberry pi
#FROM resin/rpi-raspbian:jessie

LABEL maintainer="brannon@brannondorsey.com"
LABEL license="MIT"

RUN apt-get update --fix-missing && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" install --yes --force-yes  \
    hostapd \
    dbus \
    net-tools \
    iptables \
    dnsmasq \
    net-tools \
    macchanger \
    python3 \
    python3-pip
 
# mitmproxy requires this env
ENV LANG en_US.UTF-8 

RUN pip3 install mitmproxy
ADD hostapd.conf /etc/hostapd/hostapd.conf
ADD hostapd /etc/default/hostapd
ADD dnsmasq.conf /etc/dnsmasq.conf

ADD entrypoint.sh /root/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/root/entrypoint.sh"]
