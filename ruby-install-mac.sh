set -e

echo "Installs Homebrew for installing other software"
/usr/bin/ruby -e "$(/usr/bin/curl -fsSkL raw.github.com/mxcl/homebrew/go)"

echo "Installs Git"
brew install git

echo "Updates Homebrew"
brew update

echo "Installs imagemagick"
brew install imagemagick

echo "Installs postgres"
brew install postgres

echo "Install node"
brew install node

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
curl -kL get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
