# My custom nvim setup

### Enabled plugins

| Plugin                          | Description                                    |
|---------------------------------|------------------------------------------------|
| `goolord/alpha-nvim`            | Welcome dashboard                              |
| `catppuccin/nvim`               | Color scheme                                   |
| `nvim-lualine/lualine.nvim`     | Status bar                                     |
| `nvim-neo-tree/neo-tree.nvim`   | Directory tree side bar, opened files side bar |
| `hrsh7th/nvim-cmp`              | Autocomplete                                   |
| `folke/persistence.nvim`        | Sessions persistence                           |
| `nvim-lua/plenary.nvim`         | Async utils (required by other plugins)        |
| `nvim-telescope/telescope.nvim` | Explorer utils (grep, find file)               |

### LSP support

1. cpp
2. cmake
3. lua
4. rust

### Env variables

Some configs can be set through overriding default env variable values.
Nvim will try to load env variables for the session from `<CWD>/.nvim/.env`

| Env variable               | Default Value | Description                                                      |
|----------------------------|---------------|------------------------------------------------------------------|
| `NVIM_CLANGD_BUILD_DIR`    | `build`       | A directory where clangd will search for `compile_commands.json` |
| `NVIM_CLANGD_CPP_STANDARD` | `-std=c++23`  | Cpp standard for clandg                                          |

### Use guide

```bash
$ git clone <repo>
$ cd ~/.config
$ ln -s <repo_root>/config nvim  # Create a sym link to config
```
