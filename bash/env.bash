#!/usr/bin/env bash

if [[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *"/com.termux"* || "${PATH:-}" == *"/com.termux"* ]]; then
  CLOUDMUX_PLATFORM="termux"
else
  CLOUDMUX_PLATFORM="linux"
fi

if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  CLOUDMUX_BLUE=$'\033[1;34m'
  CLOUDMUX_CYAN=$'\033[1;36m'
  CLOUDMUX_YELLOW=$'\033[1;33m'
  CLOUDMUX_RESET=$'\033[0m'
else
  CLOUDMUX_BLUE=""
  CLOUDMUX_CYAN=""
  CLOUDMUX_YELLOW=""
  CLOUDMUX_RESET=""
fi

cloudmux-has() {
  command -v "$1" >/dev/null 2>&1
}

cloudmux-require() {
  if ! cloudmux-has "$1"; then
    printf '%s is not installed or is not on PATH.\n' "$1" >&2
    return 127
  fi
}

cloudmux-row() {
  printf '%-22s | %-38s | %s\n' "$1" "$2" "$3"
}

cloudmux-header() {
  printf '%s%-22s | %-38s | %s%s\n' \
    "$CLOUDMUX_CYAN" "Alias / Function Name" "Full Command Executed" \
    "One-line Description" "$CLOUDMUX_RESET"
  printf '%s\n' "-----------------------+----------------------------------------+------------------------------"
}

cloud-platform() {
  printf '%s\n' "$CLOUDMUX_PLATFORM"
}
