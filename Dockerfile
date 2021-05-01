# basic container
FROM alpine:3.12

# labels
LABEL maintainer "Daniel Muehlbachler-Pietrzykowski daniel.muehlbachler@niftyside.com"
LABEL name "PowerDNS Recursor"

# config
ENV POWERDNS_VERSION "4.4.2-r1"

# install pdns
RUN apk update \
  && apk add --no-cache \
    wget  \
    git \
    make \
    bash \
    pdns-recursor=$POWERDNS_VERSION \
    pdns-recursor-doc=$POWERDNS_VERSION \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /etc/pdns/conf.d

# assets
ADD assets/recursor.conf /etc/powerdns/
ADD assets/forward_zones.conf /etc/powerdns/
ADD assets/entrypoint.sh /bin/powerdns

# expose and entrypoint
EXPOSE 53/tcp 53/udp
ENTRYPOINT ["powerdns"]
