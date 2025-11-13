# My custom nvim setup

***[UNDER CONSTRUCTION]***

### Project structure
```
root
|`- config        // Global nvim config 
 `- project_setup // A collection of default project setups
```

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

