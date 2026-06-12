

### 1. Install prerequisites

Download and install:

- **Git:** [git-scm.com/download/win](https://git-scm.com/download/win)
- **Node.js (v22+):** [nodejs.org](https://nodejs.org/) → LTS version

### 2. Clone your repo (not Quartz's — yours)

Open PowerShell and run:

```
cd C:\Users\<YourUsername>git clone https://github.com/tuanvutristar/quartz.git
```

### 3. Install dependencies and plugins

```
cd quartznpm installnpx quartz plugin install
```

### 4. Set up Git credentials

Git will prompt for GitHub login the first time you push. When it does:

- **Username:** `tuanvutristar`
- **Password:** use a GitHub Personal Access Token (not your password)

To create a token: go to **GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)** → generate one with `repo` scope. Paste it as the password when prompted — Windows will save it so you only do this once.

### 5. Create the publish shortcut

```
$WshShell = New-Object -ComObject WScript.Shell$shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Publish Tristar Wiki.lnk")$shortcut.TargetPath = "powershell.exe"$shortcut.Arguments = '-ExecutionPolicy Bypass -WindowStyle Normal -File "C:\Users\' + $env:USERNAME + '\quartz\publish.ps1"'$shortcut.WorkingDirectory = "C:\Users\$env:USERNAME\quartz"$shortcut.IconLocation = "shell32.dll,46"$shortcut.Description = "Publish Tristar Wiki to GitHub Pages"$shortcut.Save()
```

### 6. Update the vault path in publish.ps1

The script has your current vault path hardcoded. Edit line 1 of `C:\Users\<YourUsername>\quartz\publish.ps1` to match the vault location on the new machine:

```
$vault = "C:\Users\<NewUsername>\OneDrive - Tristar Electrical\Tristar Wiki"
```

---

**After that, double-click "Publish Tristar Wiki" on the desktop — same as your current machine.**