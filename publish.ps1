# Auto-detect vault (works on any computer)
$vault = "$env:USERPROFILE\OneDrive - Tristar Electrical\Tristar Wiki"
if (-not (Test-Path $vault)) {
    $found = Get-ChildItem "$env:USERPROFILE" -Recurse -Directory -Filter "Tristar Wiki" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) { $vault = $found.FullName }
}
$content  = "$env:USERPROFILE\quartz\content"
$repo     = "$env:USERPROFILE\quartz"
$siteUrl  = "https://tuanvutristar.github.io/quartz/"
$password = "Tristar5014"

Clear-Host
Write-Host ""
Write-Host "  ===========================================" -ForegroundColor DarkCyan
Write-Host "       Tristar Wiki  -  Publish Tool        " -ForegroundColor White
Write-Host "  ===========================================" -ForegroundColor DarkCyan
Write-Host ""

# Step 1: Sync vault to content/
Write-Host "  Syncing vault..." -ForegroundColor Cyan
robocopy $vault $content /E /XD .obsidian /XF .gitkeep /R:2 /W:1 | Out-Null
Write-Host "  Vault synced." -ForegroundColor Green

# Step 2: Inject password into all markdown files
Write-Host "  Applying password protection..." -ForegroundColor Cyan
$mdFiles = Get-ChildItem $content -Recurse -Filter "*.md"
foreach ($file in $mdFiles) {
    $text = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    if ($text -match "(?s)^---\r?\n.*?\r?\n---") {
        # Has frontmatter already
        if ($text -notmatch "(?m)^password:") {
            # Add password field after opening ---
            $text = $text -replace "^---(\r?\n)", "---`$1password: $password`$1"
            [System.IO.File]::WriteAllText($file.FullName, $text, [System.Text.Encoding]::UTF8)
        }
    } else {
        # No frontmatter - prepend it
        $text = "---`npassword: $password`n---`n`n" + $text
        [System.IO.File]::WriteAllText($file.FullName, $text, [System.Text.Encoding]::UTF8)
    }
}
Write-Host "  Password applied to $($mdFiles.Count) page(s)." -ForegroundColor Green

# Step 3: Check for changes
Set-Location $repo
$changes = git status --porcelain 2>&1

if (-not $changes) {
    Write-Host ""
    Write-Host "  No new changes - your site is already up to date." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  $siteUrl" -ForegroundColor DarkGray
    Write-Host ""
    Read-Host "  Press Enter to close"
    exit 0
}

Write-Host ""
Write-Host "  Changes to publish:" -ForegroundColor Cyan
$changes | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }

# Step 4: Commit and push
Write-Host ""
Write-Host "  Publishing to GitHub..." -ForegroundColor Cyan
git add content/ | Out-Null
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "publish: $timestamp" | Out-Null
git push 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "  ===========================================" -ForegroundColor DarkGreen
    Write-Host "   Done! Live at: $siteUrl" -ForegroundColor Green
    Write-Host "   (Takes ~1 minute to update)             " -ForegroundColor Green
    Write-Host "  ===========================================" -ForegroundColor DarkGreen
    Write-Host ""
    Start-Process $siteUrl
} else {
    Write-Host ""
    Write-Host "  Push failed. Check your internet connection." -ForegroundColor Red
}

Read-Host "  Press Enter to close"
