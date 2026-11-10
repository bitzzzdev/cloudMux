set -l cloudmux_root (realpath (status dirname)/../.. 2>/dev/null)
if test -f "$cloudmux_root/fish/functions/gh_helpers.fish"
    set -g CLOUDMUX_ROOT "$cloudmux_root"
    set -g CLOUDMUX_PLATFORM linux
    if set -q TERMUX_VERSION; or string match -q '*com.termux*' "$PREFIX" "$PATH"
        set -g CLOUDMUX_PLATFORM termux
    end
    source "$cloudmux_root/fish/functions/gh_helpers.fish"
    source "$cloudmux_root/fish/functions/gcloud_helpers.fish"
    source "$cloudmux_root/fish/functions/azure_helpers.fish"

    function cloud-help
        printf 'cloudMux platform: %s\n\n' $CLOUDMUX_PLATFORM
        gh-help
        printf '\n'
        gcloud-help
        printf '\n'
        az-help
    end
end
