#!/usr/bin/env pwsh
# Removes the bundled UIEditor.rbxm plugin from Roblox Studio.
# Cross-platform (macOS + Windows). Requires PowerShell 7+ (`pwsh`).
# Re-run after every Roblox Studio update (the file gets restored).
#
# Run directly:      pwsh ./ClearRobloxUIEditor.ps1   (or  ./ClearRobloxUIEditor.ps1  once chmod +x'd)

$ErrorActionPreference = 'Stop'

# Collect the target file(s) for the current OS.
$Targets = @()

if ($IsMacOS) {
    $Mac = '/Applications/RobloxStudio.app/Contents/Resources/BuiltInPlugins/Optimized_Embedded_Signature/UIEditor.rbxm'
    if (Test-Path -LiteralPath $Mac) { $Targets += $Mac }
}
elseif ($IsWindows) {
    # Roblox Studio installs per-user, one folder per version.
    $VersionsRoot = Join-Path $env:LOCALAPPDATA 'Roblox\Versions'
    if (Test-Path $VersionsRoot) {
        $Targets += Get-ChildItem -Path $VersionsRoot -Recurse -Filter 'UIEditor.rbxm' -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -match '\\BuiltInPlugins\\' } |
            ForEach-Object { $_.FullName }
    }
}
else {
    Write-Host "Unsupported OS — this script handles macOS and Windows only."
    exit 1
}

if (-not $Targets) {
    Write-Host "Already gone: no UIEditor.rbxm found."
    exit 0
}

# /Applications is root-owned on macOS, so elevate if we aren't already.
if ($IsMacOS -and (id -u) -ne '0') {
    if ($PSCommandPath) {
        Write-Host "Requesting sudo to remove the plugin..."
        & sudo pwsh -File $PSCommandPath @args
        exit $LASTEXITCODE
    }
    Write-Host "Run with elevation: sudo pwsh -c `"irm <raw-url> | iex`""
    exit 1
}

foreach ($File in $Targets) {
    Remove-Item -LiteralPath $File -Force
    Write-Host "Removed: $File"
}
