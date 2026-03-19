# install-to-vs.ps1
# MauiDevTools — Instalador para Visual Studio 2022/2026
# Adiciona os servidores MCP ao ~/.mcp.json sem apagar configurações existentes.

param(
    [string]$ConfigFile = "$PSScriptRoot\configs\vs.json",
    [switch]$DryRun
)

$mcpJsonPath = "$env:USERPROFILE\.mcp.json"

Write-Host ""
Write-Host "=== MauiDevTools — Instalador VS ===" -ForegroundColor Cyan
Write-Host ""

# Verificar pré-requisitos
$missingDeps = @()
if (-not (Get-Command "bunx"   -ErrorAction SilentlyContinue)) { $missingDeps += "bun    (winget install Oven-sh.Bun)" }
if (-not (Get-Command "uvx"    -ErrorAction SilentlyContinue)) { $missingDeps += "uv     (winget install astral-sh.uv)" }
if (-not (Get-Command "dotnet" -ErrorAction SilentlyContinue)) { $missingDeps += "dotnet (https://dotnet.microsoft.com/download)" }

if ($missingDeps.Count -gt 0) {
    Write-Host "⚠  Pré-requisitos ausentes:" -ForegroundColor Yellow
    $missingDeps | ForEach-Object { Write-Host "   - $_" }
    Write-Host ""
    Write-Host "Instale os itens acima e rode este script novamente."
    exit 1
}

# Carregar config nova
$newConfig = Get-Content $ConfigFile -Raw | ConvertFrom-Json
$newServers = $newConfig.servers

# Carregar ou criar ~/.mcp.json
if (Test-Path $mcpJsonPath) {
    $existing = Get-Content $mcpJsonPath -Raw | ConvertFrom-Json
    if (-not $existing.servers) {
        $existing | Add-Member -MemberType NoteProperty -Name "servers" -Value ([PSCustomObject]@{})
    }
} else {
    $existing = [PSCustomObject]@{ servers = [PSCustomObject]@{} }
}

# Merge
$added = 0; $skipped = 0
foreach ($prop in $newServers.PSObject.Properties) {
    $name = $prop.Name
    if ($existing.servers.PSObject.Properties[$name]) {
        Write-Host "  SKIP (já existe): $name" -ForegroundColor Gray
        $skipped++
    } else {
        $existing.servers | Add-Member -MemberType NoteProperty -Name $name -Value $prop.Value
        Write-Host "  ADD: $name" -ForegroundColor Green
        $added++
    }
}

Write-Host ""
Write-Host "Resultado: $added adicionados, $skipped já existiam."

# Instalar NuGet MCP tool se necessário
$nugetTool = dotnet tool list -g 2>$null | Select-String "dimonsmart.nugetmcpserver"
if (-not $nugetTool) {
    Write-Host ""
    Write-Host "📦 Instalando DimonSmart.NugetMcpServer (dotnet global tool)..." -ForegroundColor Cyan
    dotnet tool install -g DimonSmart.NugetMcpServer
}

if ($DryRun) {
    Write-Host "[DRY RUN] Não foi salvo. Conteúdo que seria gravado:" -ForegroundColor Yellow
    $existing | ConvertTo-Json -Depth 10
} else {
    $existing | ConvertTo-Json -Depth 10 | Set-Content $mcpJsonPath -Encoding UTF8
    Write-Host ""
    Write-Host "✅ Salvo em: $mcpJsonPath" -ForegroundColor Green
    Write-Host "   Reinicie o Visual Studio para aplicar."
}
