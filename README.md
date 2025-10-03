# Salt Master Setup Guide

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![GitHub](https://img.shields.io/badge/GitHub-Repo-blue?logo=github)](https://github.com/mariosergiosl/salt-master)

Este repositório contém um guia prático e passo a passo para **instalar e configurar um Salt Master** usando SaltStack, focado em ambientes baseados em Ubuntu/Debian. É ideal para administradores de sistemas que querem automatizar infraestrutura de forma eficiente.

## 📋 O que é isso?
- **Propósito**: Documentação técnica para setup inicial de Salt Master, incluindo instalação, configuração de firewall (UFW), geração de chaves e dicas de troubleshooting.
- **Público-alvo**: DevOps, sysadmins e entusiastas de automação.
- **Versão**: Baseado em SaltStack 3006+ (ajuste conforme necessário).

## 🚀 Como Usar
1. **Leia o Guia Principal**: Comece pelo [SETUP.md](SETUP.md) para os passos detalhados.
2. **Pré-requisitos**:
   - Sistema: Ubuntu 20.04+ ou Debian 11+.
   - Acesso root ou sudo.
   - Conexão à internet para pacotes.
3. **Teste Rápido**:
   - Após seguir o setup, execute `salt-master -l info` para verificar se o serviço está rodando.
4. **Exemplo de Atribuição Obrigatória** (devido à licença):
   - Ao citar este guia em seu blog ou projeto: "Guia de setup de Salt Master por Mario Sergio (mariosergiosl), licenciado sob CC BY 4.0. Fonte: https://github.com/mariosergiosl/salt-master/SETUP.md".

## 📁 Estrutura do Repositório
- `SETUP.md`: Guia completo de instalação e configuração.
- `LICENSE.md`: Detalhes da licença (CC BY 4.0 — atribuição obrigatória para qualquer uso).
- `CONTRIBUTING.md`: Como contribuir.

## ⚖️ Licença
Este conteúdo está licenciado sob [Creative Commons Atribuição 4.0 Internacional (CC BY 4.0)](LICENSE.md).  
**Obrigatório**: Cite o autor (Mario Sergio, mariosergiosl) e o link do repositório em qualquer uso parcial, modificado ou completo. Exemplo:  
> Adaptado de "Salt Master Setup Guide" por Mario Sergio (https://github.com/mariosergiosl/salt-master), CC BY 4.0.

Não há restrições para uso comercial ou adaptações, desde que a atribuição seja mantida.

## 🤝 Contribuições
Veja [CONTRIBUTING.md](CONTRIBUTING.md) para como ajudar a melhorar este guia.

## 📞 Suporte
- Abra uma [issue](https://github.com/mariosergiosl/salt-master/issues) para dúvidas ou sugestões.
- Contato: Via GitHub ou email (adicione se quiser).

Feito por Mario Luz.  
Última atualização: 03 de outubro de 2025.
