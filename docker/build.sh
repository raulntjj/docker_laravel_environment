#!/bin/bash

log_info() {
    echo
    echo -e "\e[1;36m$1\e[0m"
    echo
}

log_success() {
    echo
    echo -e "\e[1;32m$1\e[0m"
    echo
}

export $(grep -v '^#' ./docker/.env.docker | xargs)

# Verificando se a porta DB_está ocupada
if lsof -Pi :$DB_PORT -sTCP:LISTEN -t >/dev/null ; then
 log_info "Port $DB_PORT is in use, stop the process occupying it or change the port."
  exit 1
fi
log_success "Port $DB_PORT ready for MYSQL connection"

# Verificando se a porta MYADMIN_está ocupada
if lsof -Pi :$MYADMIN_PORT -sTCP:LISTEN -t >/dev/null ; then
 log_info "Port $MYADMIN_PORT is in use, stop the process occupying it or change the port."
  exit 1
fi
log_success "Port $MYADMIN_PORT ready for PHPMYADMIN connection"

# Verificando se a porta NGINX_está ocupada
if lsof -Pi :$NGINX_PORT -sTCP:LISTEN -t >/dev/null ; then
 log_info "Port $NGINX_PORT is in use, stop the process occupying it or change the port."
  exit 1
fi
log_success "Port $NGINX_PORT ready for NGINX connection"
