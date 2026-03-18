# Instalação no Claude Code

## Instalação automática

```bash
git clone https://github.com/Lucasdoreac/mauidevtools
cd mauidevtools
bash install-to-claude.sh
```

Reinicie o Claude Code.

## Instalação manual

1. Abra `~/.claude/settings.json`
2. Adicione o conteúdo de `configs/claude-code.json` dentro do bloco `"mcpServers"`
3. Reinicie o Claude Code

## Verificar se funcionou

Abra o Claude Code e digite:

```
/mcp
```

Todos os servidores devem aparecer como "connected".

## Usando as ferramentas

As ferramentas são usadas automaticamente quando relevante. Você também pode pedir diretamente:

- `"usa o repomix para analisar meu projeto"`
- `"busca a documentação do ContentPage no MAUI"` → context7
- `"analisa este arquivo em busca de problemas de segurança"` → semgrep
