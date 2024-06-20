# NeoVim Settings

My NeoVim settings.

## Setup

### Clone This Repository

Clole this repository to `~/.config/nvim`.

```
git clone https://github.com/SineStriker/nvim-settings.git ~/.config/nvim
```

### Initialize Plugins

#### 1. Install `vim-plug`

https://github.com/junegunn/vim-plug

Pull `vim-plug` script to the `autoload` directory.

#### 2. Install `lazy.nvim`

We have declared `lazy.nvim` in `lua/core/plug.lua`, so that we should run `PlugInstall` to install it.

```sh
:PlugInstall
```

#### 3. Restart NeoVim

We place the manifest of all plugins that need installing in `lua/plugins`, `lazy.nvim` will automatically install them.

#### 4. Install Completion Extensions

We install the completion extensions of `coc.nvim` by running `CocInstall`.

```sh
:CocInstall coc-json coc-xml coc-clangd coc-cmake
```