# Security

## Password Storage

Saved passwords are encrypted with Windows DPAPI for the current Windows user and stored in:

```bat
%APPDATA%\ssh-tool\servers.json
```

This is safer than plain text, but SSH keys are still recommended.

## Recommended Usage

Use:

```bat
sshto keysetup <nickname>
```

After key setup, `sshto <nickname>` should connect using your SSH key.

## Reporting Issues

If you publish this repository publicly, use GitHub issues for bug reports. Do not paste passwords, private keys, server secrets, or full `servers.json` contents into public issues.
