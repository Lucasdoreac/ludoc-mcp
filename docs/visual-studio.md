# Instalação no Visual Studio 2022 / 2026

## Pré-requisitos

- Visual Studio com extensão **GitHub Copilot**
- [Bun](https://bun.sh) — `winget install Oven-sh.Bun`
- [uv](https://docs.astral.sh/uv/) — `winget install astral-sh.uv`

## Instalação automática

Abra o **PowerShell** (não precisa ser administrador):

```powershell
git clone https://github.com/Lucasdoreac/mauidevtools
cd mauidevtools
.\install-to-vs.ps1
```

Reinicie o Visual Studio.

## Instalação manual

1. Abra (ou crie) o arquivo `%USERPROFILE%\.mcp.json`
2. Copie o conteúdo de `configs/vs.json` para dentro de `"servers"`
3. Salve e reinicie o Visual Studio

## Verificar se funcionou

1. Abra o **GitHub Copilot Chat** (`Ctrl+\`, `Ctrl+C`)
2. Clique em `+` → "Add MCP Server"
3. Os servidores devem aparecer na lista

## Usando as ferramentas

Com os servidores ativos, use o Copilot Chat normalmente — ele usará as ferramentas automaticamente quando pertinente:

```
"Explica como funciona o ciclo de vida de uma página no MAUI"
"Tem algum memory leak neste ViewModel?"
"Refatora esta classe para usar MVVM corretamente"
```
