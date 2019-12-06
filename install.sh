#!/bin/bash

os_name="$(uname -s)"

# check if a program is installed
command_exists()
{
  command -v "$1" >/dev/null 2>&1
}

# install ruby and all its dependencies
ruby_installation()
{
  case "${os_name}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    *)          machine="UNKNOWN:${os_name}"
  esac
  if ! command_exists rvm; then
    echo "Ruby not installed. Installing it with RVM"
    if [ "${machine}" = "linux" ]; then
      ./ruby-install-ubuntu.sh
    elif [ "${machine}" = "mac" ]; then
      ./ruby-install-mac.sh
    else
      echo "System not yet supported"
    fi
  else
    echo "Ruby already installed"
  fi
}

#---------------------------------------------------------------------------------------------------
# Menu system starts here
# Display main menu
mainmenu_selection=$(whiptail --title "Main Menu" --menu --notags \
	"" 20 78 12 -- \
	"full" "Full Installation" \
	"ruby" "Install Ruby w/ RVM and its dependencies" \
	"docker" "Install Docker" \
	"misc" "Miscellaneous commands" \
	"update" "Update GDF" \
	3>&1 1>&2 2>&3)

case $mainmenu_selection in
#FULL INSTALLATION -------------------------------------------------------------------
"full")
  [ "$1" = "ask" ] && export ASK="true"
  if ! command_exists git; then
    sudo apt-get install git -y
  fi
  if [ ! -d "$HOME/.gdf" ]; then
    echo "Installing GDF for the first time"
    if ! command_exists git; then
      sudo apt-get install git -y
    fi
    git clone --depth=1 https://github.com/guilpejon/dotfiles.git "$HOME/.gdf"
    # cp -R "$HOME/codes/gdf" "$HOME/.gdf"
    cd "$HOME/.gdf"
    if ! command_exists rake; then
      ruby_installation
    fi
    rake install
  else
    echo "GDF is already installed"
    cd "$HOME/.gdf"
    if ! command_exists rake; then
      ruby_installation
    fi
    rake install
  fi
	;;
#RUBY Install ------------------------------------------------------------------------
"ruby")
  ruby_installation
	;;
#MAINMENU Install docker  ------------------------------------------------------------
"docker")
	#sudo apt update && sudo apt upgrade -y ;;

	if command_exists docker; then
		echo "docker already installed"
	else
		echo "Install Docker"
		curl -fsSL https://get.docker.com | sh
		sudo usermod -aG docker $USER
	fi

	if command_exists docker-compose; then
		echo "docker-compose already installed"
	else
		echo "Install docker-compose"
		sudo apt install -y docker-compose
	fi

	if (whiptail --title "Restart Required" --yesno "It is recommended that you restart you device now. Select yes to do so now" 20 78); then
		sudo reboot
	fi
	;;
#MAINMENU Misc commands------------------------------------------------------------
"misc")
	misc_sellection=$(whiptail --title "Miscellaneous Commands" --menu --notags \
		"Some helpful commands" 20 78 12 -- \
		"swap" "Disable swap" \
		"log2ram" "install log2ram to decrease load on sd card, moves /var/log into ram" \
		3>&1 1>&2 2>&3)

	case $misc_sellection in
	"swap")
		sudo dphys-swapfile swapoff
		sudo dphys-swapfile uninstall
		sudo update-rc.d dphys-swapfile remove
		sudo systemctl disable dphys-swapfile
		#sudo apt-get remove dphys-swapfile
		echo "Swap file has been removed"
		;;
	"log2ram")
		if [ ! -d ~/log2ram ]; then
			git clone https://github.com/azlux/log2ram.git ~/log2ram
			chmod +x ~/log2ram/install.sh
			pushd ~/log2ram && sudo ./install.sh
			popd
		else
			echo "log2ram already installed"
		fi
		;;
	esac
	;;
"update")
	echo "Pulling latest project file from Github.com ---------------------------------------------"
	git pull origin master
	echo "git status ------------------------------------------------------------------------------"
	git status
	;;
*) ;;

esac

# popd



