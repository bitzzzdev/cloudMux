#!/usr/bin/env bash

az-who() { cloudmux-require az || return; az account show -o table "$@"; }
az-sub-ls() { cloudmux-require az || return; az account list -o table "$@"; }
az-sub-set() { cloudmux-require az || return; [[ $# -eq 1 ]] || { printf 'Usage: az-sub-set <id>\n' >&2; return 2; }; az account set --subscription "$1"; }
az-rg-ls() { cloudmux-require az || return; az group list -o table "$@"; }
az-rg-create() { cloudmux-require az || return; [[ $# -eq 2 ]] || { printf 'Usage: az-rg-create <name> <location>\n' >&2; return 2; }; az group create --name "$1" --location "$2"; }
az-vm-ls() { cloudmux-require az || return; az vm list -o table "$@"; }
az-vm-start() { cloudmux-require az || return; az vm start "$@"; }
az-vm-stop() { cloudmux-require az || return; az vm stop "$@"; }
az-vm-ip() { cloudmux-require az || return; az vm list-ip-addresses "$@"; }
az-usage() { cloudmux-require az || return; az consumption usage list "$@"; }

az-help() {
  cloudmux-header
  cloudmux-row az-who "az account show -o table" "Show the active subscription"
  cloudmux-row az-sub-ls "az account list -o table" "List subscriptions"
  cloudmux-row az-sub-set "az account set --subscription <id>" "Select a subscription"
  cloudmux-row az-rg-ls "az group list -o table" "List resource groups"
  cloudmux-row az-rg-create "az group create --name <name> --location <loc>" "Create a resource group"
  cloudmux-row az-vm-ls "az vm list -o table" "List virtual machines"
  cloudmux-row az-vm-start "az vm start -g <rg> -n <name>" "Start a virtual machine"
  cloudmux-row az-vm-stop "az vm stop -g <rg> -n <name>" "Stop a virtual machine"
  cloudmux-row az-vm-ip "az vm list-ip-addresses -g <rg> -n <name>" "Show virtual machine IPs"
  cloudmux-row az-usage "az consumption usage list" "List consumption usage"
}
