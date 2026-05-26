#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
IS_WSL=0
SUDO=()

if grep -qi microsoft /proc/version 2>/dev/null; then
  IS_WSL=1
fi

info() {
  printf '\033[1;34m==>\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33mwarn:\033[0m %s\n' "$*" >&2
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

if [ "${EUID:-$(id -u)}" -ne 0 ]; then
  if need_cmd sudo; then
    SUDO=(sudo)
  else
    warn "sudo was not found; package install and shell changes may fail."
  fi
fi

install_fedora_packages() {
  if ! need_cmd dnf; then
    warn "dnf was not found; skipping package install."
    return
  fi

  local packages=(
    zsh
    tmux
    neovim
    git
    curl
    unzip
    tar
    util-linux-user
    fzf
    zoxide
    ripgrep
    fd-find
    ShellCheck
    wl-clipboard
    xclip
    gcc
    gcc-c++
    make
    cmake
    clang
    clang-tools-extra
    java-latest-openjdk
    python3
    python3-pip
    nodejs
    npm
    golang
    jetbrains-mono-fonts-all
  )

  if [ "$IS_WSL" -eq 0 ]; then
    packages+=(
      gnome-tweaks
    )

    if dnf list --available ghostty >/dev/null 2>&1; then
      packages+=(ghostty)
    else
      warn "ghostty is not available in enabled dnf repos; install it separately if needed."
    fi
  fi

  info "Installing Fedora packages"
  "${SUDO[@]}" dnf install -y "${packages[@]}"
}

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    warn "Backing up $target to $backup"
    mv "$target" "$backup"
  fi

  ln -s "$source" "$target"
}

link_configs() {
  info "Linking dotfiles"
  link_file "$ROOT_DIR/zsh/.zshrc" "$HOME/.zshrc"
  link_file "$ROOT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
  link_file "$ROOT_DIR/nvim" "$CONFIG_HOME/nvim"

  if [ "$IS_WSL" -eq 0 ]; then
    link_file "$ROOT_DIR/ghostty/config.ghostty" "$CONFIG_HOME/ghostty/config"
    mkdir -p "$CONFIG_HOME/ghostty/themes"
    link_file "$ROOT_DIR/ghostty/themes/catppuccin-macchiato.conf" "$CONFIG_HOME/ghostty/themes/catppuccin-macchiato.conf"
  fi
}

set_default_shell() {
  if ! need_cmd zsh; then
    return
  fi

  local zsh_path
  zsh_path="$(command -v zsh)"

  if [ "${SHELL:-}" = "$zsh_path" ]; then
    return
  fi

  if ! grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
    info "Adding $zsh_path to /etc/shells"
    printf '%s\n' "$zsh_path" | "${SUDO[@]}" tee -a /etc/shells >/dev/null
  fi

  info "Changing default shell to zsh"
  chsh -s "$zsh_path"
}

configure_gnome() {
  if [ "$IS_WSL" -eq 1 ] || ! need_cmd gsettings; then
    return
  fi

  info "Applying GNOME keyboard preferences"
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']" || true
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' || true
}

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"

  if [ -d "$tpm_dir/.git" ]; then
    return
  fi

  if ! need_cmd git; then
    warn "git is missing; cannot install tmux plugin manager."
    return
  fi

  info "Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

main() {
  install_fedora_packages
  link_configs
  set_default_shell
  configure_gnome
  install_tpm

  info "Done. Restart the terminal, then open tmux and press prefix + I to install tmux plugins."
}

main "$@"
