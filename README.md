# Dotfiles

Device-agnostic Fedora and Fedora-on-WSL dotfiles for zsh, tmux, Neovim, and Ghostty.

## Setup

Run this from the repo root on Fedora:

```sh
./setup.sh
```

The setup script installs common CLI dependencies with `dnf`, symlinks the configs, switches the default shell to zsh, and skips desktop-only Ghostty/GNOME steps when it detects WSL.

## Theme And Keys

- Theme: Catppuccin Macchiato across Ghostty, tmux, and Neovim.
- Shell editing: vi mode, with familiar `Ctrl+a/e/p/n` line movement/history.
- Pane/window movement: `Ctrl+h/j/k/l` in tmux and Neovim.
- tmux prefix: `Ctrl+a`.

tmux starts by default for interactive shells. Disable it for a local shell profile with:

```sh
export DOTFILES_AUTO_TMUX=0
```
