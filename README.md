# Guia de Configuração de Salt Master com Podman no openSUSE Leap

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![GitHub](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/mariosergiosl/salt-master)
[![SaltStack Version](https://img.shields.io/badge/SaltStack-3007-brightgreen)](https://docs.saltproject.io/en/3007/)
[![Platform](https://img.shields.io/badge/Platform-openSUSE%20Leap%2015.6-blue)](https://www.opensuse.org/)
[![Podman](https://img.shields.io/badge/Container-Podman-red?logo=podman)](https://podman.io/)
[![Contributions Welcome](https://img.shields.io/badge/Contributions-Welcome-brightgreen)](https://github.com/mariosergiosl/salt-master/blob/main/CONTRIBUTING.md)

Este repositório contém um guia detalhado para configurar um **Salt Master (versão 3007)** com **Podman** no **openSUSE Leap 15.6**, incluindo suporte a **SSH** e **Salt API**. O guia é voltado para administradores de sistemas que desejam implementar automação de infraestrutura com SaltStack em ambientes containerizados.

## 📋 Sobre o Projeto
- **Propósito**: Fornecer um passo a passo completo para configurar um Salt Master em um contêiner Podman, com acesso via SSH (porta 10022) e Salt API (porta 8000), usando openSUSE Leap 15.6 para estabilidade.
- **Público-alvo**: DevOps, administradores de sistemas e entusiastas de automação.
- **Versão**: SaltStack 3007, openSUSE Leap 15.6, Podman.

## 🚀 Como Usar
1. **Leia o Guia Principal**: Acesse [SETUP.md](SETUP.md) para instruções detalhadas sobre instalação, configuração e execução.
2. **Pré-requisitos**:
   - Sistema: openSUSE Leap 15.6.
   - Podman instalado.
   - Acesso root ou sudo.
   - Diretórios de persistência: `/opt/salt-master_data/{keys,cache,files,pillar}`.
3. **Teste Rápido**:
   - Após configurar, conecte-se via SSH: `ssh root@localhost -p 10022` (senha: `root`).
   - Verifique a Salt API: `curl http://localhost:8000`.
   - Execute um estado: `salt '*' state.apply nginx`.
4. **Exemplo de Atribuição Obrigatória**:
   - Ao usar este guia em um blog ou projeto:  
     > Guia de configuração de Salt Master com Podman por Mario Sergio (mariosergiosl), licenciado sob CC BY 4.0. Fonte: https://github.com/mariosergiosl/salt-master/SETUP.md

## 📁 Estrutura do Repositório
- `SETUP.md`: Guia completo de configuração.
- `master_api.conf`: Configuração da Salt API (porta 8000, autenticação auto).
- `run.sh`: Script de inicialização do contêiner (SSH e Salt services).
- `Dockerfile`: Imagem baseada em openSUSE Leap 15.6 para Salt Master.
- `LICENSE.md`: Licença CC BY 4.0 (atribuição obrigatória).
- `CONTRIBUTING.md`: Como contribuir.
- `.gitignore`: Exclui arquivos desnecessários.

## ⚖️ Licença
Este conteúdo está licenciado sob [Creative Commons Atribuição 4.0 Internacional (CC BY 4.0)](LICENSE.md).  
**Obrigatório**: Cite o autor (Mario Luz, mariosergiosl) e o link do repositório em qualquer uso parcial, modificado ou completo. Exemplo:  
> Adaptado de "Guia de Configuração de Salt Master com Podman" por Mario Luz (https://github.com/mariosergiosl/salt-master), CC BY 4.0.

## 🤝 Contribuições
Interessado em melhorar este guia? Veja [CONTRIBUTING.md](CONTRIBUTING.md) para detalhes.

## 📞 Suporte
- Abra uma [issue](https://github.com/mariosergiosl/salt-master/issues) para dúvidas ou sugestões.
- Contato: Via GitHub.

Feito por Mario Luz.  
Última atualização: 03 de outubro de 2025.
