# install-to-vs2026.ps1
# Ludoc MCP Marketplace — VS 2026 Installer
# Merges ludoc MCP servers into ~/.mcp.json without overwriting existing entries.

param(
    [string]$ConfigFile = "$PSScriptRoot\configs\vs2026-dotnet.json",
    [switch]$DryRun
)

$mcpJsonPath = "$env:USERPROFILE\.mcp.json"

# Load new servers from config
$newConfig = Get-Content $ConfigFile -Raw | ConvertFrom-Json
$newServers = $newConfig.servers

# Load or initialize existing ~/.mcp.json
if (Test-Path $mcpJsonPath) {
    $existing = Get-Content $mcpJsonPath -Raw | ConvertFrom-Json
    if (-not $existing.servers) {
        $existing | Add-Member -MemberType NoteProperty -Name "servers" -Value @{}
    }
} else {
    $existing = [PSCustomObject]@{ servers = [PSCustomObject]@{} }
}

# Merge — new entries win on conflict
$added = 0
$skipped = 0
foreach ($prop in $newServers.PSObject.Properties) {
    $name = $prop.Name
    if ($existing.servers.PSObject.Properties[$name]) {
        Write-Host "  SKIP (exists): $name"
        $skipped++
    } else {
        $existing.servers | Add-Member -MemberType NoteProperty -Name $name -Value $prop.Value
        Write-Host "  ADD: $name"
        $added++
    }
}

Write-Host ""
Write-Host "Summary: $added added, $skipped skipped."

if ($DryRun) {
    Write-Host "[DRY RUN] Would write to: $mcpJsonPath"
    $existing | ConvertTo-Json -Depth 10
} else {
    $existing | ConvertTo-Json -Depth 10 | Set-Content $mcpJsonPath -Encoding UTF8
    Write-Host "Written to: $mcpJsonPath"
    Write-Host "Restart VS 2026 to apply changes."
}
