#!/bin/bash
#####################################################################################################
# Script_Name : xrdp-installer-1.5.3.sh
# Description : Perform xRDP installation on Ubuntu 20.04,22.04,24.04,24.10 and perform
#               additional post configuration to improve end user experience
# Date : Janvier 2025
# written by : Griffon
# WebSite :http://www.c-nergy.be - http://www.c-nergy.be/blog
# Version : 1.5.3
# History : 1.5.3 - install libfuse3-dev (required for xrdp 0.10.2)
#                 - additional check not to install xrdp standard on ubuntu 24.10 (cause incompatible version)
#                 - additional check to see if xrdp-sesman service needs to be created or not 
#                 - adding support to H264 encoding/decoding protocol 
#                 - Remove Support for Debian 10 (EOL - June 2024)
#         : 1.5.2 - Change Code to Check OS
#                 - Add -p switch to fix permissions issues (rare situation)
#                 - Fixed issue with Linux Mint 22 detection desktop ssh 
#                 - Backward compatibilty with xsessionrc for upgrade
#                 - Removed Ubuntu 23.10 Support
#         : 1.5.1 - Add Support for Zorin OS (Best Effort)
#                 - Cleanup code and removing duplicate variables
#                 - Disable gnome Remote Desktop and Sharing Desktop feature to avoid conflict with xRDP
#                 - Fixing custom login screen look'n feel (set picture to correct size)
#                 - Removing Temporary Fix while waiting xrdp v0.10 final release - Not Needed anymore
#                 - Try to fix blackscreen situation with Ubuntu 24.04 and xrdp 0.9.24 and later (Experimental) 
#                 - Change location for sound redirection compilation. Not using /tmp folder anymore. Some users reported some permissions issues
#         : 1.5   - Add Support for Ubuntu 24.04
#                 - Bug Fix when -d option selected. correct version detected
#                 - Fix issue with checkinstall needed -fstrans parameter
#                 - Creating flatpak exception (installed or not on the system)
#                 - Workaround to detect xrdp version. if lower than 0.10 as last release, download beta release
#                 - Detect if pipewire-snd-module deb pkg available or not. if available install from package. if not, compile it
#                 - Integrating changes made in the startwm.sh file(in version 0.10 & later)
#                 - If xRDP version < 0.10. keep code to modify startwm.sh file (interim code to support old Distro versions)
#                 - xRDP Credentials page will get unique background color now (grey)
#                 - Bug Fixing & consolidating some code sections
#                 - Do not enforce anymore XDG_DATA_DIRS Variable in the startwm.sh file
#                 - Adding code to detect source repo for compilation of sound redirection module for LMDE (if needed) 
#                 - updating code for sound server detection
#                 - Massive Contribution from Hiero on this release - Credits embedded in the script - Thank you Hiero  :) 
#         : 1.4.9 - Remove Support for Ubuntu 23.04 (End of Life)
#                 - Add support for Linux LMDE (Experimental)
#                 - Add polkit code to avoid popup for flatpak repo updates (best effort)
#         : 1.4.8 - Remove Support for Ubuntu 18.04 (End of Standard Support)
#                 - Remove Support for Ubuntu 22.10 (End of Life)
#                 - Adding Support Ubuntu 23.10 
#                 - Fixing versioning package
#                 - Detecting Sound Server in use and perform sound redirection compilation accordingly
#         : 1.4.7 - adding ubuntu 23.04 support 
#                 - adding enable-vsock support 
#           1.4.6 - Fixing Issues about fuse and fuse3 package conflicts (Thanks to Hiero that detected the issue)
#                 - Add MP3 Codec support for Audio redirection 
#                 - Using the latest stable Release packages of xrdp and xorgxrdp from Github in custom install mode(instead of Dev Branch)
#         : 1.4.5 - Fixing Sound redirection issue for Linux Mint Users
#         : 1.4.4 - Adding Support to Ubuntu 22.10
#         : 1.4.3 - Install by default meson,tdb-tools,libtdb-dev,doxygen,check(to support kubuntu and others)
#                 - Adding basic error handling sound redirection function
#                 - Adding Warning message if user already logged on locally and trying to rdp into the system (Thanks to Hiero)
#                 - Minor bug fixing 
#         : 1.4.2 - Improving SSH Detection Process...
#                 - checking PipeWire vs PulseAudio. If PipeWire, no sound redirection
#                 - fixing bug in code for Sound redirection (thank to Hiero for his findings !!!)
#                 - adding support Linux Mint (Software rendering only)
#                 - adding support Pop!OS 22.04
#                 - Removing support Pop!OS 21.04 & 21.10
#                 - Additional Checks on add xrdp to ssl-cert function
#                 - Small Change code Structure 
#           1.4.1 - adding --recursive to git downloads
#                 - xrdp login screen background color set to grey
#           1.4   - Re-write sound section (since meson is used) 
#                 - Added Pop!Os 21.10 as Detected system (Best Effort !!!)
#                 - Detect when install from ssh session - (Experimental)
#                 - Adding Support Ubuntu 22.04
#                 - Removing Support for Ubuntu 21.04 (End Standard Support)
#                 - Improved Debian detection and warning about std vs custom install
#         : 1.3   - Adding support for Ubuntu 21.10 (STR)
#                 - Code modification sound redirection using meson technology (ubuntu 21.10 only so far) 
#                 - Adding support for Debian (10 and 11) (Best Effort)
#                 - Added Rules to Detect Budgie-Desktop and postConfig settings
#                 - Added support for Pop!_0S (Best Effort !!!)
#                 - Code Changes to detect Desktop Interface in use  
#                 - Reworked code for xrdp removal option 
#                 - Improved Std vs Custom installation detection process
#                 - Added support for Different Desktop Interfaces (More testing needed)
#                 - General Code structure re-worked to add more OS version and Desktop interface support  
#                 - Fixed Minor Bug(s)  
#         : 1.2.3 - Adding support for Ubuntu 21.04 
#                 - Removing Support for Ubuntu 16.04.x (End Standard Support)
#                 - Delete xrdp and xorgxrdp folder when remove option selected
#                 - Review remove function to detect hwe package U18.04
#                 - Review, Optimize, Cleanup Code 
#         : 1.2.2 - Changing Ubuntu repository from be.archive.ubuntu.com to archive.ubuntu.com
#                 - Bug Fixing - /etc/xrdp/xrdp-installer-check.log not deleted when remove option   
#                   selected in the script - Force Deletion (Thanks to Hiero for this input)     
#                 - Bug Fixing - Grab automatically xrdp/xorgxrdp package version to avoid     
#                   issues when upgrade operation performed (Thanks to Hiero for this input)     
#         : 1.2.1 - Adding Support to Ubuntu 20.10 + Removed support for Ubuntu 19.10
#           1.2   - Adding Support to Ubuntu 20.04 + Removed support for Ubuntu 19.04
#                 - Stricter Check for HWE Package (thanks to Andrej Gantvorg)
#                 - Changed code in checking where to copy image for login screen customization 
#                 - Fixed Bug checking SSL group membership 
#                 - Updating background color xrdp login screen 
#                 - Updating pkgversion to x.13 for checkinstall process
#         : 1.1   - Tackling multiple run of the script 
#                 - Improved checkinstall method/check ssl group memberhsip
#                 - Replaced ~/Downloads by a variable                 
#         : 1.0   - Added remove option + Final optimization                
#         : 0.9   - updated compile section to use checkinstall
#         : 0.8   - Updated the fix_theme function to add support for Ubuntu 16.04 
#         : 0.7   - Updated prereqs function to add support for Ubuntu 16.04
#         : 0.6   - Adding logic to detect Ubuntu version for U16.04 
#         : 0.5   - Adding env variable Fix 
#         : 0.4   - Adding SSL Fix 
#         : 0.3   - Adding custom login screen option  
#         : 0.2   - Adding new code for passing parameters  
#         : 0.1   - Initial Script (merging custom & Std)       
# Disclaimer : Script provided AS IS. Use it at your own risk....
#              You can use this script and distribute it as long as credits are kept 
#              in place and unchanged   
####################################################################################################

