<h1 align="center">GuilDotFiles</h1>

<div align="center">
  <img src="https://user-images.githubusercontent.com/871362/67146077-9bb93f80-f25d-11e9-9119-dbd83b6b4b62.png" />
  <p align="center"><i>WIP since 2012</i></p>
</div>

# Table of Contents
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Upgrading](#upgrading)
- [Support](#support)
- [Credit](#credit)
- [License](#license)

# Installation

To get started, run the following command:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/master/install.sh`"
```

# Dependencies

*Install iTerm Solarized Colors*
GDF will install Gruvbox colorschemes into your iTerm. Go to Profiles => Colors => Load Presets to pick Gruvbox Dark or Light.

*Install ripgrep*
Make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

# Upgrading

```
cd ~/.gdf
git pull --rebase
rake update
```

# What's included?

### VIM configuration
TODO
### ZSH with Prezto
TODO
### Homebrew installation
With tags, git and tmux.
### Bundler configuration
Configure Bundler to use `number_of_cores_available - 1` cores to install gems in parallel.
### Fonts
Roboto Mono.
### iTerm2 colorscheme
Gruvbox Dark and Gruvbox Light (setup not working!).
### Git configuration
GDF will take over your `~/.gitconfig`, so if you want to store your usernames, please put them into `~/.gitconfig.user`.

It is recommended to use this file to set your user info. Alternately, you can set the appropriate environment variables in your `~/.secrets`.

  * `git l` or `gl`- a much more usable git log
  * `git b` or `gb`- a list of branches with summary of last commit
  * `git r` - a list of remotes with info
  * `git t` or `gt`- a list of tags with info
  * `git nb` or `gnb`- a (n)ew (b)ranch - like checkout -b
  * `git cp` or `gcp`- cherry-pick -x (showing what was cherrypicked)
  * `git simple` - a clean format for creating changelogs
  * `git recent-branches` - if you forgot what you've been working on
  * `git unstage` / `guns` (remove from index) and `git uncommit` / `gunc` (revert to the time prior to the last commit - dangerous if already pushed) aliases
  * Some sensible default configs, such as improving merge messages, push only pushes the current branch, removing status hints, and using mnemonic prefixes in diff: (i)ndex, (w)ork tree, (c)ommit and (o)bject
  * Slightly improved colors for diff
  * `gdmb` (g)it (d)elete (m)erged (b)ranches - Deletes all branches already merged on current branch

# Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).

# Credit

This project is **heavily inspired** on [YADR](https://github.com/skwp/dotfiles).

# License

Copyright (c) 2018 Guilherme Pejon Licensed under the WTFPL license.
