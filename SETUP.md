# Configuração de Salt Master (v3007) com Podman no openSUSE Leap 15.6

Este guia detalha a implementação de um **Salt Master (versão 3007)** com **Podman** no **openSUSE Leap 15.6**, incluindo suporte a **SSH** e **Salt API**. A configuração segue as melhores práticas do SaltStack, com diretórios persistentes e autenticação otimizada.

## 1. Configuração Inicial e Estrutura de Arquivos
O projeto requer um diretório base para construir a imagem e diretórios de persistência no host.

### Comandos de Preparação do Host
1. **Crie o diretório do projeto**:
   ```bash
   mkdir salt-master-final
   cd salt-master-final
   ```

2. **Crie os diretórios de persistência**:
   ```bash
   mkdir -p /opt/salt-master_data/{keys,cache,files,pillar}
   ```

3. **Crie os arquivos necessários**:
   ```bash
   touch Dockerfile master_api.conf run.sh
   ```

### 1.1. Arquivo: `master_api.conf`
Configura a Salt API na porta 8000 com autenticação `auto` (chaves mestras), ideal para contêineres:
```yaml
rest_cherrypy:
  port: 8000
  host: 0.0.0.0
  ssl_crt: /etc/pki/tls/certs/localhost.crt
  ssl_key: /etc/pki/tls/certs/localhost.key
external_auth:
  auto:
    root:
      - .*
      - '@runner'
      - '@wheel'
```

### 1.2. Arquivo: `run.sh`
Script de inicialização (ENTRYPOINT) do contêiner, gerenciando SSH e Salt services:
```bash
#!/bin/bash

# Define a senha do root para SSH
echo "root:root" | chpasswd

# Gera chaves SSH
ssh-keygen -A

# Inicia o SSH
/usr/sbin/sshd

# Inicia o Salt Master e API em background
/usr/bin/salt-master -l info &
/usr/bin/salt-api -l info &

# Mantém o contêiner ativo
wait -n
```

### 1.3. Arquivo: `Dockerfile`
Imagem baseada em openSUSE Leap 15.6, com correções de dependências e permissões:
```dockerfile
FROM opensuse/leap:15.6

ENV SHELL /bin/bash

# Cria usuário/grupo (UID/GID 1000)
RUN groupadd -r -g 1000 salt && \
    useradd -r -u 1000 -g salt -m -s /bin/bash salt && \
    chsh -s /bin/bash root

# Instala pacotes e ajusta permissões
RUN zypper refresh && \
    zypper install -y salt-master salt-api openssh vim curl python3-pip && \
    pip3 install cherrypy rpm-vercmp && \
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    mkdir -p /srv/salt /srv/pillar /etc/salt/master.d /etc/salt/pki/master /var/cache/salt/master /var/log/salt /var/run/salt /var/run/sshd /etc/pki/tls/certs && \
    ssh-keygen -A && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/certs/localhost.key -out /etc/pki/tls/certs/localhost.crt -subj "/CN=salt-master" && \
    chown salt:salt /etc/pki/tls/certs/localhost.key /etc/pki/tls/certs/localhost.crt && \
    chown -R salt:salt /srv/salt /srv/pillar /etc/salt /var/cache/salt /var/log/salt /var/run/salt && \
    zypper clean -a

# Copia arquivos de configuração
COPY master_api.conf /etc/salt/master.d/master_api.conf
COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

# Portas: Salt (4505/4506), API (8000), SSH (22)
EXPOSE 4505 4506 8000 22

USER root
ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD [""]
```

## 2. Execução no Host
Comandos para construir e executar o contêiner.

### 2.1. Ajuste de Permissões
Garante que os diretórios de persistência sejam acessíveis ao UID 1000:
```bash
sudo chown -R 1000:1000 /opt/salt-master_data
```

### 2.2. Construção da Imagem
```bash
podman build -t salt-master-suse:3007.0 .
```

### 2.3. Execução do Contêiner
Mapeia portas e volumes, com reinício automático:
```bash
podman run -d \
  --name salt-master \
  -p 10022:22/tcp \
  -p 4505:4505/tcp \
  -p 4506:4506/tcp \
  -p 8000:8000/tcp \
  -v /opt/salt-master_data/keys:/etc/salt/pki/master:Z \
  -v /opt/salt-master_data/cache:/var/cache/salt/master:Z \
  -v /opt/salt-master_data/files:/srv/salt:Z \
  -v /opt/salt-master_data/pillar:/srv/pillar:Z \
  --restart=always \
  salt-master-suse:3007.0
```

## 3. Estrutura de Automação (Salt Formulas)
A automação usa **States** e **Formulas** armazenados em `/opt/salt-master_data/files`.

### Estrutura de Diretórios
| Diretório no Host | Conteúdo | Propósito |
|-------------------|----------|-----------|
| `/opt/salt-master_data/files` | Arquivos `.sls` e `top.sls` | State Files (definições de configuração) |
| `/opt/salt-master_data/pillar` | Arquivos `.sls` de Pillar | Dados sensíveis ou específicos do Minion |

### Exemplo de Formula: NGINX
Estrutura para gerenciar o NGINX via Salt:
- **Formula Directory**: `/opt/salt-master_data/files/nginx/`
- **State File**: `/opt/salt-master_data/files/nginx/init.sls`

**Conteúdo de `init.sls`**:
```yaml
nginx_package:
  pkg.installed:
    - name: nginx

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx_package
```

### Comando de Execução
Conecte-se ao contêiner via SSH e aplique o estado:
```bash
ssh root@localhost -p 10022
salt '*' state.apply nginx
```

## 4. Troubleshooting
- **SSH falha**: Verifique se a porta 10022 está aberta e se a senha `root` funciona.
- **Salt API não responde**: Teste com `curl http://localhost:8000`. Confirme que o `cherrypy` está instalado.
- **Permissões**: Certifique-se de que `/opt/salt-master_data` pertence ao UID 1000.

---

**Licença**: Este guia está sob [CC BY 4.0](LICENSE.md). Cite Mario Luz (mariosergiosl) e o repositório em qualquer uso.  
Última atualização: 03 de outubro de 2025.
