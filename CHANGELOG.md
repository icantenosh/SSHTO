# Changelog

## 1.0.0

- Added standalone `sshto.exe`.
- Added server nicknames.
- Added saved server list.
- Added encrypted password storage using Windows DPAPI.
- Added SSH key setup with `sshto keysetup <nickname>`.
- Added green ANSI cyberpunk help banner.
- Added picker commands: number, nickname, `help`, `list`, `q`, `quit`, `exit`.
- Made key setup idempotent so duplicate public keys are not appended repeatedly.
