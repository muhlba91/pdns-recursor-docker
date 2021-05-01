#!/bin/bash
set -e

[[ -z "$TRACE" ]] || set -x

# --help, --version
[ "$1" = "--help" ] || [ "$1" = "--version" ] && exec pdns_recursor $1

# treat everything except -- as exec cmd
[ "${1:0:2}" != "--" ] && exec "$@"

# convert all environment variables prefixed with PDNS_CONF_ into pdns config directives
PDNS_LOAD_MODULES="$(echo $PDNS_LOAD_MODULES | sed 's/^,//')"
printenv | grep ^PDNS_CONF_ | cut -f3- -d_ | while read var; do
  val="${var#*=}"
  var="${var%%=*}"
  var="$(echo $var | sed -e 's/_/-/g' | tr '[:upper:]' '[:lower:]')"
  [[ -z "$TRACE" ]] || echo "$var=$val"
  (grep -qE "^[# ]*$var=.*" /etc/powerdns/recursor.conf && sed -r -i "s#^[# ]*$var=.*#$var=$val#g" /etc/powerdns/recursor.conf) || echo "$var=$val" >> /etc/powerdns/recursor.conf
done

# environment hygiene
for var in $(printenv | cut -f1 -d= | grep -v -e HOME -e USER -e PATH ); do unset $var; done
export TZ=UTC LANG=C LC_ALL=C

# prepare graceful shutdown
trap "rec_control quit" SIGHUP SIGINT SIGTERM

# run the server
pdns_recursor "$@" &

wait
