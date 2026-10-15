# Registers the local IPP server (tp server) as a Windows printer. Run elevated.
param(
    [string]$Name = 'LX-D02 Termica',
    [string]$Url  = 'http://127.0.0.1:6310/printers/default'
)
$log = Join-Path $PSScriptRoot 'install-printer.log'
try {
    if (Get-Printer -Name $Name -ErrorAction SilentlyContinue) { Remove-Printer -Name $Name }
    Add-Printer -Name $Name -IppURL $Url -ErrorAction Stop
    "ADDED $Name -> $Url" | Out-File -Encoding utf8 $log
} catch {
    "ERR: $($_.Exception.Message)" | Out-File -Encoding utf8 $log
}
