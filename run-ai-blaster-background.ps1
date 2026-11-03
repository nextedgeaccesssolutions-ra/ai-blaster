$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$log = Join-Path $root 'reports\background.log'
$errorLog = Join-Path $root 'reports\background-error.log'
$pidFile = Join-Path $root 'reports\ai-blaster.pid'
New-Item -ItemType Directory -Force (Join-Path $root 'reports') | Out-Null

$process = Start-Process powershell.exe `
  -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File',(Join-Path $root 'run-ai-blaster.ps1') `
  -WorkingDirectory $root `
  -WindowStyle Hidden `
  -RedirectStandardOutput $log `
  -RedirectStandardError $errorLog `
  -PassThru

$process.Id | Set-Content $pidFile
Write-Host "Ai Blaster Jarvis background process started: PID $($process.Id)"
