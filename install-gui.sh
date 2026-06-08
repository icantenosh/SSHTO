#!/bin/sh
set -eu

install_dir="${SSHTO_INSTALL_DIR:-$HOME/.local/bin}"
sshto_gui_url="${SSHTO_GUI_URL:-https://github.com/icantenosh/SSHTO/raw/main/sshto-gui}"
target="$install_dir/sshto-gui"
tmp_file="$(mktemp)"

cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT HUP INT TERM

if [ -f "$sshto_gui_url" ]; then
  cp "$sshto_gui_url" "$tmp_file"
elif command -v curl >/dev/null 2>&1; then
  curl -fsSL "$sshto_gui_url" -o "$tmp_file"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$tmp_file" "$sshto_gui_url"
else
  printf 'sshto-gui install: curl or wget is required.\n' >&2
  exit 1
fi

mkdir -p "$install_dir"

if command -v python3 >/dev/null 2>&1; then
  :
else
  printf 'sshto-gui install: python3 is required.\n' >&2
  exit 1
fi

if python3 - <<'PY'
import tkinter
PY
then
  :
else
  printf 'sshto-gui install: Python Tk support is required.\n' >&2
  printf 'Install it with your package manager, for example: sudo apt install python3-tk\n' >&2
  exit 1
fi

if command -v install >/dev/null 2>&1; then
  install -m 755 "$tmp_file" "$target"
else
  cp "$tmp_file" "$target"
  chmod +x "$target"
fi

printf 'SSHTO GUI installed to %s\n' "$target"

case ":$PATH:" in
  *":$install_dir:"*) ;;
  *)
    printf '\n%s is not on your PATH yet.\n' "$install_dir"
    printf 'Add it with:\n'
    printf '  echo '\''export PATH="$HOME/.local/bin:$PATH"'\'' >> ~/.bashrc\n'
    printf '  source ~/.bashrc\n'
    ;;
esac

printf '\nRun with:\n  sshto-gui\n'
