# Install SSHTO

## Windows

1. Create a tools folder if you do not already have one:

```bat
mkdir C:\Tools
```

2. Copy `sshto.exe` into that folder:

```bat
copy sshto.exe C:\Tools\sshto.exe
```

3. Add `C:\Tools` to your Windows `PATH` if it is not already there.

4. Open a new CMD or PowerShell window and test:

```bat
sshto help
```

## First Server

```bat
sshto add demo-server demo@server.test
sshto keysetup demo-server
sshto demo-server
```

`keysetup` may ask for the server password once so it can install your public SSH key.

## Linux

1. Install `sshto` to `~/.local/bin`:

```bash
curl -fsSL https://github.com/icantenosh/SSHTO/raw/main/install.sh | sh
```

2. If `~/.local/bin` is not already on your `PATH`, add it:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

3. Test:

```bash
sshto help
```

## First Server On Linux

```bash
sshto add demo-server demo@server.test
sshto keysetup demo-server
sshto demo-server
```

Linux saved server data lives at `${XDG_CONFIG_HOME:-$HOME/.config}/ssh-tool/servers.json`.

## Linux GUI

Install the standalone `sshto-gui`, the `sshto` CLI, and common Linux dependencies to `~/.local/bin`:

```bash
curl -fsSL https://github.com/icantenosh/SSHTO/raw/main/install-gui.sh | sh
```

Run it:

```bash
sshto-gui
```

The Linux GUI installer pulls the standalone GUI, the `sshto` CLI, OpenSSH,
terminal support, and Python GUI/key-setup packages when your package manager is
supported.
On Debian or Ubuntu, Tk support is usually available with:

```bash
sudo apt install python3-tk python3-paramiko
```
