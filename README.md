# 🛠️ MauiDevTools

> Coleção de servidores MCP (_Model Context Protocol_) para turbinar o desenvolvimento **.NET MAUI** com ferramentas de IA.
> Configurado para **Claude Code**, **VS 2022/2026** e **Gemini CLI**.

---

## O que é MCP?

MCP é o protocolo que permite ao seu assistente de IA (Claude, Copilot, Gemini) usar ferramentas externas durante uma conversa — como pesquisar documentação, analisar código, navegar no browser, etc.

Com este pack configurado, você digita uma pergunta e o assistente já tem acesso a todas essas ferramentas automaticamente.

---

## Ferramentas incluídas

| Ferramenta | O que faz |
|------------|-----------|
| **repomix** | Empacota o projeto inteiro em um único contexto para o AI analisar |
| **context7** | Busca documentação atualizada de .NET, MAUI, NuGet e outras libs |
| **sequential-thinking** | Resolve problemas complexos em cadeia de raciocínio estruturado |
| **browser-tools** | Inspeciona o browser, captura screenshots, lê console de erros |
| **semgrep** | Análise estática de código — encontra bugs e problemas de segurança |
| **ast-grep** | Busca estrutural no código (por padrões de sintaxe, não só texto) |

---

## Instalação

### Pré-requisitos

```bash
# Bun (gerenciador de pacotes JS — mais rápido que npm)
winget install Oven-sh.Bun

# uv (gerenciador Python — necessário para semgrep e ast-grep)
winget install astral-sh.uv
```

### Claude Code

```bash
git clone https://github.com/Lucasdoreac/mauidevtools
cd mauidevtools
bash install-to-claude.sh
```

Reinicie o Claude Code depois.

### VS 2022 / VS 2026 (GitHub Copilot Chat)

```powershell
git clone https://github.com/Lucasdoreac/mauidevtools
cd mauidevtools
.\install-to-vs.ps1
```

Reinicie o Visual Studio depois.

### Manual (copiar e colar)

Copie o conteúdo de `configs/claude-code.json` para o seu `~/.claude/settings.json` (bloco `mcpServers`).
Para VS, copie `configs/vs.json` para `~/.mcp.json`.

---

## Como usar no Claude Code

Depois de instalar, experimente no Claude:

```
"Analisa o projeto inteiro e explica a arquitetura"
→ usa repomix automaticamente

"Como funciona NavigationPage no .NET MAUI?"
→ usa context7 para buscar a doc oficial atualizada

"Tem algum bug de segurança neste ViewModel?"
→ usa semgrep para análise estática

"Tira um screenshot do app rodando e analisa a UI"
→ usa browser-tools
```

---

## Estrutura do repositório

```
mauidevtools/
├── README.md                  # este arquivo
├── registry.json              # catálogo oficial MCP
├── configs/
│   ├── claude-code.json       # config para Claude Code
│   └── vs.json                # config para VS 2022/2026
├── install-to-claude.sh       # instalador automático (Claude Code)
├── install-to-vs.ps1          # instalador automático (Visual Studio)
├── servers/                   # submodules dos projetos open-source
│   ├── repomix/
│   ├── context7/
│   └── browser-tools/
└── docs/
    ├── claude-code.md         # guia detalhado Claude Code
    └── visual-studio.md       # guia detalhado Visual Studio
```

---

## Suporte

Abra uma [issue](https://github.com/Lucasdoreac/mauidevtools/issues) ou fale com o professor.

---

Feito para a disciplina de **Programação para Dispositivos Móveis — .NET MAUI**
