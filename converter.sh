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

testing_url="http://packages.crunchbang.org/waldorf/pool/main/"


###########################################




############ STATLER - STABLE ############

## Packages from Debian Main Repo
stable_debian_pkgs="openbox obconf obmenu tint2	conky suckless-tools lxappearance nitrogen gmrun"

## Packages from Crunchbang Repo
stable_url="http://packages.crunchbang.org/statler/pool/main/"

## Compatible with all Archs
#
# Do some regex / grep magic on http://packages.crunchbang.org/statler/pool/main/ to always get the latest packages?

stable_files=(
	cb-wmhacks_0.06_all.deb
	crunchbang-bin-scripts_0.25_all.deb
	crunchbang-configs_0.1.1_all.deb
	crunchbang-extra-themes_0.2_all.deb
	crunchbang-wallpapers_0.8_all.deb
	elementary-icon-theme_2.5-0crunchbang1_all.deb
	plymouth-themes-all_0.8.3-9.4~crunchbang_all.deb
	plymouth-themes-fade-in_0.8.3-9.4~crunchbang_all.deb
	plymouth-themes-glow_0.8.3-9.4~crunchbang_all.deb	 
	plymouth-themes-script_0.8.3-9.4~crunchbang_all.deb	 
	plymouth-themes-solar_0.8.3-9.4~crunchbang_all.deb	 
	plymouth-themes-spinfinity_0.8.3-9.4~crunchbang_all.deb
	statler-gdm-theme_0.01_all.deb
	statler-icon-theme_0.0.1_all.deb
	statler-slim-theme_0.03_all.deb
	statler-ui-theme_0.02_all.deb
	)

## Not compatible with all architectures - but (probably) crunchbang specific!
#
# adobe-flash-plugin-32_11.01-crunchbang1.tar.gz
# adobe-flash-plugin-64_11.01-crunchbang1.tar.gz
# fbxkb_0.6-1-2crunchbang2.tar.gz
# gdm_2.20.11-4crunchbang.tar.gz
# gtk2-engines-murrine_0.91.0-crunchbang-2~git201009100045.tar.gz
# notify-osd_0.9.29-1crunchbang7.tar.gz
# plymouth-dev_0.8.3-9.4~crunchbang_i386.deb ## NO crunchbang-sourcepackage available!
# plymouth-x11_0.8.3-9.4~crunchbang_i386.deb ## NO crunchbang-sourcepackage available!
# plymouth_0.8.3-9.4~crunchbang.tar.gz
# slim_1.3.1.orig.tar.gz + slim_1.3.1-8crunchbang1.diff.gz
# tint2conf_0.11~svn639-2_i386.deb ## NO crunchbang-sourcepackage available!
# viewnior_1.0-3~crunchbang.tar.gz
# volumeicon_0.4.4-0crunchbang1.tar.gz

##########################################

if [ $(whoami) = "root" ]
then
	if [ ! -f /etc/debian_version ]
	then
		echo "FATAL: Your system doesn't look like Debian/GNU - Aborting!"
		exit 0
	fi

	# Install base applications first!
	echo "Installing base applications..."
	apt-get update &>> convert.log
	apt-get install $stable_debian_pkgs -y --force-yes &>> convert.log
	
	# Now download the crunchbang specific ones
	mkdir cb_tmp
	cd cb_tmp
	echo "Downloading crunchbang-specific packages..."
	for i in {1..16}; do wget --quiet $stable_url${stable_files[$i]}; done
	
	echo "Installing crunchbang-specific packages..."
	for i in {1..16}; do dpkg -i *.deb; done
	
	# Finish
	echo "Conversion to crunchbang finished"
else
  echo "FATAL: You must be superuser to convert your debian system to a crunchbang-ish one - Aborting!"
  exit 0
fi
