#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

log() {
  printf '[bootstrap] %s\n' "$*"
}

has() {
  command -v "$1" >/dev/null 2>&1
}

install_brew_packages() {
  local packages=("$@")
  for pkg in "${packages[@]}"; do
    if brew list "$pkg" >/dev/null 2>&1; then
      log "brew package already installed: $pkg"
    else
      log "installing brew package: $pkg"
      brew install "$pkg"
    fi
  done
}

ensure_universal_ctags() {
  if brew list universal-ctags >/dev/null 2>&1; then
    log "brew package already installed: universal-ctags"
    return
  fi

  if brew list ctags >/dev/null 2>&1; then
    log "ctags formula is installed and conflicts with universal-ctags; unlinking ctags"
    brew unlink ctags || true
  fi

  log "installing brew package: universal-ctags"
  brew install universal-ctags
}

ensure_brew() {
  if has brew; then
    return
  fi

  log "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

link_config() {
  if [ -L "$TARGET_CONFIG_DIR" ]; then
    local current_target
    current_target="$(readlink "$TARGET_CONFIG_DIR")"
    if [ "$current_target" = "$SCRIPT_DIR" ]; then
      log "nvim config symlink already set: $TARGET_CONFIG_DIR -> $SCRIPT_DIR"
      return
    fi
  fi

  if [ -e "$TARGET_CONFIG_DIR" ] && [ ! -L "$TARGET_CONFIG_DIR" ]; then
    log "existing config found at $TARGET_CONFIG_DIR"
    log "move it aside manually, then rerun this script."
    exit 1
  fi

  mkdir -p "$(dirname "$TARGET_CONFIG_DIR")"
  rm -f "$TARGET_CONFIG_DIR"
  ln -s "$SCRIPT_DIR" "$TARGET_CONFIG_DIR"
  log "linked config: $TARGET_CONFIG_DIR -> $SCRIPT_DIR"
}

install_node_lsp() {
  if ! has npm; then
    log "npm not found; skipping TypeScript/Pyright LSP install"
    return
  fi
  log "installing npm language servers"
  npm install -g typescript typescript-language-server pyright
}

install_python_lsp() {
  if has pipx; then
    if pipx list | rg -q '^package python-lsp-server '; then
      log "python-lsp-server already installed via pipx"
    else
      log "installing python-lsp-server via pipx"
      pipx install "python-lsp-server[all]"
    fi
    return
  fi

  if has pip3; then
    log "pipx not found; installing python-lsp-server with pip3 --user"
    pip3 install --user "python-lsp-server[all]"
    return
  fi

  log "pip3 not found; skipping python-lsp-server install"
}

install_go_lsp() {
  if ! has go; then
    log "go not found; skipping gopls install"
    return
  fi

  log "installing gopls"
  go install golang.org/x/tools/gopls@latest
}

prime_nvim() {
  if ! has nvim; then
    log "nvim not found; skipping plugin initialization"
    return
  fi

  log "running Lazy sync in headless Neovim"
  nvim --headless "+Lazy! sync" +qa

  log "running treesitter update in headless Neovim"
  nvim --headless "+TSUpdateSync" +qa
}

main() {
  local os
  os="$(uname -s)"

  if [ "$os" != "Darwin" ]; then
    log "this script currently supports macOS only (detected: $os)"
    log "please install dependencies manually, then rerun on macOS or adapt script."
    exit 1
  fi

  ensure_brew

  install_brew_packages \
    neovim \
    git \
    ripgrep \
    fd \
    fzf \
    the_silver_searcher \
    tree-sitter \
    gcc \
    node \
    go \
    python \
    pipx \
    rust-analyzer

  ensure_universal_ctags

  link_config
  install_node_lsp
  install_python_lsp
  install_go_lsp
  prime_nvim

  log "done."
  log "if Go/Python user bins are not on PATH, add:"
  log "  export PATH=\"\$HOME/go/bin:\$HOME/.local/bin:\$PATH\""
}

main "$@"
