# Add Windows Firewall allow rules for ZODE (ports 3690, 3691, 3692).
# Run this script as Administrator: Right-click -> Run with PowerShell (as Admin),
# or: powershell -ExecutionPolicy Bypass -File "add-zode-firewall-rules.ps1"

$ErrorActionPreference = 'Stop'
$exe = "C:\cargo-builds\the-grid\release\zode-bin.exe"

if (-not (Test-Path $exe)) {
    Write-Warning "zode-bin.exe not found at $exe. Using port-only rules."
    $exe = $null
}

$rules = @(
    @{ Name = "ZODE UDP 3690"; Protocol = "UDP"; Port = 3690 }
    @{ Name = "ZODE TCP 3691"; Protocol = "TCP"; Port = 3691 }
    @{ Name = "ZODE TCP 3692"; Protocol = "TCP"; Port = 3692 }
)

foreach ($r in $rules) {
    $existing = Get-NetFirewallRule -DisplayName $r.Name -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Host "Rule '$($r.Name)' already exists. Skipping."
        continue
    }
    $params = @{
        DisplayName = $r.Name
        Direction   = 'Inbound'
        Protocol    = $r.Protocol
        LocalPort   = $r.Port
        Action      = 'Allow'
    }
    if ($exe) { $params['Program'] = $exe }
    New-NetFirewallRule @params
    Write-Host "Added: $($r.Name)"
}

Write-Host ""
Write-Host "Done. Inbound allow rules for ports 3690 (UDP), 3691 (TCP), 3692 (TCP) are in place."