#---------------------------------------------------#
# Set Script Version                                #
#---------------------------------------------------#

#--Automating Script versioning 
ScriptVer="1.5.3"

#---------------------------------------------------#
# Variables and Constants                           #
#---------------------------------------------------#

#--Detecting  OS Version 
version=$(lsb_release -sd)
codename=$(lsb_release -sc)
Release=$(lsb_release -sr)

#Define Dwnload variable to point to ~/Downloads folder of user running the script
Dwnload=$(xdg-user-dir DOWNLOAD)

#Initialzing other variables
modetype="unknown"

#---------------------------------------------------#
# Script Version information Displayed              #
#---------------------------------------------------#

echo
/bin/echo -e "\e[1;36m   !-----------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;36m   !   xrdp-installer-$ScriptVer Script                                   !\e[0m"
/bin/echo -e "\e[1;36m   !   Support Ubuntu and Debian Distribution                        !\e[0m"
/bin/echo -e "\e[1;36m   !   Written by Griffon - Jan    2025  -  www.c-nergy.be          !\e[0m"
/bin/echo -e "\e[1;36m   !                                                                 !\e[0m"
/bin/echo -e "\e[1;36m   !   For Help and Syntax, type ./xrdp-installer-$ScriptVer.sh -h        !\e[0m"
/bin/echo -e "\e[1;36m   !                                                                 !\e[0m"
/bin/echo -e "\e[1;36m   !-----------------------------------------------------------------!\e[0m"
echo
/bin/echo -e "\e[1;38m   !----------------------------------------------------------------!\e[0m"
/bin/echo -e "\e[1;38m   !                      Disclaimer                                !\e[0m"
/bin/echo -e "\e[1;38m   !   !! Script provided AS IS. Use it at your own risk.!!         !\e[0m"
/bin/echo -e "\e[1;38m   !----------------------------------------------------------------!\e[0m"

#---------------------------------------------------------#
# Initial checks and Validation Process ....              #
#---------------------------------------------------------#

#-- Detect if multiple runs and install mode used..... 
echo
/bin/echo -e "\e[1;33m   |-| Checking if script has run at least once...        \e[0m"
if [ -f /etc/xrdp/xrdp-installer-check.log ]
then
	modetype=$(sed -n 1p /etc/xrdp/xrdp-installer-check.log)
	/bin/echo -e "\e[1;32m       |-| Script has already run. Detected mode...: $modetype\e[0m"
    echo
else 
	/bin/echo -e "\e[1;32m       |-| First run or xrdp-installer-check.log deleted. Detected mode : $modetype        \e[0m"
    echo
fi 

#---------------------------------------------------------#
# Detect Destkop Interface                                #
#---------------------------------------------------------#

#--Detecting variable related to Desktop interface and Directory path (Experimental)
if [[ *"$XDG_SESSION_TYPE"* = *"tty"*  ]] 
then 
	##-- Detect if installation done via ssh connections 
	/bin/echo -e "\e[1;32m       |-| Detected Installation via ssh.... \e[0m"
	echo
	# Need new code to display DE Option available
	/bin/echo -e "\e[1;33m  !--------------------------------------------------------------!\e[0m"
	/bin/echo -e "\e[1;33m  ! Your are using the xrdp-installer script via ssh connection  !\e[0m"
	/bin/echo -e "\e[1;33m  ! The script will proceed....but might not work !!             !\e[0m"             
	/bin/echo -e "\e[1;33m  ! Trying to detect Desktop interface in use...                 !\e[0m"             
    /bin/echo -e "\e[1;33m  !--------------------------------------------------------------!\e[0m"
	echo

    cnt=$(ls /usr/share/xsessions |  wc -l)
    echo $cnt 

    # Try to Detect automatically Desktop Interface. If multiple options present, create a menu
    if [ "$cnt" -gt "1" ]
    then 
        PS3='Please specify which DE you are using...: '
        desk=($(ls /usr/share/xsessions | cut -d "." -f 1))
    
        select menu in "${desk[@]}";
        do
        echo -e "\nyou picked $menu ($REPLY)"
        break;
        
        done         
    else
        desk=($(ls /usr/share/xsessions | cut -d "." -f 1))
        menu=$desk
        echo "Desktop seems to be based on....: " $menu
    fi

    #Multiple versions exist for cinnamon - cinnamon/cinnamon2/cinnamon2d
  #  if [[ *"$menu"* = *"cinnamon"* ]]
   # then 
    #    menu=cinnamon
    #fi

    #Multiple versions exist for cinnamon - cinnamon/cinnamon2/cinnamon2d
    #if [[ *"$menu"* = *"ubuntu"* ]]
    #then 
    #    menu=ubuntu
    #fi
    
    #--Populate DESKTOP_SESSION Variable. This will be used in the fix_theme function 
    DESKTOP_SESSION=$menu
else
	##-- Installation is performed via an existing Desktop Interface...Trying to detect it....
	##-- Detect if installation done via ssh connections 
	/bin/echo -e "\e[1;32m       |-| Detected Installation via GUI.... \e[0m"
	echo
    DesktopVer="$XDG_CURRENT_DESKTOP" 
	SessionVer="$GNOME_SHELL_SESSION_MODE"
    GDMSess="$GDMSESSION"
    
    #--Fixing issue with Debian if xfce/mate/cinnamon installed without gnome desktop. In this case, DESKTOP_SESSION is set to lightdm-xsession  
    if [ $DESKTOP_SESSION = "lightdm-xsession" ]
    then 
        unset DESKTOP_SESSION
    fi
fi

#--------------------------------------------------------------------------#
# -----------------------Function Section - DO NOT MODIFY -----------------#
#--------------------------------------------------------------------------#

#---------------------------------------------------#
# Function 0  - check for supported OS version  ....#
#---------------------------------------------------#
check_os()
{
echo
/bin/echo -e "\e[1;33m   |-| Detecting OS version        \e[0m"

#--Initialize variable to check if OS supported or not
oschk=""

#--Define array of Supported OS 
array=("Ubuntu 20.04" "Ubuntu 22.04" "Ubuntu 24.04" "Ubuntu 24.10" "Ubuntu 25.04" "Pop!_OS 20.04" "Pop!_OS 22.04" "Debian" "Mint" "LMDE" "Zorin")

for element in "${array[@]}"; do
    
  if [[ $version == *"$element"* ]]; then
       #-- Supported OS
       oschk=Supported
   fi  
done

if [[ "$oschk" == "Supported" ]]
then 
    /bin/echo -e "\e[1;32m       |-| OS Version : $version\e[0m"
    /bin/echo -e "\e[1;32m       |-| Desktop Version : $DesktopVer\e[0m"
    echo 
else 
        /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
	    /bin/echo -e "\e[1;31m  ! Your system is not running a supported version !             !\e[0m"
	    /bin/echo -e "\e[1;31m  ! The script has been tested only on the following versions    !\e[0m"
	    /bin/echo -e "\e[1;31m  ! Ubuntu 20.04.x/22.04/24.04/Debian 10/11/12                   !\e[0m"
	    /bin/echo -e "\e[1;31m  ! LinuxMint 20 and later/LMDE 6.x/Pop!_OS 22.04                !\e[0m"             
	    /bin/echo -e "\e[1;31m  ! The script is exiting...                                     !\e[0m"             
        /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
	    echo
	    exit
    fi  
}

