#!/usr/bin/env bash
set -euo pipefail

say() { printf '%s\n' "$*"; }
warn() { printf 'cloudMux: %s\n' "$*" >&2; }

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
install_dir="${CLOUDMUX_INSTALL_DIR:-$HOME/.config/cloudmux}"
temp_dir=""

cleanup() {
  if [[ -n "$temp_dir" && -d "$temp_dir" ]]; then
    rm -rf -- "$temp_dir"
  fi
}
trap cleanup EXIT

if [[ ! -f "$script_dir/bash/main.bash" ]]; then
  repo_url="${CLOUDMUX_REPO_URL:-}"
  if [[ -z "$repo_url" ]]; then
    warn "CLOUDMUX_REPO_URL is required when install.sh is run through curl."
    exit 2
  fi
  command -v git >/dev/null 2>&1 || { warn "git is required for a remote install."; exit 127; }
  temp_dir="$(mktemp -d "${TMPDIR:-/tmp}/cloudmux-install-XXXXXX")"
  git clone --depth 1 "$repo_url" "$temp_dir/repo" >/dev/null
  script_dir="$temp_dir/repo"
fi

if [[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *"/com.termux"* || "${PATH:-}" == *"/com.termux"* ]]; then
  platform=termux
else
  platform=linux
fi

say "cloudMux installer"
say "Platform: $platform"
say "Install directory: $install_dir"

for cli in gh gcloud az; do
  if command -v "$cli" >/dev/null 2>&1; then
    printf '%-8s installed (%s)\n' "$cli" "$(command -v "$cli")"
  else
    printf '%-8s missing\n' "$cli"
  fi
done

install_missing_cli() {
  local cli="$1"
  if [[ "${CLOUDMUX_NO_INSTALL:-}" == "1" ]]; then
    return
  fi
  read -r -p "Install missing $cli now? [y/N] " answer
  [[ "$answer" =~ ^[Yy]$ ]] || return
  if [[ "$platform" == termux && "$cli" == gh ]]; then
    pkg install -y gh
  elif [[ "$platform" == termux ]]; then
    warn "$cli is not offered by this installer's Termux package path. Use the official $cli installer."
  elif command -v pacman >/dev/null 2>&1; then
    case "$cli" in
      gh) sudo pacman -S --needed github-cli ;;
      gcloud) warn "Install Google Cloud SDK from Google's official Linux instructions." ;;
      az) warn "Install Azure CLI from Microsoft's official Linux instructions." ;;
    esac
  elif command -v apt-get >/dev/null 2>&1; then
    case "$cli" in
      gh) sudo apt-get install -y gh ;;
      gcloud) warn "Install Google Cloud SDK from Google's official Linux instructions." ;;
      az) warn "Install Azure CLI from Microsoft's official Linux instructions." ;;
    esac
  elif command -v dnf >/dev/null 2>&1; then
    case "$cli" in
      gh) sudo dnf install -y gh ;;
      gcloud) warn "Install Google Cloud SDK from Google's official Linux instructions." ;;
      az) warn "Install Azure CLI from Microsoft's official Linux instructions." ;;
    esac
  elif command -v brew >/dev/null 2>&1; then
    case "$cli" in
      gh) brew install gh ;;
      gcloud) brew install --cask google-cloud-sdk ;;
      az) brew install azure-cli ;;
    esac
  else
    warn "No supported package manager found for $cli."
  fi
}

for cli in gh gcloud az; do
  command -v "$cli" >/dev/null 2>&1 || install_missing_cli "$cli"
done

mkdir -p "$install_dir" "$HOME/.bashrc.d" "$HOME/.config/fish/conf.d" "$HOME/.config/fish/functions"
ln -sfn "$script_dir/bash" "$install_dir/bash"
ln -sfn "$script_dir/fish" "$install_dir/fish"
ln -sfn "$script_dir/bash/main.bash" "$HOME/.bashrc.d/cloudmux.bash"
ln -sfn "$script_dir/fish/conf.d/cloudmux.fish" "$HOME/.config/fish/conf.d/cloudmux.fish"
for file in "$script_dir"/fish/functions/*.fish; do
  ln -sfn "$file" "$HOME/.config/fish/functions/$(basename "$file")"
done

if [[ -f "$HOME/.bashrc" ]] && ! grep -Fqx 'source "$HOME/.bashrc.d/cloudmux.bash"' "$HOME/.bashrc"; then
  printf '\nsource "$HOME/.bashrc.d/cloudmux.bash"\n' >> "$HOME/.bashrc"
fi

say "Installed. Start a new shell, or run: source ~/.bashrc.d/cloudmux.bash"
