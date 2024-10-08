
# frozen.nvim

This is a slimmer version of [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that gets rid of Mason installer. It currently only supports python and c languages.

I also removed all the packages I don't need (e.g. statusline), added a couple of (very subjectively) awesome, and introduced a set of (very custom) hotkeys.

The name is "Frozen" because all commit versions of all packages are fixed via `lazy-lock.json`. Since there are no additional installers this makes config reproducable.

Also 'zen' indicates that it starts in zen mode by default (no statusline, no line numbers, no file explorers etc), which is awesome since we don't need any separate packages for this.

Probably shouldn't be used by anyone.

## Requirements

System utils: git, make, gcc, unzip

Neovim and tools:
- [nvim==0.10.0](https://github.com/neovim/neovim/releases/tag/v0.10.0)
- [ripgrep==14.1.0](https://github.com/BurntSushi/ripgrep/releases/tag/14.1.0)
- [fd==10.1.0](https://github.com/sharkdp/fd/releases/tag/v10.1.0)

A bunch of python libraries: 
- `pyright` for autocompletion and static type checking
- `ruff` for linting and autoformat
- `debugpy` for debugging

Note that support for every language should be handled manually since we dont use Mason. For python simply installing for libs above works ok, but beware that I don't know anything about other languages. This config may be unusable for them.

## Installation

Install dependencies: `pip install pyright ruff debugpy`

Delete previous configs (cache them if you need): `rm -rf ~/.cache/nvim ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim`

`git clone https://github.com/JanRocketMan/frozen.nvim.git ~/.config/nvim`