#-----------------------------------------------------------------------------#
# Function 1  - Disable Gnome Remote and Desktop Sharing to avoid conflict    #
#-----------------------------------------------------------------------------#
check_grdctl()
{
# Need to change port of Gnome Remote login and Sharing Desktop in order to have xRDP working as expected 
if type -p grdctl >/dev/null && systemctl list-unit-files gnome-remote-desktop.service >/dev/null
then
    /bin/echo -e "\e[1;33m   !------------------------------------------------------------------------------!\e[0m"
    /bin/echo -e "\e[1;33m   !        Changing Ports used by Gnome Remote Login & Gnome Sharing Desktop     !\e[0m"
    /bin/echo -e "\e[1;33m   !------------------------------------------------------------------------------!\e[0m"
    echo 
    /bin/echo -e "\e[1;33m   !  [-] Gnome Remote login new port    :.................3390  !\e[0m"
    echo
    sudo grdctl --system rdp disable
    sudo grdctl --system rdp set-port 3390
    echo
    /bin/echo -e "\e[1;33m   !  [-] Gnome Sharing Desktop new port :.................3391  !\e[0m"
    echo
    sudo grdctl rdp disable
    sudo grdctl rdp set-port 3391
fi
}

#---------------------------------------------------#
# Function 2  - check xserver-xorg-core package....
#---------------------------------------------------#
check_hwe()
{
echo
/bin/echo -e "\e[1;33m |-| Detecting xserver-xorg-core package installed \e[0m"

xorg_no_hwe_install_status=$(dpkg-query -W -f ='${Status}\n' xserver-xorg-core 2>/dev/null)
xorg_hwe_install_status=$(dpkg-query -W -f ='${Status}\n' xserver-xorg-core-hwe-$Release 2>/dev/null) 

if [[ "$xorg_hwe_install_status" =~ \ installed$ ]]
then
# – hwe version is installed on the system
/bin/echo -e "\e[1;32m 	|-| xorg package version: xserver-xorg-core-hwe \e[0m"
HWE="yes"
elif [[ "$xorg_no_hwe_install_status" =~ \ installed$ ]]
then
/bin/echo -e "\e[1;32m 	|-| xorg package version: xserver-xorg-core \e[0m"
HWE="no"
else
/bin/echo -e "\e[1;31m 	|-| Error checking xserver-xorg-core flavour \e[0m"
exit 1
fi
}

#---------------------------------------------------#
# Function 3  - Version specific actions needed....
#---------------------------------------------------#
PrepOS()
{
echo 
/bin/echo -e "\e[1;33m   |-| Custom actions based on OS Version....       \e[0m" 

#--All Versions - Needed to detect PipeWire vs PulseAudio 
/bin/echo -e "\e[1;32m       |-|  Installing pulseaudio-utils...Proceeding...     \e[0m" 
sudo apt-get -y install pulseaudio-utils 

#Debian Specific - add in source backport package to download necessary packages - Debian Specific
if [[ *"$version"* = *"Debian"*  ]]
then
sudo sed -i 's/deb cdrom:/#deb cdrom:/' /etc/apt/sources.list
sudo apt-get update 
sudo apt-get install -y software-properties-common
sudo apt-add-repository -s -y 'deb http://deb.debian.org/debian '$codename'-backports main'
sudo apt-get update 

#--Needed to be created manually or compilation fails 
sudo mkdir /usr/local/lib/xrdp/

    # Debian additional check for Debian 11 if custom switch is not passed as argument 
    if [[ $codename = *"bullseye"* ]] && [[ -z "$adv"  ]] 
    then 
        #custom install performed - we can handle additional options
        if [[ $modetype = "custom" ]] 
        then 
        /bin/echo -e "\e[1;32m       |-| Install Mode (Debian 11)   : Custom...Proceeding         \e[0m"
        echo
        else	
            /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
            /bin/echo -e "\e[1;31m  ! You are running Debian 11 ! You MUST use custom install      !\e[0m"
            /bin/echo -e "\e[1;31m  ! mode for Debian 11 to have it working properly               !\e[0m"
            /bin/echo -e "\e[1;31m  ! Use -c switch when performing the install..                  !\e[0m"     
            /bin/echo -e "\e[1;31m  ! The script is exiting...                                     !\e[0m"             
            /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
            echo
            exit
        fi   
    else
                /bin/echo -e "\e[1;32m       |-| Install Mode for Debian OS  : Custom Mode...Proceeding\e[0m"
                echo
    fi 
fi
#--End Debian Specific --# 

#Ubuntu 24.10 Specific - Temporarly 
   # Ubuntu 24.10 - Quick Fix because standard package not working anymore....
    if [[ $codename = *"oracular"* ]] && [[ -z "$adv"  ]] 
    then 
        #custom install performed - we can handle additional options
        if [[ $modetype = "custom" ]] 
        then 
        /bin/echo -e "\e[1;32m       |-| Install Mode (Ubuntu 24.10)   : Custom...Proceeding         \e[0m"
        echo
        else	
            /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
            /bin/echo -e "\e[1;31m  ! You are running Ubuntu 24.10 ! You MUST use custom install   !\e[0m"
            /bin/echo -e "\e[1;31m  ! mode for 24.10 to have it working properly                   !\e[0m"
            /bin/echo -e "\e[1;31m  ! Use -c switch when performing the install..                  !\e[0m"     
            /bin/echo -e "\e[1;31m  ! The script is exiting...                                     !\e[0m"             
            /bin/echo -e "\e[1;31m  !--------------------------------------------------------------!\e[0m"
            echo
            exit
        fi   
    else
                /bin/echo -e "\e[1;32m       |-| Install Mode for Ubuntu 24.10  : Custom Mode...Proceeding\e[0m"
                echo
    fi 

#--End Ubuntu 24.10 Specific --# 



#--Additional Code for Linux Mint - Used To Configure proper Repositories
if [[ *"$version"* = *"Mint"*  ]]
then
    ucodename=$(cat /etc/os-release | grep UBUNTU_CODENAME | awk -F"=" '{print $2}')
fi

#--Additional Code for LMDE - Used To Configure proper Repositories
if [[ *"$version"* = *"LMDE"*  ]]
then
    ucodename=$(cat /etc/os-release | grep DEBIAN_CODENAME | awk -F"=" '{print $2}')
fi

#---- Background Color Code All Versions  

CustomColor="333333"

## Image in xRDP Login Credentials
if [[ *"$version"* = *"Debian"*  ]]
then
	CustomPix="griffon_logo_xrdpd.bmp"
else 
	CustomPix="griffon_logo_xrdp.bmp"
fi

}

############################################################################
# INSTALLATION MODE : STANDARD
############################################################################

#---------------------------------------------------#
# Function 4  - Install xRDP Software....
#---------------------------------------------------#
install_xrdp()
{
echo 
/bin/echo -e "\e[1;33m   |-| Installing xRDP packages       \e[0m"
echo 
sudo apt-get install xrdp -y
}

############################################################################
# ADVANCED INSTALLATION MODE : CUSTOM INSTALLATION
############################################################################

