# My custom nvim setup

***[UNDER CONSTRUCTION]***

### Project structure
```
root
|`- config        // Global nvim config 
 `- project_setup // A collection of default project setups
```

### Configuration

1. Directory tree view (neo-tree plugin)
2. LSP support for cpp, lua (more to go)
3. Custom project setups (see the [use guide](#how-to-use))

### How to use

1. Clone repo
2. Copy `config` content into `~/.config/nvim`
```bash
$ cd <repo_root>
$ cp -r config/* ~/.config/nvim
```
3. Copy project setup into your project directory
```bash
$ mkdir -p <your_project_root>/.nvim
$ cp project_setup/<project_type>/setup.lua <your_project_root>/.nvim
```
4. Modify copied `setup.lua` to fit your needs
5. Run nvim from your project root. The setup will be loaded automatically.
A welcome floating window will be displayed on nvim open showing available custom key bindings

### Available project setups

* cpp

