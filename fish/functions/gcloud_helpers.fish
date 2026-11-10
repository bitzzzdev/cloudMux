function gc-who; cloudmux_require gcloud; or return; gcloud auth list $argv; end
function gc-cfg-ls; cloudmux_require gcloud; or return; gcloud config list $argv; end
function gc-set-proj
    cloudmux_require gcloud; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: gc-set-proj <id>\n' >&2; return 2; end
    gcloud config set project $argv[1]
end
function gc-vm-ls; cloudmux_require gcloud; or return; gcloud compute instances list $argv; end
function gc-vm-start; cloudmux_require gcloud; or return; gcloud compute instances start $argv; end
function gc-vm-stop; cloudmux_require gcloud; or return; gcloud compute instances stop $argv; end
function gc-vm-ssh; cloudmux_require gcloud; or return; gcloud compute ssh $argv; end
function gc-run-ls; cloudmux_require gcloud; or return; gcloud run services list $argv; end
function gc-run-logs
    cloudmux_require gcloud; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: gc-run-logs <service>\n' >&2; return 2; end
    gcloud run services logs read $argv[1]
end
function gc-storage-ls; cloudmux_require gcloud; or return; gcloud storage ls $argv; end
function gc-storage-cp
    cloudmux_require gcloud; or return
    test (count $argv) -eq 2; or begin; printf 'Usage: gc-storage-cp <src> <dest>\n' >&2; return 2; end
    gcloud storage cp $argv
end
function gcloud-help
    cloudmux_header
    cloudmux_row gc-who 'gcloud auth list' 'Show active accounts'
    cloudmux_row gc-cfg-ls 'gcloud config list' 'Show configuration'
    cloudmux_row gc-set-proj 'gcloud config set project <id>' 'Set the active project'
    cloudmux_row gc-vm-ls 'gcloud compute instances list' 'List virtual machines'
    cloudmux_row gc-vm-start 'gcloud compute instances start <name>' 'Start a virtual machine'
    cloudmux_row gc-vm-stop 'gcloud compute instances stop <name>' 'Stop a virtual machine'
    cloudmux_row gc-vm-ssh 'gcloud compute ssh <name>' 'Connect to a virtual machine'
    cloudmux_row gc-run-ls 'gcloud run services list' 'List Cloud Run services'
    cloudmux_row gc-run-logs 'gcloud run services logs read <service>' 'Read Cloud Run logs'
    cloudmux_row gc-storage-ls 'gcloud storage ls' 'List storage objects'
    cloudmux_row gc-storage-cp 'gcloud storage cp <src> <dest>' 'Copy storage objects'
end