#---------------------------------------------------#
# Function 5 - Install Prereqs...
#---------------------------------------------------#
install_prereqs() {

echo 
/bin/echo -e "\e[1;33m   |-| Installing prerequisites packages       \e[0m" 
echo

#Install packages
sudo apt-get -y install git jq curl
sudo apt-get -y install libmp3lame-dev curl libfuse3-dev libx11-dev libxfixes-dev libssl-dev libpam0g-dev libtool libjpeg-dev flex bison gettext autoconf libxml-parser-perl xsltproc libxrandr-dev python3-libxml2 nasm pkg-config git intltool checkinstall libopenh264-dev
echo

#-- check if no error during Installation of missing packages
if [ $? -eq 0 ]
then 
/bin/echo -e "\e[1;33m   |-| Preprequesites installation successfully       \e[0m"
else 
echo
echo
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
/bin/echo -e "\e[1;31m   !   Error while installing prereqs            !\e[0m"
/bin/echo -e "\e[1;31m   !   The Script is exiting....                 !\e[0m"
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
exit
fi

#-- check if hwe stack needed or not 
if [ $HWE = "yes" ];
then
	# - xorg-hwe-* to be installed
	/bin/echo -e "\e[1;32m       |-| xorg package version: xserver-xorg-core-hwe-$Release \e[0m"
	sudo apt-get install -y xserver-xorg-dev-hwe-$Release xserver-xorg-core-hwe-$Release	
else
	#-no-hwe
	/bin/echo -e "\e[1;32m       |-| xorg package version: xserver-xorg-core \e[0m"
	echo
	sudo apt-get install -y xserver-xorg-dev xserver-xorg-core
fi
}

#---------------------------------------------------#
# Function 6 - Download XRDP Binaries... 
#---------------------------------------------------#
get_binaries() { 
echo 
/bin/echo -e "\e[1;33m   |-| Downloading xRDP Binaries...Proceeding     \e[0m" 
echo

cd $Dwnload

#Check if xrdp folder already exists.  if yes; delete it and download again in order to get latest version
if [ -d "$Dwnload/xrdp" ] 
then
	sudo rm -rf xrdp
fi

#Check if xorgxrdp folder already exists.  if yes; delete it and download again in order to get latest version
if [ -d "$Dwnload/xorgxrdp" ] 
then
	sudo rm -rf xorgxrdp
fi

## -- Download the xrdp latest files
echo
/bin/echo -e "\e[1;32m       |-|  Downloading xRDP Binaries.....     \e[0m" 
echo
if [ "$devcode" = "yes" ]; 
then 
    echo 
    /bin/echo -e "\e[1;33m   !--------------------------------------------------------!\e[0m" 
    /bin/echo -e "\e[1;33m   ! Downloading Dev (unstable) Release Version Files.      !\e[0m" 
    /bin/echo -e "\e[1;33m   !--------------------------------------------------------!\e[0m" 
    echo
    /bin/echo -e "\e[1;32m       |-|  Downloading xRDP Binaries.....     \e[0m" 
    echo
    git clone https://github.com/neutrinolabs/xrdp.git --recursive
    
    echo 
    /bin/echo -e "\e[1;32m       |-|  Downloading xorgxrdp Binaries...     \e[0m" 
    echo
    git clone https://github.com/neutrinolabs/xorgxrdp.git --recursive
    
    #------------------------------------------------------#
    # Hiero's Contribution !! Bug fixing ! Thank you Hiero # 
    #------------------------------------------------------#
    pushd xrdp
    LastReleaseXrdp=$(git describe --tags $(git rev-list --tags --max-count=1))
    popd
    pushd xorgxrdp
    LastReleaseXorgxrdp=$(git describe --tags $(git rev-list --tags --max-count=1))
    popd
else
    LastReleaseXrdp=$(curl --silent "https://api.github.com/repos/neutrinolabs/xrdp/releases/latest" | jq -r .tag_name)
    git clone -b $LastReleaseXrdp  https://github.com/neutrinolabs/xrdp.git --recursive
    echo 
    /bin/echo -e "\e[1;32m       |-|  Downloading xorgxrdp Binaries...     \e[0m" 
    echo
    LastReleaseXorgxrdp=$(curl --silent "https://api.github.com/repos/neutrinolabs/xorgxrdp/releases/latest" | jq -r .tag_name)
    git clone -b $LastReleaseXorgxrdp  https://github.com/neutrinolabs/xorgxrdp.git --recursive
fi

}

