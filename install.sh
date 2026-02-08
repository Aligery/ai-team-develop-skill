#!/usr/bin/env bash
set -euo pipefail

# /team-develop skill installer
# Supports: Claude Code, OpenCode

SKILL_NAME="team-develop"
REPO_URL="https://github.com/anthropics/team-develop-skill.git"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()    { echo -e "${BLUE}[info]${NC} $*"; }
success() { echo -e "${GREEN}[ok]${NC} $*"; }
warn()    { echo -e "${YELLOW}[warn]${NC} $*"; }
error()   { echo -e "${RED}[error]${NC} $*" >&2; }

# Determine source directory (where skill files live)
resolve_source_dir() {
    # If running from a cloned repo, use local files
    if [[ -f "${SCRIPT_DIR}/skills/${SKILL_NAME}/SKILL.md" ]]; then
        SOURCE_DIR="${SCRIPT_DIR}"
    else
        # Download to temp directory
        info "Cloning repository..."
        SOURCE_DIR=$(mktemp -d)
        git clone --depth 1 --quiet "${REPO_URL}" "${SOURCE_DIR}"
        CLEANUP_DIR="${SOURCE_DIR}"
    fi
}

cleanup() {
    if [[ -n "${CLEANUP_DIR:-}" && -d "${CLEANUP_DIR}" ]]; then
        rm -rf "${CLEANUP_DIR}"
    fi
}
trap cleanup EXIT

# ── Install functions ──────────────────────────────────────────────

install_skill_files() {
    local target="$HOME/.claude/skills/${SKILL_NAME}"
    mkdir -p "$target"
    cp -r "${SOURCE_DIR}/skills/${SKILL_NAME}/"* "$target/"
    success "Skill files -> $target"
}

install_claude_command() {
    local target="$HOME/.claude/commands"
    mkdir -p "$target"
    cp "${SOURCE_DIR}/commands/${SKILL_NAME}.md" "$target/${SKILL_NAME}.md"
    success "Claude Code command -> $target/${SKILL_NAME}.md"
}

install_opencode_command() {
    local target="$HOME/.config/opencode/commands"
    mkdir -p "$target"
    cp "${SOURCE_DIR}/commands/${SKILL_NAME}.md" "$target/${SKILL_NAME}.md"
    success "OpenCode command -> $target/${SKILL_NAME}.md"
}

# ── Uninstall functions ────────────────────────────────────────────

uninstall() {
    info "Uninstalling ${SKILL_NAME}..."

    local removed=0

    if [[ -d "$HOME/.claude/skills/${SKILL_NAME}" ]]; then
        rm -rf "$HOME/.claude/skills/${SKILL_NAME}"
        success "Removed skill files from ~/.claude/skills/${SKILL_NAME}"
        ((removed++))
    fi

    if [[ -f "$HOME/.claude/commands/${SKILL_NAME}.md" ]]; then
        rm -f "$HOME/.claude/commands/${SKILL_NAME}.md"
        success "Removed Claude Code command"
        ((removed++))
    fi

    if [[ -f "$HOME/.config/opencode/commands/${SKILL_NAME}.md" ]]; then
        rm -f "$HOME/.config/opencode/commands/${SKILL_NAME}.md"
        success "Removed OpenCode command"
        ((removed++))
    fi

    if [[ $removed -eq 0 ]]; then
        warn "Nothing to uninstall — skill not found"
    else
        success "Uninstall complete"
    fi
}

# ── Main ───────────────────────────────────────────────────────────

usage() {
    cat <<EOF
Usage: install.sh [OPTIONS]

Install the /team-develop skill for Claude Code and/or OpenCode.

Options:
  --claude       Install for Claude Code only
  --opencode     Install for OpenCode only
  --uninstall    Remove the skill from all platforms
  -h, --help     Show this help message

Without options, installs for both Claude Code and OpenCode.
EOF
}

main() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    CLEANUP_DIR=""

    local install_claude=false
    local install_opencode=false
    local do_uninstall=false
    local explicit=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --claude)    install_claude=true; explicit=true; shift ;;
            --opencode)  install_opencode=true; explicit=true; shift ;;
            --uninstall) do_uninstall=true; shift ;;
            -h|--help)   usage; exit 0 ;;
            *)           error "Unknown option: $1"; usage; exit 1 ;;
        esac
    done

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  /team-develop skill installer${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # Uninstall mode
    if [[ "$do_uninstall" == true ]]; then
        uninstall
        exit 0
    fi

    # Default: install for both
    if [[ "$explicit" == false ]]; then
        install_claude=true
        install_opencode=true
    fi

    resolve_source_dir

    # Verify source files exist
    if [[ ! -f "${SOURCE_DIR}/skills/${SKILL_NAME}/SKILL.md" ]]; then
        error "Skill files not found in ${SOURCE_DIR}"
        exit 1
    fi

    # Skill files go to ~/.claude/skills/ (shared by both platforms)
    info "Installing skill files..."
    install_skill_files

    # Platform-specific commands
    if [[ "$install_claude" == true ]]; then
        info "Installing Claude Code command..."
        install_claude_command
    fi

    if [[ "$install_opencode" == true ]]; then
        info "Installing OpenCode command..."
        install_opencode_command
    fi

    echo ""
    success "Installation complete!"
    echo ""
    echo "  Start a new session and type: /team-develop"
    echo ""
}

main "$@"
