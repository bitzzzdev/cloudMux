#!/usr/bin/env bash

gh-who() { cloudmux-require gh || return; gh auth status "$@"; }
gh-in() { cloudmux-require gh || return; gh auth login "$@"; }
gh-repo-ls() { cloudmux-require gh || return; gh repo list "${1:-}" --limit "${2:-20}"; }
gh-clone() { cloudmux-require gh || return; [[ $# -ge 1 ]] || { printf 'Usage: gh-clone <repo> [directory]\n' >&2; return 2; }; gh repo clone "$@"; }
gh-fork() { cloudmux-require gh || return; [[ $# -ge 1 ]] || { printf 'Usage: gh-fork <repo> [--clone]\n' >&2; return 2; }; gh repo fork "$@"; }
gh-create() { cloudmux-require gh || return; gh repo create "$@"; }
gh-pr-ls() { cloudmux-require gh || return; gh pr list "$@"; }
gh-pr-view() { cloudmux-require gh || return; gh pr view "$@"; }
gh-pr-co() { cloudmux-require gh || return; [[ $# -eq 1 ]] || { printf 'Usage: gh-pr-co <num>\n' >&2; return 2; }; gh pr checkout "$1"; }
gh-pr-diff() { cloudmux-require gh || return; gh pr diff "$@"; }
gh-pr-merge() { cloudmux-require gh || return; gh pr merge "$@"; }
gh-issue-ls() { cloudmux-require gh || return; gh issue list "$@"; }
gh-issue-create() { cloudmux-require gh || return; gh issue create "$@"; }
gh-issue-view() { cloudmux-require gh || return; gh issue view "$@"; }
gh-cs-ls() { cloudmux-require gh || return; gh codespace list "$@"; }
gh-cs-ssh() { cloudmux-require gh || return; [[ $# -eq 1 ]] || { printf 'Usage: gh-cs-ssh <codespace>\n' >&2; return 2; }; gh codespace ssh -c "$1"; }
gh-run-ls() { cloudmux-require gh || return; gh run list "$@"; }
gh-run-watch() { cloudmux-require gh || return; [[ $# -eq 1 ]] || { printf 'Usage: gh-run-watch <run-id>\n' >&2; return 2; }; gh run watch "$1"; }

gh-help() {
  cloudmux-header
  cloudmux-row gh-who "gh auth status" "Show GitHub authentication status"
  cloudmux-row gh-in "gh auth login" "Authenticate with GitHub"
  cloudmux-row gh-repo-ls "gh repo list" "List repositories"
  cloudmux-row gh-clone "gh repo clone <repo>" "Clone a repository"
  cloudmux-row gh-fork "gh repo fork <repo>" "Fork a repository"
  cloudmux-row gh-create "gh repo create" "Create a repository"
  cloudmux-row gh-pr-ls "gh pr list" "List pull requests"
  cloudmux-row gh-pr-view "gh pr view [num]" "View a pull request"
  cloudmux-row gh-pr-co "gh pr checkout <num>" "Check out a pull request"
  cloudmux-row gh-pr-diff "gh pr diff [num]" "Show pull request changes"
  cloudmux-row gh-pr-merge "gh pr merge [num]" "Merge a pull request"
  cloudmux-row gh-issue-ls "gh issue list" "List issues"
  cloudmux-row gh-issue-create "gh issue create" "Create an issue"
  cloudmux-row gh-issue-view "gh issue view [num]" "View an issue"
  cloudmux-row gh-cs-ls "gh codespace list" "List Codespaces"
  cloudmux-row gh-cs-ssh "gh codespace ssh -c <name>" "Connect to a Codespace"
  cloudmux-row gh-run-ls "gh run list" "List workflow runs"
  cloudmux-row gh-run-watch "gh run watch <id>" "Watch a workflow run"
}
