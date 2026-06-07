#!/bin/sh
set -eu

install_dir="${SSHTO_INSTALL_DIR:-$HOME/.local/bin}"
sshto_url="${SSHTO_URL:-https://github.com/icantenosh/SSHTO/raw/main/sshto}"
target="$install_dir/sshto"
tmp_file="$(mktemp)"

cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT HUP INT TERM

if [ -f "$sshto_url" ]; then
  cp "$sshto_url" "$tmp_file"
elif command -v curl >/dev/null 2>&1; then
  curl -fsSL "$sshto_url" -o "$tmp_file"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$tmp_file" "$sshto_url"
else
  printf 'sshto install: curl or wget is required.\n' >&2
  exit 1
fi

mkdir -p "$install_dir"

if command -v install >/dev/null 2>&1; then
  install -m 755 "$tmp_file" "$target"
else
  cp "$tmp_file" "$target"
  chmod +x "$target"
fi

printf 'SSHTO installed to %s\n' "$target"

case ":$PATH:" in
  *":$install_dir:"*) ;;
  *)
    printf '\n%s is not on your PATH yet.\n' "$install_dir"
    printf 'Add it with:\n'
    printf '  echo '\''export PATH="$HOME/.local/bin:$PATH"'\'' >> ~/.bashrc\n'
    printf '  source ~/.bashrc\n'
    ;;
esac

printf '\nTest with:\n  sshto help\n'
