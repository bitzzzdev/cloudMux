function cloudmux_has
    command -q $argv[1]
end

function cloudmux_require
    if not cloudmux_has $argv[1]
        printf '%s is not installed or is not on PATH.\n' $argv[1] >&2
        return 127
    end
end

function cloudmux_row
    printf '%-22s | %-38s | %s\n' $argv[1] $argv[2] $argv[3]
end

function cloudmux_header
    set_color cyan
    printf '%-22s | %-38s | %s\n' 'Alias / Function Name' 'Full Command Executed' 'One-line Description'
    set_color normal
    printf '%s\n' '-----------------------+----------------------------------------+------------------------------'
end

function gh-who
    cloudmux_require gh; or return
    gh auth status $argv
end
function gh-in
    cloudmux_require gh; or return
    gh auth login $argv
end
function gh-repo-ls
    cloudmux_require gh; or return
    set -l owner ''
    set -l limit 20
    test (count $argv) -ge 1; and set owner $argv[1]
    test (count $argv) -ge 2; and set limit $argv[2]
    gh repo list $owner --limit $limit
end
function gh-clone
    cloudmux_require gh; or return
    test (count $argv) -ge 1; or begin; printf 'Usage: gh-clone <repo> [directory]\n' >&2; return 2; end
    gh repo clone $argv
end
function gh-fork
    cloudmux_require gh; or return
    test (count $argv) -ge 1; or begin; printf 'Usage: gh-fork <repo> [--clone]\n' >&2; return 2; end
    gh repo fork $argv
end
function gh-create
    cloudmux_require gh; or return
    gh repo create $argv
end
function gh-pr-ls; cloudmux_require gh; or return; gh pr list $argv; end
function gh-pr-view; cloudmux_require gh; or return; gh pr view $argv; end
function gh-pr-co
    cloudmux_require gh; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: gh-pr-co <num>\n' >&2; return 2; end
    gh pr checkout $argv[1]
end
function gh-pr-diff; cloudmux_require gh; or return; gh pr diff $argv; end
function gh-pr-merge; cloudmux_require gh; or return; gh pr merge $argv; end
function gh-issue-ls; cloudmux_require gh; or return; gh issue list $argv; end
function gh-issue-create; cloudmux_require gh; or return; gh issue create $argv; end
function gh-issue-view; cloudmux_require gh; or return; gh issue view $argv; end
function gh-cs-ls; cloudmux_require gh; or return; gh codespace list $argv; end
function gh-cs-ssh
    cloudmux_require gh; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: gh-cs-ssh <codespace>\n' >&2; return 2; end
    gh codespace ssh -c $argv[1]
end
function gh-run-ls; cloudmux_require gh; or return; gh run list $argv; end
function gh-run-watch
    cloudmux_require gh; or return
    test (count $argv) -eq 1; or begin; printf 'Usage: gh-run-watch <run-id>\n' >&2; return 2; end
    gh run watch $argv[1]
end

function gh-help
    cloudmux_header
    cloudmux_row gh-who 'gh auth status' 'Show GitHub authentication status'
    cloudmux_row gh-in 'gh auth login' 'Authenticate with GitHub'
    cloudmux_row gh-repo-ls 'gh repo list' 'List repositories'
    cloudmux_row gh-clone 'gh repo clone <repo>' 'Clone a repository'
    cloudmux_row gh-fork 'gh repo fork <repo>' 'Fork a repository'
    cloudmux_row gh-create 'gh repo create' 'Create a repository'
    cloudmux_row gh-pr-ls 'gh pr list' 'List pull requests'
    cloudmux_row gh-pr-view 'gh pr view [num]' 'View a pull request'
    cloudmux_row gh-pr-co 'gh pr checkout <num>' 'Check out a pull request'
    cloudmux_row gh-pr-diff 'gh pr diff [num]' 'Show pull request changes'
    cloudmux_row gh-pr-merge 'gh pr merge [num]' 'Merge a pull request'
    cloudmux_row gh-issue-ls 'gh issue list' 'List issues'
    cloudmux_row gh-issue-create 'gh issue create' 'Create an issue'
    cloudmux_row gh-issue-view 'gh issue view [num]' 'View an issue'
    cloudmux_row gh-cs-ls 'gh codespace list' 'List Codespaces'
    cloudmux_row gh-cs-ssh 'gh codespace ssh -c <name>' 'Connect to a Codespace'
    cloudmux_row gh-run-ls 'gh run list' 'List workflow runs'
    cloudmux_row gh-run-watch 'gh run watch <id>' 'Watch a workflow run'
end
