#!/bin/sh
set -eu

install_dir="${SSHTO_INSTALL_DIR:-$HOME/.local/bin}"
sshto_gui_url="${SSHTO_GUI_URL:-https://github.com/icantenosh/SSHTO/releases/latest/download/sshto-gui-linux-x86_64}"
sshto_cli_url="${SSHTO_CLI_URL:-https://github.com/icantenosh/SSHTO/raw/main/sshto}"
gui_target="$install_dir/sshto-gui"
cli_target="$install_dir/sshto"
gui_tmp_file="$(mktemp)"
cli_tmp_file="$(mktemp)"

cleanup() {
  rm -f "$gui_tmp_file" "$cli_tmp_file"
}
trap cleanup EXIT HUP INT TERM

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    return 1
  fi
}

install_dependencies() {
  if [ "${SSHTO_GUI_SKIP_DEPS:-0}" = "1" ]; then
    return
  fi

  if command -v apt-get >/dev/null 2>&1; then
    if ! run_as_root apt-get update || ! run_as_root apt-get install -y ca-certificates openssh-client xterm python3 python3-tk python3-paramiko; then
      printf 'sshto-gui install: could not install dependencies automatically. Try: sudo apt-get install ca-certificates openssh-client xterm python3 python3-tk python3-paramiko\n' >&2
    fi
  elif command -v dnf >/dev/null 2>&1; then
    if ! run_as_root dnf install -y ca-certificates openssh-clients xterm python3 python3-tkinter python3-paramiko; then
      printf 'sshto-gui install: could not install dependencies automatically. Try: sudo dnf install ca-certificates openssh-clients xterm python3 python3-tkinter python3-paramiko\n' >&2
    fi
  elif command -v pacman >/dev/null 2>&1; then
    if ! run_as_root pacman -Sy --needed --noconfirm ca-certificates openssh xterm python tk python-paramiko; then
      printf 'sshto-gui install: could not install dependencies automatically. Try: sudo pacman -Sy --needed ca-certificates openssh xterm python tk python-paramiko\n' >&2
    fi
  elif command -v zypper >/dev/null 2>&1; then
    if ! run_as_root zypper --non-interactive install ca-certificates openssh xterm python3 python3-tk python3-paramiko; then
      printf 'sshto-gui install: could not install dependencies automatically. Try: sudo zypper install ca-certificates openssh xterm python3 python3-tk python3-paramiko\n' >&2
    fi
  else
    printf 'sshto-gui install: unsupported package manager; skipping dependency install.\n' >&2
  fi
}

download() {
  url="$1"
  target_file="$2"
  if [ -f "$url" ]; then
    cp "$url" "$target_file"
  elif command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$target_file"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$target_file" "$url"
  else
    printf 'sshto-gui install: curl or wget is required.\n' >&2
    exit 1
  fi
}

install_file() {
  source_file="$1"
  target_file="$2"
  if command -v install >/dev/null 2>&1; then
    install -m 755 "$source_file" "$target_file"
  else
    cp "$source_file" "$target_file"
    chmod +x "$target_file"
  fi
}

install_dependencies

download "$sshto_gui_url" "$gui_tmp_file"
download "$sshto_cli_url" "$cli_tmp_file"

mkdir -p "$install_dir"

install_file "$gui_tmp_file" "$gui_target"
install_file "$cli_tmp_file" "$cli_target"

printf 'SSHTO GUI installed to %s\n' "$gui_target"
printf 'SSHTO CLI installed to %s\n' "$cli_target"

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
