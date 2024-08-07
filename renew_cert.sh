#!/bin/sh
# workdir = this script's dir
cd "$(dirname "$0")"
docker compose run --rm certbot renew
