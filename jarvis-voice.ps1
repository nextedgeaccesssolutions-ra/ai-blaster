$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Speech

$root = $PSScriptRoot
$log = Join-Path $root 'reports\jarvis-voice.log'
New-Item -ItemType Directory -Force (Join-Path $root 'reports') | Out-Null

$recognizer = New-Object System.Speech.Recognition.SpeechRecognitionEngine
$builder = New-Object System.Speech.Recognition.GrammarBuilder
$builder.AppendDictation()
$grammar = New-Object System.Speech.Recognition.Grammar($builder)
$recognizer.LoadGrammar($grammar)
$recognizer.SetInputToDefaultAudioDevice()

function Write-JarvisLog([string]$message) {
  Add-Content -Path $log -Value "$(Get-Date -Format o) $message"
}

function Invoke-JarvisCommand([string]$command) {
  Write-JarvisLog "Heard: $command"
  if ($command -notmatch '^\\s*jarvis\\b') { return }
  switch -Regex ($command.ToLowerInvariant()) {
    'status' {
      $latest = Join-Path $root 'reports\latest.json'
      if (Test-Path $latest) { Write-JarvisLog (Get-Content $latest -Raw) }
    }
    'run monitor' { Start-Process python.exe -WindowStyle Hidden -WorkingDirectory $root -ArgumentList (Join-Path $root 'monitor.py') }
    'run skill radar' { Start-Process python.exe -WindowStyle Hidden -WorkingDirectory $root -ArgumentList (Join-Path $root 'skill_radar.py') }
    'stop listener' { $script:stop = $true }
  }
}

$recognizer.add_SpeechRecognized({ param($sender, $event) Invoke-JarvisCommand $event.Result.Text })
$recognizer.RecognizeAsync([System.Speech.Recognition.RecognizeMode]::Multiple)
Write-JarvisLog 'Voice listener started. Say: Jarvis status, Jarvis run monitor, Jarvis run skill radar, or Jarvis stop listener.'
while (-not $script:stop) { Start-Sleep -Seconds 1 }
$recognizer.RecognizeAsyncCancel()
$recognizer.Dispose()
Write-JarvisLog 'Voice listener stopped.'
