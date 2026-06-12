Clear-Host
Write-Host ""
Write-Host "  ===========================================" -ForegroundColor DarkCyan
Write-Host "     Tristar Wiki  -  Computer Setup        " -ForegroundColor White
Write-Host "  ===========================================" -ForegroundColor DarkCyan
Write-Host ""

$repo    = "$env:USERPROFILE\quartz"
$siteUrl = "https://tuanvutristar.github.io/quartz/"

# ── Check: Git ───────────────────────────────────────────────────────────────
Write-Host "  Checking Git..." -ForegroundColor Cyan
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  Git not found. Opening download page..." -ForegroundColor Yellow
    Start-Process "https://git-scm.com/download/win"
    Write-Host ""
    Write-Host "  Install Git, then run this script again." -ForegroundColor Red
    Read-Host "  Press Enter to close"
    exit 1
}
Write-Host "  Git found." -ForegroundColor Green

# ── Check: Node.js ───────────────────────────────────────────────────────────
Write-Host "  Checking Node.js..." -ForegroundColor Cyan
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "  Node.js not found. Opening download page..." -ForegroundColor Yellow
    Start-Process "https://nodejs.org/en/download"
    Write-Host ""
    Write-Host "  Install Node.js (LTS), then run this script again." -ForegroundColor Red
    Read-Host "  Press Enter to close"
    exit 1
}
Write-Host "  Node.js found." -ForegroundColor Green

# ── Clone repo ───────────────────────────────────────────────────────────────
if (Test-Path "$repo\.git") {
    Write-Host "  Tristar Wiki already set up. Updating..." -ForegroundColor Cyan
    Set-Location $repo
    git pull 2>&1 | Out-Null
    Write-Host "  Updated to latest." -ForegroundColor Green
} else {
    Write-Host "  Downloading Tristar Wiki..." -ForegroundColor Cyan
    git clone https://github.com/tuanvutristar/quartz.git $repo 2>&1 | Out-Null
    Write-Host "  Downloaded." -ForegroundColor Green
}

# ── Install dependencies ──────────────────────────────────────────────────────
Set-Location $repo
Write-Host "  Installing dependencies (first time only, takes ~1 min)..." -ForegroundColor Cyan
npm install --silent 2>&1 | Out-Null
Write-Host "  Installing Quartz plugins..." -ForegroundColor Cyan
npx quartz plugin install 2>&1 | Out-Null
Write-Host "  Done." -ForegroundColor Green

# ── Desktop shortcut ──────────────────────────────────────────────────────────
Write-Host "  Creating desktop shortcut..." -ForegroundColor Cyan
$WshShell  = New-Object -ComObject WScript.Shell
$shortcut  = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Publish Tristar Wiki.lnk")
$shortcut.TargetPath      = "powershell.exe"
$shortcut.Arguments       = "-ExecutionPolicy Bypass -WindowStyle Normal -File `"$repo\publish.ps1`""
$shortcut.WorkingDirectory = $repo
$shortcut.IconLocation    = "shell32.dll,46"
$shortcut.Description     = "Publish Tristar Wiki to GitHub Pages"
$shortcut.Save()
Write-Host "  Shortcut created on Desktop." -ForegroundColor Green

# ── Done ──────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "  ===========================================" -ForegroundColor DarkGreen
Write-Host "   Setup complete!                          " -ForegroundColor Green
Write-Host "                                            " -ForegroundColor Green
Write-Host "   'Publish Tristar Wiki' is on your        " -ForegroundColor Green
Write-Host "   Desktop. Double-click it to publish.     " -ForegroundColor Green
Write-Host "  ===========================================" -ForegroundColor DarkGreen
Write-Host ""
Read-Host "  Press Enter to close"
