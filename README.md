<p align="center">
  <img src="assets/splash.svg" alt="SSHTO splash screen">
</p>

# SSHTO

Quick SSH launcher for Windows.

`sshto.exe` lets you save SSH server nicknames, list them, connect quickly, and set up SSH key login from the command line.

## Download

For Windows PowerShell:

Download only, to any folder you choose:

```powershell
Invoke-WebRequest -Uri "https://github.com/icantenosh/SSHTO/raw/main/sshto.exe" -OutFile "C:\REPLACE-WITH-YOUR-FOLDER\sshto.exe"
```

Add the folder where you installed `sshto.exe` to your user `PATH` so `sshto` works from any folder.

Example for `C:\Tools`:

```powershell
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Tools", "User")
```

Quick install to `C:\Tools`:

```powershell
New-Item -ItemType Directory -Force "C:\Tools"; Invoke-WebRequest -Uri "https://github.com/icantenosh/SSHTO/raw/main/sshto.exe" -OutFile "C:\Tools\sshto.exe"
```

Restart PowerShell, then test it:

```powershell
sshto help
```

Keep `sshto.exe` directly inside the folder you add to `PATH`.

## Commands

```bat
sshto                              Open the saved-server picker
sshto <nickname>                   Connect to a saved server
sshto add <nickname> <user@host>    Add or update a saved server
sshto add <nickname> <user@host> <port>  Add or update with a custom port
sshto keysetup <nickname>           Install your SSH key on a server
sshto list                         List saved servers
sshto ls                           Same as list
sshto remove <nickname>            Remove a saved server
sshto rm <nickname>                Same as remove
sshto help                         Show help
sshto -h                           Same as help
sshto --help                       Same as help
```

## Examples

```bat
sshto add demo-server demo@server.test
sshto keysetup demo-server
sshto demo-server
sshto list
```

## Saved Data

Server data is stored per Windows user at:

```bat
%APPDATA%\ssh-tool\servers.json
```

Saved passwords are encrypted with Windows DPAPI for the current Windows user. SSH key login is recommended.

## Notes

- `sshto.exe` requires Windows PowerShell and Windows OpenSSH.
- Password auto-login is only possible if `plink.exe` is installed and available on `PATH`.
- `keysetup` is the preferred way to avoid typing server passwords.
