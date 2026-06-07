<p align="center">
  <img src="assets/splash.svg" alt="SSHTO splash screen">
</p>

# SSHTO

Quick SSH launcher for Windows and Linux.

`sshto.exe` on Windows and `sshto` on Linux let you save SSH server nicknames, list them, connect quickly, and set up SSH key login from the command line.

## Install

### Windows

Install to `C:\Tools`:

```powershell
New-Item -ItemType Directory -Force "C:\Tools"
Invoke-WebRequest -Uri "https://github.com/icantenosh/SSHTO/raw/main/sshto.exe" -OutFile "C:\Tools\sshto.exe"
```

Add `C:\Tools` to your user `PATH`:

```powershell
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Tools", "User")
```

Restart PowerShell, then test it:

```powershell
sshto help
```

### Linux

```bash
curl -fsSL https://github.com/icantenosh/SSHTO/raw/main/install.sh | sh
```

If `~/.local/bin` is not already on your `PATH`, add it:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Test it:

```bash
sshto help
```

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

On Windows, server data is stored per Windows user at:

```bat
%APPDATA%\ssh-tool\servers.json
```

Saved passwords are encrypted with Windows DPAPI for the current Windows user. SSH key login is recommended.

On Linux, server data is stored at:

```bash
${XDG_CONFIG_HOME:-$HOME/.config}/ssh-tool/servers.json
```

The Linux version does not store passwords. Use `sshto keysetup <nickname>` to install your SSH public key.

## Notes

- `sshto.exe` requires Windows PowerShell and Windows OpenSSH.
- `sshto` for Linux requires Bash, Python 3, and OpenSSH.
- Password auto-login is only possible if `plink.exe` is installed and available on `PATH`.
- `keysetup` is the preferred way to avoid typing server passwords.
