# nvim-config

Just your run-of-the-mill overcomplicated Neovim config. This config requires Neovim >= v0.12.0 (currently [nightly](https://github.com/neovim/neovim/releases/tag/nightly)). It is made with Windows in mind, but will probaly work on Unixes as well; see my [dotfiles](https://github.com/jtompkin/dotfiles) repo for my Linux config that doesn't require nightly (good luck with that).

## Usage

Clone this repo into `~/.config/nvim` or wherever else you freaks keep your configs:

```bash
git clone https://github.com/jtompkin/nvim-config ~/.config/nvim
```

Or extract it into your config folder if your dotfiles are part of a larger repo:

```bash
mkdir -p ~/.config/nvim
curl -L https://github.com/jtompkin/nvim-config/archive/refs/heads/main.tar.gz | tar xz --strip-components 1 -C ~/.config/nvim
```

If you are on Windows, keep in mind that many plugins expect a C compiler and general Linux tools to be present, which can be annoying to get because Windows. [MSYS2](https://www.msys2.org/) is a good option.

## External tools

Some external tools are needed for all plugins to work.

- C compiler - for several plugins probably
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) - for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main) (main branch)
- cargo (nightly) - used to build blink.cmp

## External libraries

Some external libraries are included in this configuration.

- [json.lua](https://github.com/rxi/json.lua) - for reading nvim-pack-lock.json (MIT license included in file header)
