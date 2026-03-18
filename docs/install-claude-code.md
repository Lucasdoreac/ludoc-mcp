# Installing Ludoc MCP Servers in Claude Code

## Automatic Install

```bash
git clone https://github.com/Lucasdoreac/ludoc-mcp
cd ludoc-mcp
bash install-to-claude.sh
```

## Manual Install

Add the `mcpServers` block from `configs/claude-code.json` to `~/.claude/settings.json`.

## Super Server Mode

Instead of running all MCPs separately, use only `ludoc-os` with proxy pool enabled:

```json
{
  "mcpServers": {
    "ludoc-os": {
      "command": "C:\\Users\\ludoc\\.bun\\bin\\bun.exe",
      "args": ["run", "C:\\Users\\ludoc\\DNP\\services\\ludoc-os\\src\\api\\mcp-server.ts"]
    }
  }
}
```

This single connection exposes 50+ tools (native + proxied).

## Verify

```bash
# Check tools/list response
echo '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' | bun run DNP/services/ludoc-os/src/api/mcp-server.ts

# Check proxy status
# In Claude: call proxy_status tool
```
