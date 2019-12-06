#!/bin/bash

if
  [[ "${USER:-}" == "root" ]]
then
  echo "This script works only with normal user, it wont work with root, please log in as normal user and try again." >&2
  exit 1
fi

set -e

echo "Updates packages. Asks for your password."
sudo apt-get update -y

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

echo "Installs Node"
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt install nodejs -y

echo "Instal vim-gtk for xclipboard support"
sudo apt-get install vim-gtk -y

echo "Installs Git"
sudo apt-get install git -y

echo "Installs ImageMagick for image processing"
sudo apt-get install imagemagick --fix-missing -y

echo "Installs redis"
sudo apt-get install redis-server -y
sudo systemctl enable redis-server.service

echo "Installs packages"
sudo apt-get --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev libffi-dev software-properties-common libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev libc6-dev -y

echo "Install snap"
sudo apt install snapd

echo "Install heroku CLI"
sudo snap install --classic heroku

echo "Cleaning up"
sudo apt autoremove

echo "Install solargraph"
gem install solargraph
