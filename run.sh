#!/bin/bash

# Define a senha do root para acesso SSH.
echo "root:root" | chpasswd

# Geração de chaves SSH
ssh-keygen -A

# Inicia o serviço SSH
/usr/sbin/sshd

# 1. Inicia o Salt Master em background
/usr/bin/salt-master -l info &

# 2. Inicia o Salt API em background
/usr/bin/salt-api -l info &

# O comando 'wait' é NECESSÁRIO para manter o contêiner rodando, esperando pelos processos em background.
wait -n
