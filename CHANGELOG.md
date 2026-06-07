# Changelog

## Unreleased

- Added standalone Windows GUI as `sshto-gui.exe`.
- Added GUI server management for add, edit, remove, search, connect, and SSH key setup.
- Added internal GUI key setup without opening an external terminal.
- Added persistent GUI themes.
- Added Linux `sshto` Bash version.
- Added Linux pipe-to-shell installer.
- Added Linux install and saved-data documentation.

## 1.0.0

- Added standalone `sshto.exe`.
- Added server nicknames.
- Added saved server list.
- Added encrypted password storage using Windows DPAPI.
- Added SSH key setup with `sshto keysetup <nickname>`.
- Added green ANSI cyberpunk help banner.
- Added picker commands: number, nickname, `help`, `list`, `q`, `quit`, `exit`.
- Made key setup idempotent so duplicate public keys are not appended repeatedly.
