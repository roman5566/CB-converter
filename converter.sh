#!/bin/bash

: '
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
 * ----------------------------------------------------------------------------
'

############ WALDORF - TESTING ############
#testing_url="http://packages.crunchbang.org/waldorf/pool/main/"

###########################################


############ STATLER - STABLE ############

## Packages from Debian Main Repo
stable_debian_pkgs="openbox obconf obmenu conky suckless-tools lxappearance nitrogen gmrun gdebi vlc thunar iceweasel xfce4-mixer geany lynx"

## Packages from Crunchbang Repo
ppc_url="http://file.libxenon.org/~tuxuser/crunchbang_ppc/"

## Not compatible with all architectures - but crunchbang specific!
#
# adobe-flash-plugin-32_11.01-crunchbang1.tar.gz
# adobe-flash-plugin-64_11.01-crunchbang1.tar.gz
# plymouth-dev_0.8.3-9.4~crunchbang_i386.deb
# plymouth-x11_0.8.3-9.4~crunchbang_i386.deb
# plymouth_0.8.3-9.4~crunchbang.tar.gz

##########################################

if [ $(whoami) = "root" ]
then
	if [ ! -f /etc/debian_version ]
	then
		echo "FATAL: Your system doesn't look like Debian/GNU - Aborting!"
		exit 0
	fi

	# Install base applications first!
	
	apt-get update
	echo "Installing base applications..."
	sleep 3
	apt-get install $stable_debian_pkgs -y --force-yes
	
	# Now download the crunchbang specific ones
	echo "Deleting cb_tmp folder!"
	rm -fR cb_tmp

	mkdir cb_tmp
	cd cb_tmp
	echo "[Downloading crunchbang-specific packages]"
	sleep 3
	lynx -dump $ppc_url | egrep -o "http:.*"| grep ".deb" > linklist
	wget -i linklist

	echo "[Installing crunchbang-specific packages]"
	sleep 3
	dpkg -i *.deb
	
	echo "[Fixing up dependencies]"
	sleep 3
	apt-get -f install

	# Finish
	cd ..
	echo "Conversion to crunchbang finished"
else
  echo "FATAL: You must be superuser to convert your debian system to a crunchbang-ish one - Aborting!"
  exit 0
fi
