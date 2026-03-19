#!/usr/bin/env bash
# install-to-claude.sh
# MauiDevTools — Instalador para Claude Code
# Adiciona os servidores MCP ao ~/.claude/settings.json

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS="$HOME/.claude/settings.json"

echo ""
echo "=== MauiDevTools — Instalador Claude Code ==="
echo ""

# Verificar pré-requisitos
missing=()
command -v bunx   &>/dev/null || missing+=("bun     → https://bun.sh")
command -v uvx    &>/dev/null || missing+=("uv      → https://docs.astral.sh/uv/")
command -v dotnet &>/dev/null || missing+=("dotnet  → https://dotnet.microsoft.com/download")

if [ ${#missing[@]} -gt 0 ]; then
  echo "⚠  Pré-requisitos ausentes:"
  for dep in "${missing[@]}"; do echo "   - $dep"; done
  echo ""
  echo "Instale os itens acima e rode este script novamente."
  exit 1
fi

# Criar settings.json se não existir
if [ ! -f "$SETTINGS" ]; then
  mkdir -p "$(dirname "$SETTINGS")"
  echo '{"mcpServers":{}}' > "$SETTINGS"
fi

# Merge via node/bun
if command -v bun &>/dev/null; then RT="bun"; else RT="node"; fi

SCRIPT_DIR="$SCRIPT_DIR" $RT --input-type=module <<'EOF'
import { readFileSync, writeFileSync } from 'fs';

const settingsPath = process.env.HOME + '/.claude/settings.json';
const newConfigPath = process.env.SCRIPT_DIR + '/configs/claude-code.json';

const settings = JSON.parse(readFileSync(settingsPath, 'utf8'));
const { mcpServers: newServers } = JSON.parse(readFileSync(newConfigPath, 'utf8'));

if (!settings.mcpServers) settings.mcpServers = {};

let added = 0, skipped = 0;
for (const [name, server] of Object.entries(newServers)) {
  if (settings.mcpServers[name]) {
    console.log(`  SKIP (já existe): ${name}`);
    skipped++;
  } else {
    settings.mcpServers[name] = server;
    console.log(`  ADD: ${name}`);
    added++;
  }
}

writeFileSync(settingsPath, JSON.stringify(settings, null, 2));
console.log(`\nResultado: ${added} adicionados, ${skipped} já existiam.`);
console.log(`✅ Salvo em: ${settingsPath}`);
console.log('   Reinicie o Claude Code para aplicar.');
EOF

# Instalar NuGet MCP tool se necessário
if ! dotnet tool list -g 2>/dev/null | grep -q "dimonsmart.nugetmcpserver"; then
  echo ""
  echo "📦 Instalando DimonSmart.NugetMcpServer (dotnet global tool)..."
  dotnet tool install -g DimonSmart.NugetMcpServer
fi
