# Neovim Config

This is a small Lazy.nvim based Neovim setup aimed at feeling like a practical IDE without hiding too much magic.

The config lives in this folder and is meant to be symlinked to:

```sh
~/.config/nvim
```

## What Is Included

- Lazy.nvim for plugin management
- Catppuccin as the color theme
- nvim-tree for a file explorer sidebar
- Telescope for finding files, buffers, help pages, and text in the repo
- Treesitter for better syntax highlighting and indentation
- Mason, mason-lspconfig, and nvim-lspconfig for language server setup
- nvim-cmp and LuaSnip for completion and snippets
- Trouble for a nicer diagnostics and quickfix list
- Gitsigns for Git change markers in the sign column
- Which-key for keybinding hints

## Language Support

The LSP setup currently installs and enables these servers through Mason:

- Go: `gopls`
- Python: `pyright`
- Bash: `bashls`
- PowerShell: `powershell_es`
- C and C++: `clangd`
- C#: `omnisharp`
- Groovy and Jenkinsfile: `groovyls`
- Kotlin and TeamCity Kotlin DSL: `kotlin_language_server`

Treesitter is configured for:

- Bash
- C
- C++
- C#
- Go
- Groovy
- JSON
- Kotlin
- Lua
- Python
- PowerShell
- Vimscript and Vim help
- YAML

Batch files are detected as `dosbatch`. They get normal Vim filetype support, but there is no strong LSP story for batch files in this setup.

## First Run

Open Neovim and run:

```vim
:Lazy sync
```

Then restart Neovim.

After that, these are useful checks:

```vim
:checkhealth
:Mason
:LspInfo
```

If Treesitter parsers need updating:

```vim
:TSUpdate
```

## Leader Key

The leader key is space:

```text
<leader> = Space
```

So `<leader>ff` means press `Space`, then `f`, then `f`.

## General Keybindings

| Key | What it does |
| --- | --- |
| `<leader>w` | Save the current file |
| `<leader>q` | Quit the current window |
| `<esc>` | Clear search highlighting |
| `[d` | Go to the previous diagnostic |
| `]d` | Go to the next diagnostic |
| `<leader>e` | Show diagnostics for the current line |

## File Explorer

| Key | What it does |
| --- | --- |
| `<leader>t` | Toggle the file tree sidebar |
| `<leader>f` | Reveal the current file in the tree |

## Telescope

| Key | What it does |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Search text in the project |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Search help tags |

## LSP Keybindings

These only become active after a language server attaches to the current buffer.

| Key | What it does |
| --- | --- |
| `gd` | Go to definition |
| `gr` | Find references |
| `gI` | Go to implementation |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Show code actions |
| `<leader>ds` | Show document symbols |
| `<leader>ws` | Search workspace symbols |
| `<leader>lf` | Format the current file |

## Completion Keybindings

These work while completion is open in insert mode.

| Key | What it does |
| --- | --- |
| `<c-space>` | Open completion manually |
| `<cr>` | Confirm the selected completion item |
| `<tab>` | Select the next completion item or jump through a snippet |
| `<s-tab>` | Select the previous completion item or jump backward in a snippet |
| `<c-b>` | Scroll completion docs up |
| `<c-f>` | Scroll completion docs down |

## Diagnostics Lists

| Key | What it does |
| --- | --- |
| `<leader>xx` | Toggle Trouble diagnostics |
| `<leader>xq` | Toggle Trouble quickfix list |

## Notes

- C and C++ projects work best when they provide `compile_commands.json`.
- TeamCity Kotlin DSL gets Kotlin language support. Rich project-specific completion depends on the project having the right Kotlin and TeamCity DSL dependencies available.
- PowerShell LSP expects PowerShell Editor Services from Mason and usually needs `pwsh` available on the system.
- Jenkinsfile is treated as Groovy.
