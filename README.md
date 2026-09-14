# My Dev Setup

Various configs I personally use in my dev environments.

## Nvim

### Enabled plugins

| Plugin                          | Description                                    |
|---------------------------------|------------------------------------------------|
| `goolord/alpha-nvim`            | Welcome dashboard                              |
| `catppuccin/nvim`               | Color scheme (Disabled)                        |
| `nvim-lualine/lualine.nvim`     | Status bar                                     |
| `nvim-neo-tree/neo-tree.nvim`   | Directory tree side bar, opened files side bar |
| `hrsh7th/nvim-cmp`              | Autocomplete                                   |
| `folke/persistence.nvim`        | Sessions persistence                           |
| `nvim-lua/plenary.nvim`         | Async utils (required by other plugins)        |
| `nvim-telescope/telescope.nvim` | Explorer utils (grep, find file)               |
| `folke/tokyonight.nvim`         | Color scheme (Enabled)                         |
| `nvim-treesitter/nvim-treesitter` | Syntax tree parser                           |
| `nickjvandyke/opencode.nvim`     | OpenCode AI assistant integration            |

### LSP support

1. cpp
2. cmake
3. lua
4. rust
5. c3

**Notes:**

C3 LSP is built from source: https://github.com/tonis2/lsp.git. Built binary should be placed under $PATH and aliased as `c3-lsp`.

### Env variables

Some configs can be set through overriding default env variable values.
Nvim will try to load env variables for the session from `<CWD>/.nvim/.env`

| Env variable               | Default Value | Description                                                      |
|----------------------------|---------------|------------------------------------------------------------------|
| `NVIM_CLANGD_BUILD_DIR`    | `build`       | A directory where clangd will search for `compile_commands.json` |
| `NVIM_CLANGD_CPP_STANDARD` | `-std=c++23`  | Cpp standard for clangd                                          |

### Use guide

```bash
$ git clone <repo>
$ cd ~/.config
$ ln -s <repo_root>/nvim nvim  # Create a sym link to config
```

## Opencode

### General config

General example `opencode.json` config with default permissions.

### Themes

Custom definition for `tokyonight-moon` color scheme.
`tui.json` config with `tokyonight-moon` as default color scheme.

### Use guide

Copy necessary configs into `~/.config/opencode`.
Note that some configs might require manual update based on environment (e.g. providers).
