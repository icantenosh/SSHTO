# Install SSHTO

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
