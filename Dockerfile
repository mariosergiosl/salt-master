FROM opensuse/leap:15.6

# Variável de ambiente para o Shell
ENV SHELL /bin/bash

# 1. Criação Explícita de Usuário/Grupo (UID/GID 1000)
RUN groupadd -r -g 1000 salt && \
    useradd -r -u 1000 -g salt -m -s /bin/bash salt && \
    chsh -s /bin/bash root

# 2. Instalação de Pacotes, Chaves e Ajuste de Permissões
RUN zypper refresh && \
    zypper install -y salt-master salt-api openssh vim curl python3-pip && \
    # CORREÇÃO CRÍTICA: Instala as dependências Python que faltavam no openSUSE para a API
    pip3 install cherrypy rpm-vercmp && \
    # CRÍTICO: Permite login root por senha para o SSH
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # Cria os diretórios necessários
    mkdir -p /srv/salt /srv/pillar /etc/salt/master.d /etc/salt/pki/master /var/cache/salt/master /var/log/salt /var/run/salt /var/run/sshd /etc/pki/tls/certs && \
    # Geração de chaves SSH e SSL
    ssh-keygen -A && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/certs/localhost.key -out /etc/pki/tls/certs/localhost.crt -subj "/CN=salt-master" && \
    # Ajusta as permissões de chave SSL e diretórios
    chown salt:salt /etc/pki/tls/certs/localhost.key /etc/pki/tls/certs/localhost.crt && \
    chown -R salt:salt /srv/salt /srv/pillar /etc/salt /var/cache/salt /var/log/salt /var/run/salt && \
    zypper clean -a

# 3. Copia a configuração da API e o script de inicialização
COPY master_api.conf /etc/salt/master.d/master_api.conf
COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 4505
EXPOSE 4506
EXPOSE 8000
EXPOSE 22

USER root
ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD [""]
