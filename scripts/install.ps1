# Installer for the /lenny router skill (portable) — Windows PowerShell.
#
# Usage:
#   .\install.ps1                    # auto-detect installed agents
#   .\install.ps1 -Agent claude      # ~/.claude/skills/lenny
#   .\install.ps1 -Agent codex       # ~/.codex/skills/lenny
#   .\install.ps1 -Agent hermes      # $env:HERMES_HOME or ~/.hermes/skills/lenny
#   .\install.ps1 -Dest DIR          # explicit skills root
#
# Requires Python 3.9+ on PATH (used to populate the skill library).
param(
    [string]$Agent = "auto",
    [string]$Dest  = ""
)
$ErrorActionPreference = "Stop"
$Pkg = Split-Path -Parent $PSScriptRoot

$py = Get-Command python3 -ErrorAction SilentlyContinue
if (-not $py) { $py = Get-Command python -ErrorAction SilentlyContinue }
if (-not $py) { Write-Error "python is required"; exit 1 }

$libMarker = Join-Path $Pkg "references\routing-table.md"
if (-not (Test-Path $libMarker) -or -not (Test-Path (Join-Path $Pkg "references\lenny\writing-prds"))) {
    Write-Host ">> Populating skill library..."
    & $py.Source (Join-Path $Pkg "scripts\sync_lenny_skills.py")
    if ($LASTEXITCODE -ne 0) { Write-Error "sync failed"; exit 1 }
} else { Write-Host ">> Skill library already present." }

if (-not $Dest) {
    $hermesHome = if ($env:HERMES_HOME) { $env:HERMES_HOME } else { Join-Path $HOME ".hermes" }
    switch ($Agent) {
        "claude" { $Root = Join-Path $HOME ".claude\skills" }
        "codex"  { $Root = Join-Path $HOME ".codex\skills" }
        "hermes" { $Root = Join-Path $hermesHome "skills" }
        "auto" {
            if (Test-Path (Join-Path $HOME ".claude")) { $Root = Join-Path $HOME ".claude\skills" }
            elseif (Test-Path $hermesHome) { $Root = Join-Path $hermesHome "skills" }
            elseif (Test-Path (Join-Path $HOME ".codex")) { $Root = Join-Path $HOME ".codex\skills" }
            else { Write-Error "no supported agent dir found; use -Dest"; exit 1 }
        }
        default { Write-Error "unknown agent: $Agent"; exit 1 }
    }
} else { $Root = $Dest }

$Target = Join-Path $Root "lenny"
Write-Host ">> Installing $Pkg -> $Target"
if (Test-Path $Target) { Remove-Item -Recurse -Force $Target }
New-Item -ItemType Directory -Force -Path $Target | Out-Null
foreach ($item in @("SKILL.md","LICENSE.md","README.md","scripts","references")) {
    Copy-Item -Recurse -Force (Join-Path $Pkg $item) (Join-Path $Target $item)
}
Write-Host ">> Done. Invoke with /lenny <your question> (restart the agent to pick up the new skill)."
