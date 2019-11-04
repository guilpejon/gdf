<h1 align="center">Guil DotFiles</h1>

<div align="center">
  WIP since 2012
</div>
<br/>

<div align="center">
  <img src="https://user-images.githubusercontent.com/871362/67146077-9bb93f80-f25d-11e9-9119-dbd83b6b4b62.png" />
  <p align="center"><i>Isn't it pretty?</i></p>
</div>

## Table of Contents
- [Download](#download)
- [Installation](#installation)
- [Support](#support)

## Download

To start things off, make sure you already installed the latest version of VIM.

If you don't wanna lose your current setup, make sure you create a backup of your current `~/.vim` folder.

```
mkdir ~/Desktop/vim_setup_backup
mv ~/.vim/* ~/Desktop/vim_setup_backup
```

If you don't care about your current setup, just type `rm -rf ~/.vim/*`.

Then, just copy and paste the code below.

```
git clone git@github.com:guilpejon/vim-setup.git ~/.vim
```

## Installation

First, make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.


To install the plugins, along with the rest of its dependencies, you need to fire up VIM and use the `:PlugInstall` command.

You need to install **Hack Nerd Font** and set it in your terminal in order for [vim-devicons](https://github.com/ryanoasis/vim-devicons) to work. You can follow one of the options listed [here](https://github.com/ryanoasis/nerd-fonts#font-installation) to install it. I recommend using **Option 3** from the installation options list.

## Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).

## License

Copyright (c) 2018 Guilherme Pejon Licensed under the WTFPL license.
