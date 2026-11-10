#!/usr/bin/env bash

CLOUDMUX_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source "$CLOUDMUX_ROOT/bash/env.bash"
source "$CLOUDMUX_ROOT/bash/gh.bash"
source "$CLOUDMUX_ROOT/bash/gcloud.bash"
source "$CLOUDMUX_ROOT/bash/azure.bash"

cloud-help() {
  printf '%scloudMux platform: %s%s\n\n' "$CLOUDMUX_BLUE" "$CLOUDMUX_PLATFORM" "$CLOUDMUX_RESET"
  gh-help
  printf '\n'
  gcloud-help
  printf '\n'
  az-help
}
