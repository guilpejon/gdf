set -e

echo "Installs RVM (Ruby Version Manager) for handling Ruby installation"
curl -kL get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
