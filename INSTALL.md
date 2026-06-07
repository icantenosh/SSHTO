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

1. Copy `sshto` into a folder on your `PATH`, such as `~/.local/bin`:

```bash
mkdir -p ~/.local/bin
cp sshto ~/.local/bin/sshto
chmod +x ~/.local/bin/sshto
```

2. Open a new terminal and test:

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
