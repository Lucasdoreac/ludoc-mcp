#!/usr/bin/env bash
# install-to-claude.sh
# Ludoc MCP Marketplace — Claude Code installer
# Adds ludoc MCP servers to Claude Code settings.json

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS_FILE="$HOME/.claude/settings.json"

echo "=== Ludoc MCP Marketplace — Claude Code Installer ==="
echo ""

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "Creating $SETTINGS_FILE..."
    echo '{"mcpServers":{}}' > "$SETTINGS_FILE"
fi

# Use node/bun to merge JSON safely
if command -v bun &>/dev/null; then
    RUNTIME="bun"
elif command -v node &>/dev/null; then
    RUNTIME="node"
else
    echo "ERROR: bun or node required"
    exit 1
fi

$RUNTIME - <<'MERGE_SCRIPT'
import { readFileSync, writeFileSync } from 'fs';
import { join } from 'path';

const settingsPath = process.env.HOME + '/.claude/settings.json';
const newConfigPath = process.env.SCRIPT_DIR + '/configs/claude-code.json';

const settings = JSON.parse(readFileSync(settingsPath, 'utf8'));
const newConfig = JSON.parse(readFileSync(newConfigPath, 'utf8'));

if (!settings.mcpServers) settings.mcpServers = {};

let added = 0, skipped = 0;
for (const [name, server] of Object.entries(newConfig.mcpServers)) {
    if (settings.mcpServers[name]) {
        console.log(`  SKIP (exists): ${name}`);
        skipped++;
    } else {
        settings.mcpServers[name] = server;
        console.log(`  ADD: ${name}`);
        added++;
    }
}

writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
console.log(`\nSummary: ${added} added, ${skipped} skipped.`);
console.log(`Written to: ${settingsPath}`);
console.log('Restart Claude Code to apply changes.');
MERGE_SCRIPT
