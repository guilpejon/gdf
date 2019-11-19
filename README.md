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

To get started, make sure you have [curl](https://github.com/curl/curl) installed and run the following command to install all GDF's subcomponents:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/master/install.sh`"
```

If you want to be asked about whether or not to install each subcomponents, you can use:

```
sh -c "`curl -fsSL https://raw.githubusercontent.com/guilpejon/dotfiles/master/install.sh`" -s ask
```

# Upgrading

```
cd ~/.gdf
git pull --rebase
rake update
```

# What's included?

## Applications
Git, RVM, ruby, zsh, oh my zsh (w/ spaceship theme and zplugin), tags, git, tmux, ripgrep, postgres, nodejs and imagemagick.

### Linux
Terminator.

### Mac
Homebrew and iterm2.

## Font
Roboto Mono.

# Configurations
## VIM
```ruby
  Shift + K # search for word under the cursor

  #TODO, continue
```
## ZSH/Oh My Zsh/Zplugin
```ruby
  #TODO, start
```
## Bundler
Configure Bundler to use `number_of_cores_available - 1` cores to install gems in parallel.
## iTerm2 colorscheme
GDF will install Gruvbox Dark and Gruvbox Light iterm colorschemes.

Go to Profiles => Colors => Load Presets to pick one of them.
## Git
### Aliases

```ruby
  # add
  a = add                           # add
  chunkyadd = add --patch           # stage commits chunk by chunk

  # via http://blog.apiaxle.com/post/handy-git-tips-to-stop-you-getting-fired/
  snapshot = !git stash save "snapshot: $(date)" && git stash apply "stash@{0}"
  snapshots = !git stash list --grep snapshot

  #via http://stackoverflow.com/questions/5188320/how-can-i-get-a-list-of-git-branches-ordered-by-most-recent-commit
  recent-branches = !git for-each-ref --count=15 --sort=-committerdate refs/heads/ --format='%(refname:short)'

  # branch
  b = branch -v                     # branch (verbose)

  # commit
  c = commit -m                     # commit with message
  ca = commit -am                   # commit all with message
  ci = commit                       # commit
  amend = commit --amend            # ammend your last commit
  ammend = commit --amend           # ammend your last commit

  # checkout
  co = checkout                     # checkout
  nb = checkout -b                  # create and switch to a new branch (mnemonic: "git new branch branchname...")

  # cherry-pick
  cp = cherry-pick -x               # grab a change from a branch

  # diff
  d = diff                          # diff unstaged changes
  dc = diff --cached                # diff staged changes
  last = diff HEAD^                 # diff last committed change

  # log
  l = log --graph --date=short
  changes = log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status
  short = log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\"
  simple = log --pretty=format:\" * %s\"
  shortnocolor = log --pretty=format:\"%h %cr %cn %s\"

  # pull
  pl = pull                         # pull

  # push
  ps = push                         # push

  # rebase
  rc = rebase --continue            # continue rebase
  rs = rebase --skip                # skip rebase

  # remote
  r = remote -v                     # show remotes (verbose)

  # reset
  unstage = reset HEAD              # remove files from index (tracking)
  uncommit = reset --soft HEAD^     # go back before last commit, with files in uncommitted state
  filelog = log -u                  # show changes to a file
  mt = mergetool                    # fire up the merge tool

  # stash
  ss = stash                        # stash changes
  sl = stash list                   # list stashes
  sa = stash apply                  # apply stash (restore changes)
  sd = stash drop                   # drop stashes (destory changes)

  # status
  s = status                        # status
  st = status                       # status
  stat = status                     # status

  # tag
  t = tag -n                        # show tags with <n> lines of each tag message

  # svn helpers
  svnr = svn rebase
  svnd = svn dcommit
  svnl = svn log --oneline --show-commit
```
## Other configurations
**IRB**, **Pry**, **Gemrc**, **ctags** and **tmux**.

# Support

If you find any problems or bugs, please open a new [issue](https://github.com/guilpejon/vim-setup/issues).

# Credit

This project is **heavily inspired** on [YADR](https://github.com/skwp/dotfiles).

# License

Copyright (c) 2018 Guilherme Pejon Licensed under the WTFPL license.
