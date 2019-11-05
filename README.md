<h1 align="center">GuilDotFiles</h1>

<div align="center">
  WIP since 2012
</div>
<br/>

<div align="center">
  <img src="https://user-images.githubusercontent.com/871362/67146077-9bb93f80-f25d-11e9-9119-dbd83b6b4b62.png" />
  <p align="center"><i>Isn't it pretty?</i></p>
</div>

## Table of Contents
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Upgrading](#upgrading)
- [Support](#support)
- [License](#license)

## Installation

To get started, run the following command:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilpejon/gdf/master/install.sh`"
```

## Dependencies

Make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

You need to install **Hack Nerd Font** and set it in your terminal in order for [vim-devicons](https://github.com/ryanoasis/vim-devicons) to work. You can follow one of the options listed [here](https://github.com/ryanoasis/nerd-fonts#font-installation) to install it. I recommend using **Option 3** from the installation options list.

## Upgrading

```
cd ~/.gdf
git pull --rebase
rake update
```

## What's included?

### VIM
* TODO
### Bundler
* Configure Bundler to use `number_of_cores_available - 1` cores to install gems in parallel

## Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).

## License

Copyright (c) 2018 Guilherme Pejon Licensed under the WTFPL license.
