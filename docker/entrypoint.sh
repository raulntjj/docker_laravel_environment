#!/bin/bash

# Reinicia a execução quando algum erro acontece
echo "Running entrypoint"
# set -e

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

log_error() {
    echo
    echo -e "\e[1;33m$1\e[0m"
    echo
}

if [ -f /var/www/docker/.env.docker ]; then
    source /var/www/docker/.env.docker
    log_success "Environment variables loaded from .env.docker."
else
    log_error ".env.docker file not found. Exiting..."
    exit 1
fi

# Setando permissao para GIT no diretorio
log_info "Running command for git configs..."
git config --global --add safe.directory /var/www
git config --global --add safe.directory /var/www/repository
log_success "Git configured."

log_info "Cloning repository..."
git clone $REPOSITORY_SSH /var/www/repository
log_success "Repository cloned."

# Instalando depedências
log_info "Running composer install/update..."
cd /var/www/repository
composer update || composer install
log_success "Dependencies installed"

# Gera a chave da aplicação Laravel
log_info "Generating application key..."
if [ ! -f .env ]; then
    cp .env.example .env
fi
php artisan key:generate --force
log_success "Key generated."

# Aguardando MYSQL iniciar
log_info "Waiting for MYSQL to start..."
sleep 30
log_success "MYSQL started."

# rodando migrations
log_info "Running migrations..."
# Alterando a .env para as configuracoes do banco do container
sed -i "/^DB_CONNECTION=/c\DB_CONNECTION=mysql" .env
sed -i "/^DB_HOST=/c\DB_HOST=db" .env
sed -i "/^DB_PORT=/c\DB_PORT=3306" .env
sed -i "/^DB_DATABASE=/c\DB_DATABASE=${DB_NAME}" .env
sed -i "/^DB_USERNAME=/c\DB_USERNAME=root" .env
sed -i "/^DB_PASSWORD=/c\DB_PASSWORD=${DB_PASS}" .env
php artisan migrate --force

# Seta permissões para alterações no projeto
log_info "Setting permissions..."
chmod -R 777 .
log_success "Permissions granted."

log_success "Entrypoint finished."
git ls-files -z | xargs -0 git update-index --assume-unchanged


# Executa qualquer comando que tenha sido fornecido via docker-compose ou linha de comando
exec "$@"
