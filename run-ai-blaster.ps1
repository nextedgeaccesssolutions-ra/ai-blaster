$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

Write-Host 'Running Ai Blaster monitor...'
python .\monitor.py

Write-Host 'Running Ai Blaster skill radar...'
python .\skill_radar.py

Write-Host 'Ai Blaster completed.'
