---
password: Tristar5014
---

### Step 1 – Add the Tristar Wiki Shortcut

Open the [Tristar Wiki](https://tristarelectrical-my.sharepoint.com/:f:/g/personal/tuan_vu_tristar_com_au/IgDu1zrkDbNNT7temxjc5PkFAS9utQEpS69jlwvlqBO8wFY?e=e5V9tS) link and click **"Add shortcut to My files"**.

Make sure you are signed in with your **Tristar Microsoft account**.

### Step 2 – Set Up OneDrive

1. Install **OneDrive Desktop** on your computer.
2. Sign in using your **Tristar account**.
3. Locate the **Tristar Wiki** folder in OneDrive.
4. Right-click the folder and select **"Always keep on this device"** to ensure all files are available offline.

### Step 3 – Install Obsidian

1. Visit [**https://obsidian.md/download**](https://obsidian.md/download)
2. Download and install **Obsidian** on your computer.
3. Open the vault by selecting the **Tristar Wiki** folder located in your **OneDrive**.

### Step 4 – Install the One-Click Publish Tool

This only needs to be completed once.

1. Press **Win + R**.
2. Paste the command below and press **Enter**:

```
powershell -ExecutionPolicy Bypass -Command "iwr 'https://raw.githubusercontent.com/tuanvutristar/quartz/main/setup.ps1' -OutFile $env:TEMP\setup.ps1; & $env:TEMP\setup.ps1"
```

3. Wait for the installation to complete.

A **"Publish Tristar Wiki"** shortcut will then appear on your desktop.

***Note:** Node.js and Git will be installed automatically if they are not already installed on your computer.*

***Note:** If you are prompted to sign in with a Tristar account, please contact Tuan for assistance.*

## Step 5. How to publish a Page

1.     Write or edit a note in Obsidian as normal
2.     Double-click "Publish Tristar Wiki" on your Desktop
3.     Wait ~1 minute — your page is live

Live site: https://tuanvutristar.github.io/quartz/  (password: Please contact Tuan)
