# PowerDNS Recursor Docker Container

[![](https://img.shields.io/github/workflow/status/muhlba91/pdns-recursor-docker/Release?style=for-the-badge)](https://github.com/muhlba91/pdns-recursor-docker/actions)
[![](https://img.shields.io/github/release-date/muhlba91/pdns-recursor-docker?style=for-the-badge)](https://github.com/muhlba91/pdns-recursor-docker/releases)
[![](https://img.shields.io/docker/v/muhlba91/pdns-recursor?style=for-the-badge)](https://hub.docker.com/r/muhlba91/pdns-recursor)

## Usage

```shell
# start the powerdns container
$ docker run --name pdns \
  -p 53:53 \
  -p 53:53/udp \
  muhlba1/pdns-recursor
```

## Configuration

**Environment Configuration:**

* Want to apply 12Factor-Pattern? Apply environment variables of the form `PDNS_CONF_$pdns-config-variable=$config-value`, like `PDNS_CONF_WEBSERVER=yes`
* Want to use own config files? Simply overwrite `/etc/powerdns/recursor.conf`

**PowerDNS Configuration:**

Append the PowerDNS setting to the command.
See `docker run --rm muhlba91/pdns-recursor --help`

## Contributions

Submit an issue describing the problem(s)/question(s) and proposed fixes/work-arounds.

To contribute, just fork the repository, develop and test your code changes and submit a pull request.
