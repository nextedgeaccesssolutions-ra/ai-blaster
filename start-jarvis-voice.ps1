$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$pidFile = Join-Path $root 'reports\jarvis-voice.pid'
New-Item -ItemType Directory -Force (Join-Path $root 'reports') | Out-Null
$process = Start-Process powershell.exe -WindowStyle Hidden -WorkingDirectory $root -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File',(Join-Path $root 'jarvis-voice.ps1') -PassThru
$process.Id | Set-Content $pidFile
Write-Host "Jarvis voice listener started: PID $($process.Id)"
