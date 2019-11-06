#!/bin/sh

if [ ! -d "$HOME/.gdf" ]; then
    echo "Installing GDF for the first time"
    git clone --depth=1 https://github.com/guilpejon/dotfiles.git "$HOME/.gdf"
    # cp -R "$HOME/codes/gdf" "$HOME/.gdf"
    cd "$HOME/.gdf"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "GDR is already installed"
fi
