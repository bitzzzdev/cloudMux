function az-who; cloudmux_require az; or return; az account show -o table $argv; end
function az-sub-ls; cloudmux_require az; or return; az account list -o table $argv; end
function az-sub-set
    cloudmux_require az; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: az-sub-set <id>\n' >&2; return 2; end
    az account set --subscription $argv[1]
end
function az-rg-ls; cloudmux_require az; or return; az group list -o table $argv; end
function az-rg-create
    cloudmux_require az; or return
    test (count $argv) -eq 2; or begin; printf 'Usage: az-rg-create <name> <location>\n' >&2; return 2; end
    az group create --name $argv[1] --location $argv[2]
end
function az-vm-ls; cloudmux_require az; or return; az vm list -o table $argv; end
function az-vm-start; cloudmux_require az; or return; az vm start $argv; end
function az-vm-stop; cloudmux_require az; or return; az vm stop $argv; end
function az-vm-ip; cloudmux_require az; or return; az vm list-ip-addresses $argv; end
function az-usage; cloudmux_require az; or return; az consumption usage list $argv; end
function az-help
    cloudmux_header
    cloudmux_row az-who 'az account show -o table' 'Show the active subscription'
    cloudmux_row az-sub-ls 'az account list -o table' 'List subscriptions'
    cloudmux_row az-sub-set 'az account set --subscription <id>' 'Select a subscription'
    cloudmux_row az-rg-ls 'az group list -o table' 'List resource groups'
    cloudmux_row az-rg-create 'az group create --name <name> --location <loc>' 'Create a resource group'
    cloudmux_row az-vm-ls 'az vm list -o table' 'List virtual machines'
    cloudmux_row az-vm-start 'az vm start -g <rg> -n <name>' 'Start a virtual machine'
    cloudmux_row az-vm-stop 'az vm stop -g <rg> -n <name>' 'Stop a virtual machine'
    cloudmux_row az-vm-ip 'az vm list-ip-addresses -g <rg> -n <name>' 'Show virtual machine IPs'
    cloudmux_row az-usage 'az consumption usage list' 'List consumption usage'
end
