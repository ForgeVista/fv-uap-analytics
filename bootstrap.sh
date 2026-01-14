#!/usr/bin/env bash
# fv-uap-analytics bootstrap
# Pattern: Check -> Install if missing -> Don't conflict

set -euo pipefail

APP_NAME="ForgeVista UAP Analytics"

log() { printf '%s\n' "$*"; }
fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }

command_exists() { command -v "$1" >/dev/null 2>&1; }

os_name() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux) echo "linux" ;;
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    *) echo "unknown" ;;
  esac
}

need_sudo() {
  if command_exists sudo; then
    echo "sudo"
  else
    echo ""
  fi
}

install_git() {
  local os="$(os_name)"
  local sudo_cmd
  sudo_cmd="$(need_sudo)"
  log "Installing Git..."
  case "$os" in
    macos)
      if command_exists brew; then
        brew install git
      else
        fail "Homebrew not found. Install Git from https://git-scm.com/downloads or install Homebrew first."
      fi
      ;;
    linux)
      if command_exists apt-get; then
        $sudo_cmd apt-get update
        $sudo_cmd apt-get install -y git
      elif command_exists dnf; then
        $sudo_cmd dnf install -y git
      elif command_exists pacman; then
        $sudo_cmd pacman -S --noconfirm git
      else
        fail "Unsupported Linux package manager. Install Git from https://git-scm.com/downloads."
      fi
      ;;
    windows)
      fail "On Windows, use WSL or install Git from https://git-scm.com/downloads."
      ;;
    *)
      fail "Unknown OS. Install Git manually from https://git-scm.com/downloads."
      ;;
  esac
}

install_node() {
  local os="$(os_name)"
  local sudo_cmd
  sudo_cmd="$(need_sudo)"
  log "Installing Node.js (16+)..."
  case "$os" in
    macos)
      if command_exists brew; then
        brew install node
      else
        fail "Homebrew not found. Install Node.js from https://nodejs.org/en/download or install Homebrew first."
      fi
      ;;
    linux)
      if command_exists apt-get; then
        $sudo_cmd apt-get update
        $sudo_cmd apt-get install -y nodejs npm
      elif command_exists dnf; then
        $sudo_cmd dnf install -y nodejs npm
      elif command_exists pacman; then
        $sudo_cmd pacman -S --noconfirm nodejs npm
      else
        fail "Unsupported Linux package manager. Install Node.js from https://nodejs.org/en/download."
      fi
      ;;
    windows)
      fail "On Windows, use WSL or install Node.js from https://nodejs.org/en/download."
      ;;
    *)
      fail "Unknown OS. Install Node.js manually from https://nodejs.org/en/download."
      ;;
  esac
}

install_duckdb() {
  local os="$(os_name)"
  local sudo_cmd
  sudo_cmd="$(need_sudo)"
  log "Installing DuckDB CLI..."
  case "$os" in
    macos)
      if command_exists brew; then
        brew install duckdb
      else
        fail "Homebrew not found. Install DuckDB CLI from https://duckdb.org/docs/installation/cli."
      fi
      ;;
    linux)
      if command_exists apt-get; then
        $sudo_cmd apt-get update
        $sudo_cmd apt-get install -y duckdb || true
      elif command_exists dnf; then
        $sudo_cmd dnf install -y duckdb || true
      elif command_exists pacman; then
        $sudo_cmd pacman -S --noconfirm duckdb || true
      else
        log "Unsupported Linux package manager."
      fi
      if ! command_exists duckdb; then
        fail "DuckDB CLI not installed. Download from https://duckdb.org/docs/installation/cli."
      fi
      ;;
    windows)
      fail "On Windows, use WSL or install DuckDB CLI from https://duckdb.org/docs/installation/cli."
      ;;
    *)
      fail "Unknown OS. Install DuckDB CLI from https://duckdb.org/docs/installation/cli."
      ;;
  esac
}

check_git() {
  if command_exists git; then
    log "✓ Git found ($(git --version))"
  else
    log "✗ Git not found"
    install_git
    log "✓ Git installed"
  fi
}

check_node() {
  if command_exists node; then
    local version major
    version="$(node -v | sed 's/^v//')"
    major="${version%%.*}"
    if [ "$major" -lt 16 ]; then
      fail "Node.js 16+ required, found v$version. Please upgrade from https://nodejs.org/en/download."
    fi
    log "✓ Node.js v$version found"
  else
    log "✗ Node.js not found"
    install_node
    log "✓ Node.js installed"
  fi

  if command_exists npm; then
    log "✓ npm found ($(npm -v))"
  else
    fail "npm not found. Reinstall Node.js from https://nodejs.org/en/download."
  fi
}

check_duckdb() {
  if command_exists duckdb; then
    log "✓ DuckDB CLI found ($(duckdb --version))"
  else
    log "✗ DuckDB CLI not found"
    install_duckdb
    log "✓ DuckDB CLI installed"
  fi
}

check_evidence() {
  if npm list -g @evidence-dev/evidence --depth=0 >/dev/null 2>&1; then
    local installed
    installed="$(npm list -g @evidence-dev/evidence --depth=0 | grep @evidence-dev/evidence || true)"
    log "✓ Evidence.dev installed ($installed)"
  else
    log "✗ Evidence.dev not found"
    log "Installing Evidence.dev globally (no sudo)..."
    npm install -g @evidence-dev/evidence
    log "✓ Evidence.dev installed"
  fi
}

main() {
  log "=== $APP_NAME Bootstrap ==="
  log "Setting up DuckDB + Evidence.dev..."
  log ""

  check_git
  check_node
  check_duckdb
  check_evidence

  log ""
  log "=== Setup Complete ==="
  log "Next steps:"
  log "1) Run 'evidence dev' to start your dashboard"
  log "2) See README.md for data connection and dashboard tips"
}

main "$@"
