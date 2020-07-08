#!/usr/bin/env bash

set -e

readonly DOCKER_PATH=$(dirname $(realpath $0))
cd ${DOCKER_PATH};

. ./lib/functions.sh

block_info "Welcome to Docker ELK installer!"

check_requirements
parse_env ".env.dist" ".env"
. ./.env
echo -e "${GREEN}Configuration done!${RESET}" > /dev/tty

block_info "Build & start Docker"
make build
make start
echo -e "${GREEN}Docker is started with success!${RESET}" > /dev/tty

block_success "Kibana is started https://${KIBANA_DOMAIN}:${KIBANA_PORT}"
