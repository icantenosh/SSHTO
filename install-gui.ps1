# SSHTO GUI installer for Windows.

$ErrorActionPreference = "Stop"

$installDir = "C:\Tools"
$exePath = Join-Path $installDir "sshto-gui.exe"
$url = "https://github.com/icantenosh/SSHTO/raw/main/sshto-gui.exe"

New-Item -ItemType Directory -Force $installDir | Out-Null
Invoke-WebRequest -Uri $url -OutFile $exePath

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (($userPath -split ";") -notcontains $installDir) {
    $newPath = if ([string]::IsNullOrWhiteSpace($userPath)) { $installDir } else { "$userPath;$installDir" }
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Added $installDir to your user PATH. Restart PowerShell before running sshto-gui from the command line."
}

Write-Host "Installed SSHTO GUI to $exePath"
