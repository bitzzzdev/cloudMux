#!/usr/bin/env bash

gc-who() { cloudmux-require gcloud || return; gcloud auth list "$@"; }
gc-cfg-ls() { cloudmux-require gcloud || return; gcloud config list "$@"; }
gc-set-proj() { cloudmux-require gcloud || return; [[ $# -eq 1 ]] || { printf 'Usage: gc-set-proj <id>\n' >&2; return 2; }; gcloud config set project "$1"; }
gc-vm-ls() { cloudmux-require gcloud || return; gcloud compute instances list "$@"; }
gc-vm-start() { cloudmux-require gcloud || return; [[ $# -ge 1 ]] || { printf 'Usage: gc-vm-start <name> [--zone <zone>]\n' >&2; return 2; }; gcloud compute instances start "$@"; }
gc-vm-stop() { cloudmux-require gcloud || return; [[ $# -ge 1 ]] || { printf 'Usage: gc-vm-stop <name> [--zone <zone>]\n' >&2; return 2; }; gcloud compute instances stop "$@"; }
gc-vm-ssh() { cloudmux-require gcloud || return; [[ $# -ge 1 ]] || { printf 'Usage: gc-vm-ssh <name> [--zone <zone>]\n' >&2; return 2; }; gcloud compute ssh "$@"; }
gc-run-ls() { cloudmux-require gcloud || return; gcloud run services list "$@"; }
gc-run-logs() { cloudmux-require gcloud || return; [[ $# -eq 1 ]] || { printf 'Usage: gc-run-logs <service>\n' >&2; return 2; }; gcloud run services logs read "$1"; }
gc-storage-ls() { cloudmux-require gcloud || return; gcloud storage ls "$@"; }
gc-storage-cp() { cloudmux-require gcloud || return; [[ $# -eq 2 ]] || { printf 'Usage: gc-storage-cp <src> <dest>\n' >&2; return 2; }; gcloud storage cp "$@"; }

gcloud-help() {
  cloudmux-header
  cloudmux-row gc-who "gcloud auth list" "Show active accounts"
  cloudmux-row gc-cfg-ls "gcloud config list" "Show configuration"
  cloudmux-row gc-set-proj "gcloud config set project <id>" "Set the active project"
  cloudmux-row gc-vm-ls "gcloud compute instances list" "List virtual machines"
  cloudmux-row gc-vm-start "gcloud compute instances start <name>" "Start a virtual machine"
  cloudmux-row gc-vm-stop "gcloud compute instances stop <name>" "Stop a virtual machine"
  cloudmux-row gc-vm-ssh "gcloud compute ssh <name>" "Connect to a virtual machine"
  cloudmux-row gc-run-ls "gcloud run services list" "List Cloud Run services"
  cloudmux-row gc-run-logs "gcloud run services logs read <service>" "Read Cloud Run logs"
  cloudmux-row gc-storage-ls "gcloud storage ls" "List storage objects"
  cloudmux-row gc-storage-cp "gcloud storage cp <src> <dest>" "Copy storage objects"
}
