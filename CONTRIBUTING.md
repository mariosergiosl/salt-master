# Guia de Contribuições

Obrigado por considerar contribuir para o **Guia de Configuração de Salt Master com Podman**! Este projeto é uma documentação técnica para automação com SaltStack, e sua ajuda é valiosa para mantê-lo útil e atualizado.

## 🤝 Como Contribuir
1. **Fork o Repositório**: Clique em "Fork" no GitHub para criar uma cópia no seu perfil.
2. **Crie uma Branch**: Use um nome descritivo, ex.: `git checkout -b add-podman-troubleshooting`.
3. **Faça Mudanças**: Edite arquivos como `SETUP.md`, `master_api.conf`, ou adicione novos exemplos.
4. **Commit e Push**:
   - Use mensagens claras: "Adiciona seção de troubleshooting para Salt API".
   - Push para sua fork: `git push origin add-podman-troubleshooting`.
5. **Abra um Pull Request (PR)**:
   - Descreva o propósito da mudança e como ela melhora o guia.
   - Referencie issues, se aplicável (ex.: "Closes #5").
   - Inclua testes (ex.: verificação do comando `salt '*' test.ping`).

## 📝 Boas Práticas
- **Idioma**: Mantenha em português, seguindo o tom técnico do `SETUP.md`.
- **Formato**: Use Markdown para documentação e respeite a formatação YAML em arquivos como `master_api.conf`.
- **Teste**: Valide suas alterações em um ambiente openSUSE Leap 15.6 com Podman e Salt 3007.
- **Escopo**: Foque em melhorias para Salt Master, Podman, SSH ou Salt API, conforme o guia.

## ⚖️ Licença e Atribuição
- Todas as contribuições são licenciadas sob [CC BY 4.0](LICENSE.md).
- **Atribuição Obrigatória**: Ao contribuir, você concorda que seu conteúdo pode ser usado sob CC BY 4.0, mas mantém seus direitos de autor. Sempre cite fontes externas, se usadas.
- Não inclua conteúdo de terceiros sem verificar compatibilidade com CC BY 4.0.

## 🚫 O Que Evitar
- Commits sem mensagens descritivas.
- Mudanças que quebrem a funcionalidade (ex.: alterar portas sem justificativa).
- Conteúdo fora do escopo (ex.: guias para outras ferramentas não mencionadas).

## ❓ Dúvidas?
Abra uma [issue](https://github.com/mariosergiosl/salt-master/issues) ou comente no PR. Vamos trabalhar juntos para manter este guia útil!

Obrigado pela colaboração! 🌟