#---------------------------------------------------#
# Function 7 - compiling xrdp... 
#---------------------------------------------------#
compile_source() { 
echo 
/bin/echo -e "\e[1;33m   |-| Compiling xRDP Binaries...Proceeding     \e[0m" 
echo

cd $Dwnload/xrdp

#Get the release version automatically
pkgver1=${LastReleaseXrdp#?} 

sudo ./bootstrap
sudo ./configure --enable-fuse --enable-jpeg --enable-rfxcodec --enable-mp3lame --enable-vsock --enable-painter --enable-openh264
sudo make

#-- check if no error during compilation 
if [ $? -eq 0 ]
then 
echo
/bin/echo -e "\e[1;32m       |-|  Make Operation Completed successfully....xRDP     \e[0m" 
echo
else 
echo
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
/bin/echo -e "\e[1;31m   !   Error while Executing make                !\e[0m"
/bin/echo -e "\e[1;31m   !   The Script is exiting....                 !\e[0m"
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
exit
fi

# CheckInstall Action - creating deb package
sudo checkinstall --fstrans=0  --pkgname=xrdp --pkgversion=$pkgver1 --pkgrelease=1 --default 

#xorgxrdp package compilation
echo
/bin/echo -e "\e[1;32m       |-|  Make Operation Completed successfully....xorgxrdp     \e[0m" 
echo

cd $Dwnload/xorgxrdp

#Get the release version automatically
pkgver2=${LastReleaseXorgxrdp#?} 

sudo ./bootstrap 
sudo ./configure 
sudo make

# check if no error during compilation 
if [ $? -eq 0 ]
then 
echo
/bin/echo -e "\e[1;33m   |-| Compilation Completed successfully...Proceeding    \e[0m"
echo
else 
echo
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
/bin/echo -e "\e[1;31m   !   Error while Executing make                !\e[0m"
/bin/echo -e "\e[1;31m   !   The Script is exiting....                 !\e[0m"
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
exit
fi

# CheckInstall Action - creating deb package
sudo checkinstall --fstrans=0 --pkgname=xorgxrdp --pkgversion=1:$pkgver2 --pkgrelease=1 --default

}

#---------------------------------------------------#
# Function 8 - create services .... 
#---------------------------------------------------# 
enable_service() {
echo
/bin/echo -e "\e[1;33m   |-| Creating and configuring xRDP services    \e[0m"
echo
sudo systemctl daemon-reload
sudo systemctl enable xrdp.service
#this file does not exist anymore in xrdp 0.10.2 - so error is expected !! 
# we keep this line for previous OS where older packages are used....
#chek if file exists if not - download it.... 
if [ -f "/lib/systemd/system/xrdp-sesman" ]
then
	sudo systemctl enable xrdp-sesman.service
else
	/bin/echo -e "\e[1;32m       |-| skipping xorgxrdp   \e[0m"	
fi
sudo systemctl start xrdp

}

############################################################################
# COMMON FUNCTIONS - WHATEVER INSTALLATION MODE - Version Specific !!!
############################################################################

#--------------------------------------------------------------------------#
# Function 9 - Install Tweaks Utility if Gnome desktop used (Optional).... #
#--------------------------------------------------------------------------# 
install_tweak() 
{
echo
/bin/echo -e "\e[1;33m   |-| Checking if Tweaks needs to be installed....    \e[0m"
if [[ "$DesktopVer" != *"GNOME"* ]] 
then
/bin/echo -e "\e[1;32m       |-|  Gnome Tweaks not needed...Proceeding...     \e[0m" 
echo
else
/bin/echo -e "\e[1;32m       |-|  Installing Gnome Tweaks Utility...Proceeding... \e[0m" 
echo
    #sudo apt-get install gnome-tweak-tool -y (old name)
    sudo apt-get install gnome-tweaks -y
fi
}

#--------------------------------------------------------------------#
# Fucntion 10 - Allow console Access ....(seems optional in u18.04)
#--------------------------------------------------------------------#
allow_console() 
{
echo
/bin/echo -e "\e[1;33m   |-| Configuring Allow Console Access...    \e[0m"
echo
# Checking if Xwrapper file exists
if [ -f /etc/X11/Xwrapper.config ]
then
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
else
	sudo bash -c "cat >/etc/X11/Xwrapper.config" <<EOF
	allowed_users=anybody
EOF
fi
}

#---------------------------------------------------#
# Function 11 - create policies exceptions .... 
#---------------------------------------------------#
create_polkit()
{
echo
/bin/echo -e "\e[1;33m   |-| Creating Polkit exceptions rules...    \e[0m"
echo

#-- Check which version of pkaction in used 
chkPkv=$(pkaction --version |  awk '{print $3}')
if [[ "$chkPkv" > "0.106"  ]]
then 
    /bin/echo -e "\e[1;32m       |-|  New Polkit version in used in Ubuntu 23.10 and later     \e[0m"
    /bin/echo -e "\e[1;32m       |-|  Work in progress...     \e[0m"

#--create flatpak polkit exception even if flatpak not installed

sudo bash -c "cat >/etc/polkit-1/rules.d/48-allow-flatpak.rules" <<EOF
/* Allow system refresh without authentication xRDP Session */
polkit.addRule(function(action, subject) {
if (action.id = "org.freedesktop.Flatpak.modify-repo" &&
subject.isInGroup("sudo")) {
return polkit.Result.YES;
}
});
EOF

else

#Polkit Color Manager
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla" <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF

#Not to apply to Ubuntu 18.04 version but to others....This caused an issue on Ubuntu 18.04 - No Need to Check - Ubuntu 18.04 not supported anymore by the script 
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/46-allow-update-repo.pkla" <<EOF
[Allow Package Management all Users]
Identity=unix-user:*
Action=org.freedesktop.packagekit.system-sources-refresh;org.freedesktop.packagekit.system-network-proxy-configure
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF

#-- Flatpak Specific  - Always create exception file  
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/48-allow-flatpak.pkla" <<EOF
[Allow Package Management all Users]
Identity=unix-user:*
Action=org.freedesktop.Flatpak.modify-repo
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF

#-- KDE Desktop Specific  - can be detected only at run time of the script 
#-- Do Not Check anymore always create it
#if [ "$DesktopVer" = "KDE" ];
#then
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/47-allow-networkd.pkla" <<EOF
[Allow Network Control all Users]
Identity=unix-user:*
Action=org.freedesktop.NetworkManager.network-control
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF
#fi

fi
}


#---------------------------------------------------#
# Function 12 - Fixing Theme and Extensions .... 
#---------------------------------------------------#
fix_theme()
{
echo
/bin/echo -e "\e[1;33m   |-| Fixing Themes and Extensions....    \e[0m"
echo

# Checking if script has run already 
if [ -f /etc/xrdp/startwm.sh.griffon ]
then
sudo rm /etc/xrdp/startwm.sh
sudo mv /etc/xrdp/startwm.sh.griffon /etc/xrdp/startwm.sh
fi 

#Backup the file before modifying it
sudo cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.griffon
echo

# Download the latest version of startwm.sh so we can use the new approach....
if [ "$devcode" != "yes" ];
then
sudo wget -q -r -O /etc/xrdp/startwm.sh https://github.com/neutrinolabs/xrdp/raw/devel/sesman/startwm.sh
fi

#-------------------------------------------------------#
# Hiero Contribution !! Code & Idea ! Thank you Hiero   #  
#-------------------------------------------------------#

echo
/bin/echo -e "\e[1;33m   |-| Enable Warning Msg multi-connections....    \e[0m"
echo

sudo bash -c "cat >/etc/profile.d/90-xrdp-default-desktop.sh" <<EOF
if [ -n "\$XRDP_SESSION" -a -z "\$DESKTOP_SESSION" ]; then
  if loginctl session-status \$(loginctl show-user \$USER | sed -n -e "s/Sessions=//p") | grep Leader: | grep -sqE "gdm|sddm|lightdm"; then
    printf "You are locally logged on.\nTo Remote Connect, logout from local session first." | xmessage -title Warning -buttons Exit -default Exit:1 -center -fg gold -bg black -fn "-*-*-*-r-*--0-250-0-0-p-*-iso8859-1" -file -
    exit 1
  fi
  export DESKTOP_SESSION=$DESKTOP_SESSION
fi
EOF

#- Workaround for possible black screen issue with Ubuntu 24.04 and xRDP - Can happen also with GNome Remote login
if [[ *"$version"* = *"Ubuntu 24.04"* ]] && [[ *"$XDG_CURRENT_DESKTOP"* = *"GNOME"* ]]
then
sudo bash -c "cat >/etc/xdg/autostart/workaround-xrdp.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=workaround for xrdp
Exec=sh -c 'if [ -n "\$XRDP_SESSION" -a "\$XDG_SESSION_TYPE" = "x11" ]; then sleep 2;timeout 0.5 xmessage -iconic x; fi'
EOF
fi

# To remove .xsessionrc to avoid any issues or conflicts 
#if [ -e ~/.xsessionrc ]
#then
 # rm ~/.xsessionrc
#fi

}

snd_pipewire()
{

    #---------------------------------------------------#
    # Hiero Contribution !! Code & Idea ! Thank you Hiero  
    #---------------------------------------------------#

    echo
    /bin/echo -e "\e[1;33m   |-| Enabling Sound Redirection using pipewire module...    \e[0m"
    echo

    if apt-cache search pipewire-module-xrdp | grep -sq pipewire-module-xrdp;
    then
        echo
        /bin/echo -e "\e[1;33m   |-| Installing pipewire-module-xrdp package       \e[0m"
        echo
        sudo apt -y install pipewire-module-xrdp
        return
    fi

    echo
    /bin/echo -e "\e[1;33m         |-| Proceeding Pipewire and xRDP....    \e[0m"
    echo
    # Install build environment
    sudo apt install git pkg-config autotools-dev libtool make gcc
    # Install dependencies 
    sudo apt install libpipewire-0.3-dev libspa-0.2-dev
    #Download source files 
    cd $Dwnload
    git clone https://github.com/neutrinolabs/pipewire-module-xrdp.git --recursive

    #Build & Install 
    cd $Dwnload/pipewire-module-xrdp
    ./bootstrap
    ./configure
    sudo make
    sudo make install
    echo
    /bin/echo -e "\e[1;32m       |-|  Make Operation Completed successfully....xRDP Sound     \e[0m" 
    
}

snd_pulse()
{

echo
/bin/echo -e "\e[1;33m   |-| Enabling Sound Redirection....    \e[0m"
echo

pulsever=$(pulseaudio --version | awk '{print $2}')

/bin/echo -e "\e[1;32m       |-| Install additional packages..     \e[0m" 

# Version Specific - adding source and correct pulseaudio version for Debian !!!  
if [[ *"$version"* = *"Debian"*  ]]
then
# Step 0 - Install Some PreReqs
/bin/echo -e "\e[1;32m       	|-| Install dev tools used to compile sound modules..     \e[0m" 
echo
sudo apt-get install libconfig-dev -y
sudo apt-get install git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libcap-dev libjson-c-dev -y
sudo apt build-dep pulseaudio -y
elif  [[ *"$version"* = *"Mint"* ]]; then
# Step 0 - Install Some PreReqs
echo
/bin/echo -e "\e[1;32m       	|-| Enabling Sources Repository for Linux Mint..     \e[0m" 
echo
sudo bash -c "cat >/etc/apt/sources.list.d/official-source-repositories.list" <<EOF
deb-src http://packages.linuxmint.com $codename main upstream import backport 

deb-src http://archive.ubuntu.com/ubuntu $ucodename main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $ucodename-updates main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu $ucodename-backports main restricted universe multiverse

deb-src http://security.ubuntu.com/ubuntu/ $ucodename-security main restricted universe multiverse
EOF
sudo apt-get update

elif  [[ *"$version"* = *"LMDE"* ]]; then
# Step 0 - Install Some PreReqs
echo
/bin/echo -e "\e[1;32m       	|-| Enabling Sources Repository for Linux Mint..     \e[0m" 
echo
sudo bash -c "cat >/etc/apt/sources.list.d/official-source-repositories.list" <<EOF
deb-src http://packages.linuxmint.com $codename main upstream import backport 

deb-src https://deb.debian.org/debian $ucodename main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian $ucodename-updates main contrib non-free non-free-firmware
deb-src http://security.debian.org    $ucodename-security main contrib non-free non-free-firmware

deb-src https://deb.debian.org/debian $ucodename-backports main contrib non-free non-free-firmware
EOF
sudo apt-get update

else
# Step 1 - Enable Source Code Repository
/bin/echo -e "\e[1;32m      	|-| Adding Source Code Repository..     \e[0m"
echo 
sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename' main restricted'
sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename' restricted universe main multiverse'
sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-updates restricted universe main multiverse'
sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-backports main restricted universe multiverse'
sudo apt-add-repository -s -y 'deb http://archive.ubuntu.com/ubuntu/ '$codename'-security main restricted universe main multiverse'
sudo apt-get update
fi

# Step 2 - Install Some PreReqs
sudo apt-get install git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libcap-dev libjson-c-dev libconfig-dev -y

# Additional Libs needed for other Distributions like Kubuntu (for security only)
sudo apt-get install meson -y
sudo apt-get install libtdb-dev -y
sudo apt-get install doxygen -y
sudo apt-get install check -y
sudo apt build-dep pulseaudio -y

echo
/bin/echo -e "\e[1;32m       |-| Download pulseaudio sources files..     \e[0m" 
# Step 3 -  Download pulseaudio source in /tmp directory - Debian source repo should be already enabled
cd $Dwnload
apt source pulseaudio
/bin/echo -e "\e[1;32m       |-| Compile pulseaudio sources files..     \e[0m" 

# Step 4 - Compile PulseAudio based on OS version & PulseAudio Version
cd $Dwnload/pulseaudio-$pulsever*
PulsePath=$(pwd)

# Fixiing Permissions issues when compiling sound - Permission Denied on Build Folder - Rare condition but seems to happens

sudo chmod -R 777 $PulsePath

cd "$PulsePath"
    if [ -x ./configure ]; then
        #if pulseaudio version <15.0, then autotools will be used (legacy) 
        ./configure
    elif [ -f ./meson.build ]; then
          #if pulseaudio version >15.0, then meson tools will be used (new)
          sudo meson --prefix=$PulsePath build
     #  sudo ninja -C build install - not needed and break sound redirection - Thanks to Hiero for spotting it :)
    fi

# step 5 - Create xrdp sound modules
cd $Dwnload
/bin/echo -e "\e[1;32m       |-| Compiling and building xRDP Sound modules...     \e[0m" 
git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git

# Fixiing Permissions issues when compiling sound - Permission Denied on Build Folder - Rare condition but seems to happens
sudo chmod -R 777 $PulsePath

cd pulseaudio-module-xrdp
./bootstrap 
./configure PULSE_DIR=$PulsePath
make
#this will install modules in /usr/lib/pulse* directory
sudo make install

#-- check if no error during compilation 
if [ $? -eq 0 ]
then 
echo
/bin/echo -e "\e[1;32m       |-|  Make Operation Completed successfully....xRDP Sound     \e[0m" 
echo
else 
echo
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
/bin/echo -e "\e[1;31m   !   Error while Executing compilation         !\e[0m"
/bin/echo -e "\e[1;31m   !   Sound Redirection failed...               !\e[0m"
/bin/echo -e "\e[1;31m   !   The Script is exiting....                 !\e[0m"
/bin/echo -e "\e[1;31m   !---------------------------------------------!\e[0m"
exit
fi
       
}

#---------------------------------------------------#
# Function 12 - Enable Sound Redirection .... 
#---------------------------------------------------#
enable_sound()
{

echo
/bin/echo -e "\e[1;33m   |-| Enabling Sound Redirection....    \e[0m"
echo

    #Code to check if pipewire or PulseAudio... 
    # Hiero's Contribution - detecting properly Sound Server
    SndServer=$(LANG=C pactl info | grep "Server Name" | cut -d: -f2)
 
    if [[ "$SndServer" = *"PipeWire"* ]];
    then 
            snd_pipewire
    else
            snd_pulse
    fi


}

#---------------------------------------------------#
# Function 13 - Custom xRDP Login Screen .... 
#---------------------------------------------------#
custom_login()
{

echo 
/bin/echo -e "\e[1;33m   |-| Customizing xRDP login screen       \e[0m" 
cd $Dwnload

#Check if script has run once...
if [ -f /etc/xrdp/xrdp.ini.griffon ]
then
sudo rm /etc/xrdp/xrdp.ini
sudo mv /etc/xrdp/xrdp.ini.griffon /etc/xrdp/xrdp.ini
fi 

#Backup file 
sudo cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.griffon

#chek if file exists if not - download it.... 
if [ -f "$CustomPix" ]
then
	/bin/echo -e "\e[1;32m       |-| necessary file already available...skipping   \e[0m"
else
	/bin/echo -e "\e[1;32m       |-| Downloading additional file...: logo_xrdp image   \e[0m"
	wget https://www.c-nergy.be/downloads/"$CustomPix"
fi

#Check where to copy the logo file
if [ -d "/usr/local/share/xrdp" ] 
then
    echo
	sudo cp $CustomPix /usr/local/share/xrdp
    sudo sed -i "s/ls_logo_filename=/ls_logo_filename=\/usr\/local\/share\/xrdp\/$CustomPix/g" /etc/xrdp/xrdp.ini
else
    sudo cp $CustomPix /usr/share/xrdp
	sudo sed -i "s/ls_logo_filename=/ls_logo_filename=\/usr\/share\/xrdp\/$CustomPix/g" /etc/xrdp/xrdp.ini
fi


sudo sed -i 's/blue=009cb5/blue=dedede/' /etc/xrdp/xrdp.ini
sudo sed -i 's/#white=ffffff/white=dedede/' /etc/xrdp/xrdp.ini
sudo sed -i 's/#ls_title=My Login Title/ls_title=Remote Desktop for Linux/' /etc/xrdp/xrdp.ini
sudo sed -i "s/.*ls_top_window_bg_color=.*/ls_top_window_bg_color=$CustomColor/" /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_bg_color=dedede/ls_bg_color=ffffff/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_logo_x_pos=55/ls_logo_x_pos=0/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_logo_y_pos=50/ls_logo_y_pos=25/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_logo_width=250/ls_logo_width=340/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_logo_height=110/ls_logo_height=130/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_input_y_pos=158/ls_input_y_pos=200/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_btn_ok_y_pos=308/ls_btn_ok_y_pos=348/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_btn_cancel_y_pos=308/ls_btn_cancel_y_pos=348/' /etc/xrdp/xrdp.ini
sudo sed -i 's/ls_height=360/ls_height=400/' /etc/xrdp/xrdp.ini

}

#---------------------------------------------------#
# Function 14 - Fix SSL Minor Issue .... 
#---------------------------------------------------#
fix_ssl() 
{ 
echo 
/bin/echo -e "\e[1;33m   |-| Fixing SSL Permissions settings...       \e[0m" 
echo 
if ! id -u xrdp > /dev/null 2>&1; then
    echo "The user does not exist; Do Nothing:"
else   
    if id -Gn xrdp | grep ssl-cert 
    then 
        /bin/echo -e "\e[1;32m   !--xrdp already member ssl-cert...Skipping ---!\e[0m" 
    else
	    sudo adduser xrdp ssl-cert 
    fi
fi

}

#---------------------------------------------------#
# Function 15 - Fixing env variables in XRDP .... 
#---------------------------------------------------#
fix_env()
{
echo 
/bin/echo -e "\e[1;33m   |-| Fixing xRDP env Variables...       \e[0m" 
echo 
#Add this line to /etc/pam.d/xrdp-sesman if not present
if grep -Fxq "session required pam_env.so readenv=1 user_readenv=0" /etc/pam.d/xrdp-sesman 
   then
            echo "Env settings already set"
   else
		sudo sed -i '1 a session required pam_env.so readenv=1 user_readenv=0' /etc/pam.d/xrdp-sesman
 fi
}

#---------------------------------------------------#
# Function 17 - Removing XRDP Packages .... 
#---------------------------------------------------#
remove_xrdp()
{
echo 
/bin/echo -e "\e[1;33m   !---------------------------------------------!\e[0m" 
/bin/echo -e "\e[1;33m   ! Removing xRDP Packages...                   !\e[0m" 
/bin/echo -e "\e[1;33m   !---------------------------------------------!\e[0m" 
echo 

#remove the xrdplog file created by the script 
if [ -f "/etc/xrdp/xrdp-installer-check.log" ] 
then 
    sudo rm /etc/xrdp/xrdp-installer-check.log
fi

#----remove xrdp package
sudo systemctl stop xrdp
sudo systemctl disable xrdp
sudo apt-get autoremove xrdp -y
sudo apt-get purge xrdp -y

#---remove xorgxrdp
sudo systemctl stop xorgxrdp
sudo systemctl disable xorgxrdp

if [[ $HWE = "yes" ]] && [[ "$version" = *"Ubuntu 18.04"* ]];
then
	sudo apt-get autoremove xorgxrdp-hwe-18.04 -y 
	sudo apt-get purge xorgxrdp-hwe-18.04 -y
else
    sudo apt-get autoremove xorgxrdp -y 
	sudo apt-get purge xorgxrdp -y
fi

#---Cleanup files 

#Remove xrdp folder
if [ -d "$Dwnload/xrdp" ] 
then
	sudo rm -rf xrdp
fi

#Remove xorgxrdp folder
if [ -d "$Dwnload/xorgxrdp" ] 
then
	sudo rm -rf xorgxrdp
fi

#Remove custom xrdp logo file
if [ -f "$Dwnload/$CustomPix" ] 
then
	sudo rm -f  "$Dwnload/$CustomPix"
fi

#Remove 90-xrdp-default-desktop.sh
if [ -f "/etc/profile.d/90-xrdp-default-desktop.sh" ]
then
	sudo rm "/etc/profile.d/90-xrdp-default-desktop.sh"
fi

#Remove /etc/xdg/autostart/workaround-xrdp.desktop
if [ -f "/etc/xdg/autostart/workaround-xrdp.desktop" ]
then
sudo rm /etc/xdg/autostart/workaround-xrdp.desktop
fi

#Revert port setting to the original number
if type -p grdctl >/dev/null && systemctl list-unit-files gnome-remote-desktop.service >/dev/null
then
grdctl --system rdp set-port 3389
grdctl rdp set-port 3389
fi

sudo systemctl daemon-reload

}

#---------------------------------------------------------------------------------------#
# Function 18 - Fixing a specific issue with Permissions when installing xrdp software  #
#---------------------------------------------------------------------------------------#

Check_Perm() 
{ 
echo
/bin/echo -e "\e[1;33m   |-| Checking File Permissions....        \e[0m"

#Check Permissions on /etc/xrdp/xrdp.ini

if [[ $(stat -c '%a'  /etc/xrdp/xrdp.ini) != '644' ]]
then
    /bin/echo -e "\e[1;32m       |-| Fixing permissions xrdp.ini....: Proceeding  "
    sudo chmod 644 /etc/xrdp/xrdp.ini
else 
   /bin/echo -e "\e[1;32m        |-| Permission xrdp.ini....: Correct  "
  
fi

if [[ $(stat -c '%a'  /etc/xrdp/startwm.sh) != '755' ]]
then 
   /bin/echo -e "\e[1;32m       |-| Fixing permissions startwm.sh....: Proceeding  "
    
    sudo chmod 755 /etc/xrdp/startwm.sh

else 
  /bin/echo -e "\e[1;32m        |-| Permission startwm.sh.... : Correct  "
fi

if [[ $(stat -c '%a' /usr/libexec/pulseaudio-module-xrdp) != '755' ]]
then 
 /bin/echo -e "\e[1;32m        |-| Fixing permissions pulseaudio-module-xrdp....: Proceeding  "
   
    sudo chmod 755 /usr/libexec/pulseaudio-module-xrdp
else 
  /bin/echo -e "\e[1;32m        |-| Permission pulseaudio-module-xrdp.... : Correct "
fi

if [[ $(stat -c '%a' /usr/local/share/xrdp/griffon_logo_xrdp.bmp) != '644' ]]
then 
    /bin/echo -e "\e[1;32m        |-| Fixing permissions griffon_logol_xrdp.bmp....: Proceeding"
    sudo chmod 644 /usr/local/share/xrdp/griffon_logo_xrdp.bmp
else 
  /bin/echo -e "\e[1;32m        |-| Permission griffon_xrdp_logo.... : Correct "
fi

}



sh_credits()
{
echo
/bin/echo -e "\e[1;36m   |----------------------------------------------------------------|\e[0m"
/bin/echo -e "\e[1;36m   | Installation Completed...Please test your xRDP configuration   |\e[0m" 
/bin/echo -e "\e[1;36m   | If Sound option selected, shutdown your machine completely     |\e[0m"
/bin/echo -e "\e[1;36m   | start it again to have sound working as expected               |\e[0m"
/bin/echo -e "\e[1;36m   |                                                                |\e[0m"
/bin/echo -e "\e[1;36m   | Credits : Written by Griffon - Jan  2025                       |\e[0m"
/bin/echo -e "\e[1;36m   |           www.c-nergy.be -xrdp-installer-v$ScriptVer.sh             |\e[0m"
/bin/echo -e "\e[1;36m   |           ver $ScriptVer                                            |\e[0m"
/bin/echo -e "\e[1;36m   |________________________________________________________________|\e[0m"
echo
}


#---------------------------------------------------#
# SECTION FOR OPTIMIZING CODE USAGE...              #
#---------------------------------------------------#

install_common()
{
check_grdctl
install_tweak	
allow_console
create_polkit
fix_theme
fix_ssl
fix_env
}

install_custom()
{
install_prereqs
get_binaries
compile_source
enable_service

}


#--------------------------------------------------------------------------#
# -----------------------END Function Section             -----------------#
#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
#------------                 MAIN SCRIPT SECTION       -------------------# 
#--------------------------------------------------------------------------#

#----------------------------------------------------------#
# Step 0 -Detecting if Parameters passed to script ....    #
#----------------------------------------------------------#
for arg in "$@"
do
    #Help Menu Requested
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
                echo "Usage Syntax and Examples"
                echo
                echo " --custom or -c           custom xRDP install (compilation from sources)"
				echo " --loginscreen or -l      customize xRDP login screen"
                echo " --remove or -r           removing xRDP packages"
                echo " --dev or -d              download dev branch xrdp packages"
                echo " --sound or -s            enable sound redirection in xRDP"
                echo " --perm or -p             fix permissions issues on xrdp files"
                echo " --unsupported or -u      bypass the OS Check but use it at your own risk"
                echo
                echo "example                                                      "
                echo     
                echo " ./xrdp-installer-$ScriptVer.sh -c -s  custom install with sound redirection"
                echo " ./xrdp-installer-$ScriptVer.sh -l     standard install with custom login screen"
                echo " ./xrdp-installer-$ScriptVer.sh        standard install no additional features"
                echo
                exit
    fi
 
    if [ "$arg" == "--sound" ] || [ "$arg" == "-s" ]
    then
        fixSound="yes" 				
    fi 

    if [ "$arg" == "--loginscreen" ] || [ "$arg" == "-l" ]
    then
        fixlogin="yes"
    fi

    if [ "$arg" == "--custom" ] || [ "$arg" == "-c" ]
    then
        adv="yes"	
    fi

   if [ "$arg" == "--dev" ] || [ "$arg" == "-d" ]
    then
        devcode="yes"	
    fi
    
    if [ "$arg" == "--remove" ] || [ "$arg" == "-r" ]
    then
        removal="yes"		
    fi

    if [ "$arg" == "--perm" ] || [ "$arg" == "-p" ]
    then
        fixPerm="yes"		
    fi

    if [ "$arg" == "--unsupported" ] || [ "$arg" == "-u" ]
    then
        nosupport="yes"		
    fi

done

#--------------------------------------------------------------------------------#
#-- Step 0 - Check that the script is run as normal user and not as root....
#-------------------------------------------------------------------------------#

if [[ $EUID -ne 0 ]]; then
	/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
	/bin/echo -e "\e[1;36m   !  Standard user detected....Proceeding....                   !\e[0m"
	/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
else
	echo
	/bin/echo -e "\e[1;31m   !-------------------------------------------------------------!\e[0m"
	/bin/echo -e "\e[1;31m   !  Script launched with sudo command. Script will not run...  !\e[0m"
	/bin/echo -e "\e[1;31m   !  Run script a standard user account (no sudo). When needed  !\e[0m"
	/bin/echo -e "\e[1;31m   !  script will be prompted for password during execution      !\e[0m"
	/bin/echo -e "\e[1;31m   !                                                             !\e[0m"
	/bin/echo -e "\e[1;31m   !  Exiting Script - No Install Performed !!!                  !\e[0m"
	/bin/echo -e "\e[1;31m   !-------------------------------------------------------------!\e[0m"
	echo
	#sh_credits
	exit
fi

#---------------------------------------------------#
#-- Step 1 - Try to Detect Ubuntu Version....       #
#---------------------------------------------------#

if [ "$nosupport" = "yes" ]; 
then 
    /bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
	/bin/echo -e "\e[1;36m   ! Unsupported OS Installation..Use at your Own Risk !!!       !\e[0m"
	/bin/echo -e "\e[1;36m   !-------------------------------------------------------------!\e[0m"
else
        check_os

fi

#--------------------------------------------------------#
#-- Step 2 - Try to detect if HWE Stack needed or not....#
#--------------------------------------------------------#

check_hwe

#--------------------------------------------------------------------------------#
#-- Step 3 - Check if Removal Option Selected
#--------------------------------------------------------------------------------#

if [ "$removal" = "yes" ];
then
	remove_xrdp
	echo
	sh_credits
	exit
fi

#---------------------------------------------------------------------------------------
#- Detect Standard vs custom install mode and additional options...
#----------------------------------------------------------------------------------------

	if [ "$adv" = "yes" ];
	then
		echo
		/bin/echo -e "\e[1;33m   |-| custom installation mode detected.        \e[0m"
		/bin/echo -e "\e[1;32m      |-| Previous Install Mode... :  $modetype      \e[0m"
		
		if [ $modetype = "custom" ];
		then 
			/bin/echo -e "\e[1;36m           |-| xrdp already installed - custom mode....skipping xrdp install        \e[0m"
			PrepOS
            install_common
		elif [ $modetype = "standard" ];
        then
            /bin/echo -e "\e[1;31m           |-| Cannot Mix Std vs Custom Install Mode....skipping xrdp install        \e[0m"
			
        else 
			/bin/echo -e "\e[1;36m           |-| Proceed custom xrdp installation packages and customization tasks      \e[0m"
			PrepOS
    		install_custom
            install_common
		
			#create the file used a detection method 
	     	sudo touch /etc/xrdp/xrdp-installer-check.log
			sudo bash -c 'echo "custom" >/etc/xrdp/xrdp-installer-check.log'
		fi		

	else
		echo
			/bin/echo -e "\e[1;33m   |-| Additional checks Std vs Custom Mode..       \e[0m"
            /bin/echo -e "\e[1;32m      |-| Previous Install Mode... :  $modetype      \e[0m"
		if [ $modetype = "standard" ];
		then 
			/bin/echo -e "\e[1;35m          |-| xrdp already installed - standard mode....skipping install  \e[0m"
			PrepOS
            install_common
		elif [ $modetype = "custom" ]
        then 
        	/bin/echo -e "\e[1;31m           |-| Cannot Mix Std vs Custom Install Mode....skipping xrdp install "
		else
			/bin/echo -e "\e[1;32m          |-| Proceed standard xrdp installation packages and customization tasks      \e[0m"
			PrepOS
			install_xrdp
			install_common
			
			#create the file 
			sudo touch /etc/xrdp/xrdp-installer-check.log
			sudo bash -c 'echo "standard" >/etc/xrdp/xrdp-installer-check.log'
		fi
	fi  #end if Adv option

#---------------------------------------------------------------------------------------
#- Check for Additional Options selected 
#----------------------------------------------------------------------------------------

if [ "$fixlogin" = "yes" ]; 
then
	echo
	custom_login
fi

if [ "$fixSound" = "yes" ]; 
then 
            enable_sound      
fi

if [ "$fixPerm" = "yes" ]; 
then 
            Check_Perm      
fi

#---------------------------------------------------------------------------------------
#- show Credits and finishing script
#--------------------------------------------------------------------------------------- 
sh_credits 
