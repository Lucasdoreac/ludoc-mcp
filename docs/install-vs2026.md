# Installing Ludoc MCP Servers in VS 2026

## Prerequisites

- Visual Studio 2026 with GitHub Copilot extension
- Windows 10/11
- Bun (`winget install Oven-sh.Bun`) and/or uvx (`pip install uv`)

## Automatic Install

```powershell
git clone https://github.com/Lucasdoreac/ludoc-mcp
cd ludoc-mcp
.\install-to-vs2026.ps1
```

This merges the servers into `~/.mcp.json` without overwriting existing entries.

## Manual Install

Edit `~/.mcp.json` and add entries from `configs/vs2026-dotnet.json`.

## Verify

1. Open VS 2026
2. Open GitHub Copilot Chat
3. Click `+` → "Add MCP Server"
4. Servers should appear in the list

## Troubleshooting

- If `bun` is not found: install from https://bun.sh
- If `uvx` is not found: `pip install uv`
- Check `%USERPROFILE%\.mcp.json` syntax is valid JSON
