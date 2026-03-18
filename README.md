# Ludoc MCP Marketplace

> Curated MCP servers for **Claude Code**, **VS 2026 GitHub Copilot**, and **Gemini CLI** — maintained by [@Lucasdoreac](https://github.com/Lucasdoreac).

## Quick Install

### Claude Code
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Lucasdoreac/ludoc-mcp/main/install-to-claude.sh)
```

### VS 2026 (Windows)
```powershell
irm https://raw.githubusercontent.com/Lucasdoreac/ludoc-mcp/main/install-to-vs2026.ps1 | iex
```

---

## Included Servers

| Server | Description | Source |
|--------|-------------|--------|
| **ludoc-context** | Unified context server — knowledge graph, journal, constitution, multi-agent coordination | [DNP/ludoc-os](https://github.com/Lucasdoreac/DNP) |
| **repomix** | Pack entire codebase into AI-friendly context | [yamadashy/repomix](https://github.com/yamadashy/repomix) |
| **context7** | Up-to-date library docs injected into prompts | [upstash/context7](https://github.com/upstash/context7) |
| **sequential-thinking** | Dynamic problem solving through thought chains | [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) |
| **browser-tools** | Browser automation and debugging | [AgentDeskAI/browser-tools-mcp](https://github.com/AgentDeskAI/browser-tools-mcp) |
| **semgrep** | Static analysis and security scanning | [semgrep/semgrep](https://github.com/semgrep/semgrep) |
| **ast-grep** | Structural code search and transformation | [ast-grep/ast-grep-mcp](https://github.com/ast-grep/ast-grep-mcp) |

---

## Super Context Server

The `ludoc-context` server acts as a **proxy aggregator** — connecting to the above servers internally and exposing all their tools under a single MCP endpoint.

```
Your Agent (Claude / Copilot / Gemini)
    ↓ 1 connection
ludoc-context (Super Server)
    ├── Native tools (19): constitution, knowledge graph, journal, coordinator...
    ├── repomix__pack_codebase
    ├── ctx7__resolve-library-docs
    ├── think__sequentialthinking
    └── ... (50+ tools unified)
```

---

## Files

- `registry.json` — Official MCP registry format
- `.mcp.json` — Ready-to-use VS 2026 config
- `configs/claude-code.json` — Claude Code `mcpServers` block
- `configs/vs2026-dotnet.json` — .NET MAUI optimized config
- `install-to-vs2026.ps1` — Windows installer (merges into `~/.mcp.json`)
- `install-to-claude.sh` — Claude Code installer
- `docs/` — Per-client installation guides

---

## License

AGPL-3.0 — see [LICENSE](LICENSE)
