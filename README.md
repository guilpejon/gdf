<h1 align="center">Vim Setup</h1>

<div align="center">
  <strong>My personal VIM setup</strong>
</div>
<div align="center">
  Just copy and paste it and you're good to go
</div>

<br/>

## Table of Contents
- [Download](#download)
- [Installation](#installation)
- [Support](#support)

## Download

To start thinfgs off, make sure you already installed the latest version of VIM.

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

The current setup is using [vim-plug](https://github.com/junegunn/vim-plug).
To install the necessary plugins, you need to fire up VIM and use `:PlugInstall`.

Afterwards, exit VIM and open it again.
<br>
That's it, you're done!

## Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).
