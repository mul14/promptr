#!/bin/bash

set -euo pipefail

if [[ "$OSTYPE" != "linux-gnu"* && "$OSTYPE" != "darwin"* && "$OSTYPE" != "freebsd"* ]]; then
    echo "This script is only compatible with Unix-like systems (Linux, macOS, FreeBSD)."
    exit 1
fi

# Usage:
#   curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | bash -s -- https://github.com/your/prompt.git
#   curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | PROMPTR_REPO=https://github.com/your/prompt.git bash
#   PROMPTR_REPO=https://github.com/your/prompt.git bash setup.sh   # using a local copy of setup.sh
#
# Arguments:
#   $1 (required): repository URL (wins over PROMPTR_REPO)
#   $2 (optional): clone directory (default: ~/.prompts)

if [ $# -ge 1 ]; then
    REPO_URL=$1
elif [ -n "${PROMPTR_REPO:-}" ]; then
    REPO_URL=$PROMPTR_REPO
else
    cat <<EOF
Error: No repository URL provided.
Pass the repo as the first argument or set PROMPTR_REPO.
Example: curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | bash -s -- https://gitea.sev-2.com/refactory/prompt.git
Or with env (note: set env for bash, not curl):
    curl -fsSL https://raw.githubusercontent.com/mul14/promptr/master/setup.sh | PROMPTR_REPO=https://gitea.sev-2.com/refactory/prompt.git bash
EOF
    exit 1
fi

CLONE_DIR=${2:-"$HOME/.prompts"}
CLONE_DIR="${CLONE_DIR/#\~/$HOME}"

if ! command -v git >/dev/null 2>&1; then
    echo "git is required to continue. Install git and retry."
    exit 1
fi

if [ -d "$CLONE_DIR/.git" ]; then
    current_remote=$(git -C "$CLONE_DIR" config --get remote.origin.url || true)
    if [ -n "$current_remote" ] && [ "$current_remote" != "$REPO_URL" ]; then
        cat <<EOF
Repository already exists at $CLONE_DIR with remote:
    $current_remote
Requested repo:
    $REPO_URL
Move/remove the existing directory or pass the matching repo URL.
EOF
        exit 1
    fi
    echo "Updating existing repository at $CLONE_DIR..."
    git -C "$CLONE_DIR" pull --ff-only
elif [ -d "$CLONE_DIR" ]; then
    echo "Directory $CLONE_DIR exists but is not a git repository. Move or remove it, then rerun."
    exit 1
else
    echo "Cloning repository into $CLONE_DIR..."
    git clone "$REPO_URL" "$CLONE_DIR"
fi

PROMPTR_CLI_URL="${PROMPTR_CLI_URL:-https://raw.githubusercontent.com/mul14/promptr/master/bin/promptr}"
INSTALL_BIN="$HOME/.local/bin/promptr"
cli_was_present=false
if [ -f "$INSTALL_BIN" ]; then
    cli_was_present=true
fi

echo "Downloading promptr CLI to $INSTALL_BIN from $PROMPTR_CLI_URL ..."
mkdir -p "$HOME/.local/bin"
if command -v curl >/dev/null 2>&1; then
    if ! curl -fsSL "$PROMPTR_CLI_URL" -o "$INSTALL_BIN"; then
        echo "Failed to download CLI from $PROMPTR_CLI_URL. Set PROMPTR_CLI_URL to a valid path and retry."
        exit 1
    fi
elif command -v wget >/dev/null 2>&1; then
    if ! wget -qO "$INSTALL_BIN" "$PROMPTR_CLI_URL"; then
        echo "Failed to download CLI from $PROMPTR_CLI_URL. Set PROMPTR_CLI_URL to a valid path and retry."
        exit 1
    fi
else
    echo "Neither curl nor wget is available to download the CLI. Install one and retry."
    exit 1
fi

chmod +x "$INSTALL_BIN"
if [ "$cli_was_present" = true ]; then
    echo "Updated promptr at $INSTALL_BIN"
else
    echo "Installed promptr to $INSTALL_BIN"
fi
if "$INSTALL_BIN" --version >/dev/null 2>&1; then
    echo "promptr version: $("$INSTALL_BIN" --version)"
else
    echo "promptr version: unavailable (run $INSTALL_BIN --version to check)"
fi

PATH_LINE_ADDED=false

ensure_path_line() {
    local config_file=$1
    local line=$2

    touch "$config_file"
    if ! grep -qF "$line" "$config_file"; then
        echo "$line" >> "$config_file"
        echo "Added PATH entry to $config_file"
        PATH_LINE_ADDED=true
    fi
}

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    case "$SHELL" in
        */bash)
            ensure_path_line "$HOME/.bashrc" 'export PATH="$HOME/.local/bin:$PATH"'
            if [ "$PATH_LINE_ADDED" = true ]; then
                echo "Restart your shell or run: source ~/.bashrc"
            fi
            ;;
        */zsh)
            ensure_path_line "$HOME/.zshrc" 'export PATH="$HOME/.local/bin:$PATH"'
            if [ "$PATH_LINE_ADDED" = true ]; then
                echo "Restart your shell or run: source ~/.zshrc"
            fi
            ;;
        */fish)
            mkdir -p "$HOME/.config/fish"
            ensure_path_line "$HOME/.config/fish/config.fish" 'set -x PATH $HOME/.local/bin $PATH'
            if [ "$PATH_LINE_ADDED" = true ]; then
                echo "Restart your shell or run: source ~/.config/fish/config.fish"
            fi
            ;;
        *)
            echo "Unknown shell ($SHELL). Add ~/.local/bin to your PATH manually."
            ;;
    esac
else
    echo "~/.local/bin is already in PATH."
fi

echo "Setup complete. Use 'promptr update' to pull changes and 'promptr link <target>' to create symlinks."
