# Projeto Docker

Este projeto utiliza Docker para simplificar o gerenciamento de containers e serviços do ambiente de desenvolvimento laravel utilizando `MYSQL`, `PHPMYADMIN` e `NGINX`. Este `README` fornece instruções sobre como usar os comandos disponíveis e os pré-requisitos necessários para executar o projeto.

## Pré-requisitos

Antes de começar, certifique-se de ter os seguintes pré-requisitos instalados em sua máquina:

- **Docker**:
1. Instalando repositório docker
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2. Por fim, instale todas os pacotes docker com:
```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- **Make**: Ferramenta para simplificar execução de multi-comandos, para obter em sua máquina:
```bash
sudo apt-get update
sudo apt-get install make
```

## Configuração Inicial

1. **Clone o repositório docker-laravel-environment**:

```bash
# via HTTPS
git clone https://github.com/raulntjj/docker_laravel_enviroment.git

# via SSH
git clone git@github.com:raulntjj/docker_laravel_enviroment.git
```

2. **Configure o .env.docker, está no diretório "/docker"**:
```bash
# Portas que serão utilizadas a sua máquina
NGINX_PORT=8989
MYADMIN_PORT=8888
DB_PORT=3307

# Configuracoes do banco
DB_NAME=sys
DB_PASS=root

# Para criar um projeto laravel utilize o valor "none"
REPOSITORY_SSH=none
# Caso possua um repositório, altere o valor para a URL SSH do seu repositório remoto.
REPOSITORY_SSH=git@github.com:raulntjj/docker_laravel_enviroment.git
```

3. **Configure sua chave SSH no projeto**:

- Caso não possua a chave:
```bash
# Abrindo diretorio SSH
cd ~/.ssh

# Criando a chave
# Lembre-se de utilizar o seu email
ssh-keygen -t rsa -b 4096 -C "seu_email@example.com"
```

- Opcão 1:
```bash
# Esta opcão irá copiar sua chave diretamente para o ambiente
# Lembre-se de alterar o caminho para o caminho que você escolheu para seu projeto.
cp ~/.ssh/id_rsa ~/Desktop/docker-laravel-environment/docker/id_rsa
```

- Opcão 2:
```bash
# Esta opcão irá abrir sua chave ssh no terminal e você irá copiar e colar no lugar correto manualmente
# Copie o conteúdo da sua chave
cat ~/.ssh/id_rsa

# Lembre-se de alterar o caminho para o caminho que você escolheu para seu projeto.
cd ~/Desktop/docker-laravel-environment/docker/id_rsa
nano id_rsa
# Cole o conteúdo aqui.
```

```bash
# Configuracoes do banco
DB_NAME=sys
DB_PASS=root

# Para criar um projeto laravel utilize o valor "none"
REPOSITORY_SSH=none
# Caso possua um repositório, altere o valor para a URL SSH do seu repositório remoto.
REPOSITORY_SSH=git@github.com:raulntjj/docker_laravel_enviroment.git
```

4. **Contrua os containers, para isso utilize:**:

```bash
sudo make build
```
Ao realizar estes passos, seu ambiente estará configurado e instalado, com phpMyAdmin na porta 8888, nginx na porta 8989, e com mysql na porta 3306. 

## Comandos Disponíveis

### Construir e Iniciar Containers

```bash
sudo make build
```
- Descrição: Executa o script build.sh, inicia os containers em segundo plano e executa o script entrypoint.sh.
- Uso: Ideal para a configuração inicial do ambiente e para construir e iniciar todos os serviços necessários.

### Parar e Remover Containers

```bash
sudo make kill
```
- Descrição: Para e remove os containers e executa uma limpeza do sistema Docker.
- Uso: Use para parar e remover todos os containers e limpar o sistema.

### Iniciar Containers

```bash
sudo make start
```
- Descrição: Inicia os containers em segundo plano.
- Uso: Use para iniciar os containers que estão parados.

### Parar Containers

```bash
sudo make stop
```
- Descrição: Para todos os containers.
- Uso: Use para parar todos os containers em execução.

### Reiniciar Containers

```bash
sudo make restart
```
- Descrição: Reinicia todos os containers.
- Uso: Use para reiniciar todos os containers em execução.

### Visualizar Logs

```bash
sudo make logs
```
- Descrição: Mostra os logs dos containers em tempo real.
- Uso: Use para monitorar a saída dos logs dos containers.

### Acessar o Shell do Container 'app'

```bash
sudo make shell
```
- Descrição: Acessa o shell interativo do container app.
- Uso: Use para realizar manutenção ou diagnósticos diretamente no container app.

### Acessar o Shell do Container 'queue'

```bash
sudo make queue-shell
```
- Descrição: Acessa o shell interativo do container queue.
- Uso: Use para realizar manutenção ou diagnósticos diretamente no container queue.

### Rodar Testes

```bash
sudo make test
```
- Descrição: Executa os testes definidos no projeto Laravel.
- Uso: Use para rodar os testes automatizados da aplicação.

### Executar Migrações

```bash
sudo make migrate
```
- Descrição: Executa as migrações do banco de dados.
- Uso: Use para aplicar alterações na estrutura do banco de dados.

### Instalar Dependências

```bash
sudo make install
```
- Descrição: Instala as dependências do Composer e gera a chave da aplicação.
- Uso: Use para instalar todas as dependências e configurar a chave da aplicação.

### Atualizar Dependências

```bash
sudo make update
```
- Descrição: Atualiza as dependências do Composer.
- Uso: Use para atualizar as dependências para suas versões mais recentes.

### Limpar Volumes e Imagens Órfãs

```bash
sudo make clean
```
- Descrição: Remove volumes e imagens Docker órfãs que não estão mais em uso.
- Uso: Use para liberar espaço no disco removendo dados não utilizados.

### Derrubar Containers

```bash
sudo make down
```
- Descrição: Derruba todos os containers e redes associadas.
- Uso: Use para parar e remover os containers, mas mantendo volumes e redes persistentes.

### Subir Containers em Background

```bash
sudo make up
```
- Descrição: Inicia todos os containers em segundo plano.
- Uso: Use para subir os containers em modo detach.

### Resetar Ambiente

```bash
sudo make reset
```
- Descrição: Derruba e remove volumes e redes associadas, além de realizar uma limpeza completa.
- Uso: Use para uma limpeza completa e reinicialização do ambiente.

### Contribuição

Se você deseja contribuir para este projeto, por favor, siga estas diretrizes:

    Faça um fork do repositório.
    Crie uma nova branch para sua feature ou correção.
    Faça suas alterações e teste-as.
    Envie um pull request com uma descrição clara das mudanças.