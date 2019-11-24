#!/bin/sh

if [ ! -d "$HOME/.gdf" ]; then
  unameOut="$(uname -s)"
  case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    *)          machine="UNKNOWN:${unameOut}"
  esac
  if ! [ -x "$(command -v rvm)" ]; then
    echo "Ruby not installed. Installing it with RVM"
    if [ "${machine}" = "linux" ]; then
      ./ruby-install-ubuntu.sh
    elif [ "${machine}" = "mac" ]; then
      ./ruby-install-mac.sh
    fi
  else
    echo "Ruby already installed"
  fi

  echo "Installing GDF for the first time"
  git clone --depth=1 https://github.com/guilpejon/dotfiles.git "$HOME/.gdf"
  # cp -R "$HOME/codes/gdf" "$HOME/.gdf"
  cd "$HOME/.gdf"
  [ "$1" = "ask" ] && export ASK="true"

  rake install
else
  echo "GDR is already installed"
fi
