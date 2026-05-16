param(
    [int64]$LimitGB = 5
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$LimitBytes = $LimitGB * 1GB

$items = Get-ChildItem -LiteralPath $Root -Force -Recurse -File -ErrorAction SilentlyContinue
$totalBytes = ($items | Measure-Object -Property Length -Sum).Sum
if ($null -eq $totalBytes) {
    $totalBytes = 0
}

$topDirs = Get-ChildItem -LiteralPath $Root -Force -Directory | ForEach-Object {
    $dir = $_
    $size = (Get-ChildItem -LiteralPath $dir.FullName -Force -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    if ($null -eq $size) {
        $size = 0
    }

    [PSCustomObject]@{
        Path = $dir.FullName
        SizeMB = [math]::Round($size / 1MB, 2)
    }
} | Sort-Object -Property SizeMB -Descending

$percent = if ($LimitBytes -gt 0) {
    [math]::Round(($totalBytes / $LimitBytes) * 100, 2)
} else {
    0
}

$status = "OK"
if ($totalBytes -ge $LimitBytes) {
    $status = "OVER_LIMIT"
} elseif ($totalBytes -ge (4.5GB)) {
    $status = "CRITICAL"
} elseif ($totalBytes -ge (4GB)) {
    $status = "PAUSE_ARTIFACTS"
} elseif ($totalBytes -ge (3GB)) {
    $status = "WARN"
}

Write-Host "Storage status: $status"
Write-Host "Workspace: $Root"
Write-Host "Used: $([math]::Round($totalBytes / 1MB, 2)) MB / $LimitGB GB ($percent%)"
Write-Host ""
Write-Host "Top-level directory sizes:"
$topDirs | Format-Table -AutoSize

if ($status -eq "OVER_LIMIT") {
    exit 2
}

if ($status -eq "CRITICAL" -or $status -eq "PAUSE_ARTIFACTS" -or $status -eq "WARN") {
    exit 1
}

