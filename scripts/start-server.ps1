# Starts the PicoPrint IPP server in the background, listening on this PC only.
param(
    [string]$Exe = (Join-Path (Split-Path $PSScriptRoot -Parent) 'tp.exe')
)
$dir = Split-Path $Exe -Parent
New-Item -ItemType Directory -Force (Join-Path $dir 'logs') | Out-Null
Start-Process -FilePath $Exe -WorkingDirectory $dir -WindowStyle Hidden `
    -ArgumentList 'server', '-no-tui', '-addr', '127.0.0.1:6310', '-log', 'logs\server.log'
