<h1 align="center">GuilDotFiles</h1>

<div align="center">
  <img src="https://user-images.githubusercontent.com/871362/67146077-9bb93f80-f25d-11e9-9119-dbd83b6b4b62.png" />
  <p align="center"><i>WIP since 2012</i></p>
</div>

## Table of Contents
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Upgrading](#upgrading)
- [Support](#support)
- [Credit](#credit)
- [License](#license)

## Installation

To get started, run the following command:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/master/install.sh`"
```

## Dependencies

*Install iTerm Solarized Colors*
GDF will install Gruvbox colorschemes into your iTerm. Go to Profiles => Colors => Load Presets to pick Gruvbox Dark or Light.

*Install ripgrep*
Make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

## Upgrading

```
cd ~/.gdf
git pull --rebase
rake update
```

## What's included?

### VIM
* TODO
### Homebrew
* With zsh, tags, git and tmux
### Bundler
* Configure Bundler to use `number_of_cores_available - 1` cores to install gems in parallel
### Fonts
* Roboto Mono
### iTerm2 colorscheme
* Gruvbox (setup not working!)

## Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).

## Credit

This project is **heavily inspired** on [YADR](https://github.com/skwp/dotfiles).

## License

Copyright (c) 2018 Guilherme Pejon Licensed under the WTFPL license.
