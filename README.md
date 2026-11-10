# cloudMux

cloudMux provides matching Bash and Fish shortcuts for GitHub CLI, Google Cloud SDK, and Azure CLI on Android Termux and desktop Linux.

## Requirements

- Bash 4 or newer, or Fish 3.3 or newer
- Linux, including Android Termux
- Any of `gh`, `gcloud`, and `az` that you plan to use
- Existing authentication through the official CLI commands

cloudMux never stores credentials. It reads the current shell environment and leaves authentication to `gh auth`, `gcloud auth`, and `az login`.

## Install

From a checkout:

```bash
./install.sh
```

The installer detects Termux or desktop Linux, checks all three CLIs, and asks before installing missing tools when a supported package manager is available. It creates links under `~/.config/cloudmux`, adds a Bash loader to `~/.bashrc.d`, and adds Fish functions to `~/.config/fish`.

For a remote install, set the repository URL explicitly:

```bash
CLOUDMUX_REPO_URL=https://github.com/OWNER/REPOSITORY.git \
  curl -fsSL https://raw.githubusercontent.com/OWNER/REPOSITORY/main/install.sh | bash
```

Replace both placeholders with the real repository location. The installer will not guess or download from an unknown source.

After installation, start a new shell or source the loader:

```bash
source ~/.bashrc.d/cloudmux.bash
```

Fish loads the functions from its next interactive session.

## Usage

Each domain has a help command:

```bash
cloud-help
gh-help
gcloud-help
az-help
```

Example:

```bash
gh-who
gc-set-proj my-project
az-rg-ls
```

Help output uses the columns `Alias / Function Name`, `Full Command Executed`, and `One-line Description`. Commands fail clearly when their CLI is not installed.

## Configuration

cloudMux has no required configuration file and does not read `.env` files.

| Variable | Default | Purpose |
| --- | --- | --- |
| `TERMUX_VERSION` | unset | Used to identify Termux |
| `CLOUDMUX_REPO_URL` | unset | Source repository for the remote installer |
| `CLOUDMUX_INSTALL_DIR` | `~/.config/cloudmux` | Installation directory |
| `CLOUDMUX_NO_INSTALL` | unset | Set to `1` to skip offers to install missing CLIs |

The installer also respects the existing `PATH`, `HOME`, `SHELL`, and package-manager settings.

## Authentication

Use the official tools directly:

```bash
gh-in
gcloud auth login
az login
```

Do not put tokens in shell startup files, `.env` files, aliases, or issue reports.

## Common problems

If a function reports that a CLI is missing, install that CLI with its official package instructions, then start a new shell. If a command reports an authentication error, authenticate with the provider's official command and retry.

If the functions do not appear, check that `~/.bashrc` or Fish's config is loaded by the shell you started.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), and [SECURITY.md](SECURITY.md).

## License

The license is not selected yet. Choose one before publishing: MIT, Apache-2.0, GPL-3.0, or a proprietary notice.
