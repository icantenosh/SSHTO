# Ubuntu SSHTO Test Reset

Temporary helper commands for wiping SSHTO from an Ubuntu test VM.
Remove this file from the repo after testing.

```bash
rm -f ~/.local/bin/sshto ~/.local/bin/sshto-gui
rm -rf ~/.config/ssh-tool
rm -f ~/Downloads/sshto-gui-linux-x86_64
rm -f ~/Downloads/sshto-gui-linux-x86_64.sha256
rm -f ~/Downloads/sshto-gui
rm -f ~/Downloads/install-gui.sh
hash -r
```

If you installed the Debian package:

```bash
sudo apt remove -y sshto-gui
sudo apt autoremove -y
```

Fresh install test:

```bash
curl -fsSL https://github.com/icantenosh/SSHTO/raw/main/install-gui.sh | sh
sshto-gui
```
