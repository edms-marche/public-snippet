# xRDP – Easy install xRDP on Ubuntu 20.04,22.04,24.04,24.10 (Script Version 1.5.3) – Griffon's IT Library

![](https://c-nergy.be/blog/wp-content/uploads/xrdp-1.5.3.png)

# xRDP – Easy install xRDP on Ubuntu 20.04,22.04,24.04,24.10 (Script Version 1.5.3)

[January 18, 2025January 18, 2025](https://c-nergy.be/blog/?p=20178) [Griffon](https://c-nergy.be/blog/?author=1)

Hello World ,

In one of our previous post (see [xrdp – New release available (0.10.2)](https://c-nergy.be/blog/?p=20148)), we have advertise the fact that a new release of xrdp has been made available quite recently.  Since a new release of the package was made availabe, we have decided to run some basic tests using our famous xrdp-installer script.  We were expecting that everything would be fine and only a few minor adjustment would be needed.  

After performing our testing, we have indeed discovered that the latest xrdp package (0.10.2) impact the installation process when using the xrdp-installer script **version 1.5.2**.  So, to solve or tackle these small issues, we have decided to release a new version of the script.   We are releasing the **xrdp-installer script version 1.5.3.**  The script should be seen as a maintenance release where no new features have been added.  This release will simply fixing some minor issues 

So, let’s see what’s new in this release…:)

# Overview

By now, you should know that the **xrdp-installer** script aim to ease installation and post-configuration actions of xRDP on top of Ubuntu Operating system.  xRDP is a piece of software that enable remote desktop services on Linux.   This means that windows users can use their Remote desktop client (mstsc) and perform a remote connection to Ubuntu Computer.   

## What’s new in this release (Version 1.5.3) ?

### End of Support for Debian 10 

Debian 10 reached **End of Life in June 2024**.   The script will not block the installation against Debian 10 but since this operating system is obsolete, there will be no more investigation or support or bugfix releases for this operating system.  

### Additional Check to see if xrdp-sesman service needs to be created or not 

As mentioned in our previous post ([xRDP – Quick test xrdp-installer-1.5.2 running against xrdp release 0.10.2….](https://c-nergy.be/blog/?p=20159)),  the xrdp services are created differently on Ubuntu 24.10.  The systemd file is not used for the xrdp-sesman service and it is now controlled via the /etc/init.d/xrdp service “file”.  In order to avoid the warning message when the script is running against Ubuntu 24.10, we have created an additional check to see how the xrdp services are managed.   

### Installing libfuse3-dev package (requirement for xrdp 0.10.2)

The updated version of the script will install an additional package which is required to have xrdp 0.10.2 working as expected.  As mentioned in our previous post ([xRDP – Quick test xrdp-installer-1.5.2 running against xrdp release 0.10.2….](https://c-nergy.be/blog/?p=20159)), if you run the old version of the script,  it will complain that a dependency is missing.  The script version 1.5.3 take this into account and install the missing package.  xrdp-installer-1.5.3 install the libfuse3-dev package automatically when performing a custom installation… 

### Additional check for Ubuntu 24.10

If you perform a standard installation of xrdp against Ubuntu 24.10, chances are that will end up with an incompatible installation.  The same scenario would occur if you perform the installation manually using the xrdp pacakge from the ubuntu repository.  As mentioned in our previous post ([xRDP – Quick test xrdp-installer-1.5.2 running against xrdp release 0.10.2….](https://c-nergy.be/blog/?p=20159)),  you can detect this issue by looking at the xorgxrdp.xx.log file.  This file will include information about incompatible version.

To overcome this situation, we have modified the script and when the script detect Ubuntu 24.10,  it will stop running and inform you that you would need to run a custom installation in order to have a working xrdp installation.   

### Pop!\_OS 24.04 not supported (yet)

Pop!\_OS 24.04 is still not officially available as general release.  We have played a little bit with the alpha version.  So far, the xrdp script is not working against the new Cosmic Desktop interface.  The script is executing as expected.  However, when trying to connection via xrdp, the user are disconnected immediately.  We will investigate a little bit further if time permits but the message here is that this specific version is not supported ! 

# How to Use the Script

The **xrdp-installer-1.5.3** script will work in a similar way as the previous versions. The following section will explain how to download, extract, set executable mode and perform the installation using the script.  The script provides some switches that can be used to customize the installation process.  

So, let’s see how this would be working…. 

## Disclaimer

The script is provided **AS IS**.  Use it at **your own risk** !!! 

## Prerequisites and assumptions  

The following conditions should be met in order to have the best results while using the script

-   We assume that your machine is connected to internet while performing the installation.  This is needed as additional packages and software needs to be downloaded and installed on your Ubuntu machine

## Script version & Supported Ubuntu Version

The **xrdp-installer-1.5.3.sh** script will support the **following Ubuntu operating system** version assuming that **Gnome Desktop is the default Desktop** interface

-   Ubuntu 20.04.x
-   Ubuntu 22.04.x
-   Ubuntu 24.04.x
-   Ubuntu 24.10.x (only if you select custom mode installation !!!) 
-   Debian 11 (only if you select custom mode installation !!!) 
-   Debian 12
-   **Zorin OS** 

The **xrdp-installer-1.5.3.sh** script can be run against the following **Ubuntu flavors** but we **cannot guarantee that everything** will work as expected **(best effort)**

-   Kubuntu (20.04 and later)
-   Ubuntu Budgie (20.04 and later)
-   Ubuntu Mate (20.04 and later)
-   Xubuntu (20.04 and later)
-   Lubuntu (20.04 and later)  
-   Linux Mint (Experimental at this stage)
-   LMDE (Experimental at this stage) 
-   Pop!\_OS  22.04 

_Note :  If you are running any of these distributions and you want to help us improving the support on those, please download and test the script.  Do no hesitate to share your findings so we can try to incorporate them in the next release_ 

## Step 1 – Download the script

To download the script, you have multiple options.   You can from a Terminal issue the following command 

> **wget https://www.c-nergy.be/downloads/xRDP/xrdp-installer-1.5.3.zip**

You can also simply use your browser and click on the link to download the script :  

-     [xrdp-installer-1.5.3.zip](https://c-nergy.be/downloads/xRDP/xrdp-installer-1.5.3.zip) 

## Step 2 – unzip the file 

After downloading the zip package containing the file, you will need to unzip it first. To unzip the package, you can use the Terminal console and issue the following command 

> **unzip xrdp-installer-1.5.3.zip** 

You can also use the GUI and the Nautilus file manager to select the downloaded package, right-click on it and select the option **Extract Here**

## Step 2 – Set Execute Right on the script

Download the **xrdp-installer-1.5.3.sh** script to your system, extract content and mark it as executable . To do this, perform the following action in a terminal console

> **chmod +x  ~/Downloads/xrdp-installer-1.5.3.sh**

_Note : Adjust the path where the **xrdp-Installer-1.5.3.sh** script to reflect your_ _environment_

## Step 2 – Run as normal user 

The script **needs** to be **run as a normal user**.  The script will start running and will prompt you for password when sudo actions are initiated.  If you run the script as root or using sudo command, the Download folder does not exist for the root user and the script fails to run as expected.   To overcome this situation, the script also check which user is executing the script. If the script is run under sudo or root accounts, a warning message will be displayed and the script will not execute

## Step 3 – Switches and parameters 

The **xrdp-installer-1.5.3.sh** script can be executed as is (**with no parameters or switches**). This will perform a standard (and basic) installation of xRDP.  No sound or custom xrdp login script will be made available.  However, remote desktop, drive redirection and clipboard redirection would be available with this installation mode.  

The **xrdp-installer-1.5.3.sh** script accept also some additional parameters that will help customize the xrdp installation and enable additional features.  The script provides the following parameters 

> **\--help or -h          => will display a basic help menu**
> --sound or -s         => will enable sound redirection 
> --loginscreen or -l   => will customize the xRDP login screen 
> --remove or -r        => will remove the xrdp package 
> --custom or -c        => will perform a custom installation (i.e. compiled from sources)
> --dev or -d           => will perform a custom installation using dev branch (unstable version)
> --unsupported or -u   => will bypass the Check os and will run against unsupported os (use it at your own risk!!)
> --perm or -p          => fix permissions on xrdp files (uncommon situation)

## Step 4 – Perform xRDP installation using the script 

The following sections will provide some examples and scenario on how you can use the script….. 

### Standard Installation – No Parameter

As mentioned above, you can decide to use the default xrdp package available in the Ubuntu repository and perform a basic installation which will provide you remote desktop capability and will also customize the remote sesssion.  The script will ensure that the same look n’ feel will be maintained when the user logs on locally or remotely. 

To perform a **standard installation**, you execute the script with **no parameters**.  Open a **Terminal console**, browse to the location where the script has been downloaded and issue the following command 

 **./xrdp-installer-1.5.3.sh**

When the xrdp installation package will start, you be requested to **enter your password.** Provide the password and proceed with the installation. Wait for completion of the script.  The machine **will not reboot automatically** when done so you can review the actions performed by the script….

### Standard Installation with Parameters

The script can be used to perform a standard installation and still passes some parameters to get the most of the xRDP packages and their features.  For all the Ubuntu versions, we could use the following combination of parameters 

> **./xrdp-installer-1.5.3.sh -s**      (this would enable the sound redirection) 
> **./xrdp-installer-1.5.3.sh -l **     (this would customize the xrdp login screen -see [here](http://c-nergy.be/blog/?p=13686))

Obviously, you can combine the switches (any order) to have more features enabled  

> **./xrdp-installer-1.5.3.sh -s -l**      (this would enable the sound redirection and customize the xrdp login screen)

_**Important Notes**_

_The script **can be run multiple** times on the same machine.  If you have run initially the script with no parameters but you decide afterward to enable additional features, the script can be re-executed and the additional features will be enabled._  

### Custom Installation – Default Installation 

Custom installation script is really flexible. Custom installation means that the script will compile the xrdp package from the source binaries. The custom installation script always uses the latest xrdp package version available 

To perform a **custom installation**, you will need at minimum to pass **one parameter**.  The following command line shows you how to perform a custom installation  

> **./xrdp-installer-1.5.3.sh -c**     (this would perform a custom installation but will not enabled adv features like sound redirection or custom login screen)

### Custom Installation – Additional Options  

If a user wants to enable additional features, you will pass some additional parameters as shown in the following examples 

> **./xrdp-installer-1.5.3.sh -c -s**     (this would perform a custom install and enable sound redirection)
> **./xrdp-installer-1.5.3.sh -c -l**     (this would perform a custom install and customize xrdp login screen)
> **./xrdp-installer-1.5.3.sh -c -l -s**  (this would perform a custom install, enable sound and customize login screen)
> **./xrdp-installer-1.5.3.sh -c -d    ** (this would perform a custom install, using unstable/dev version of xrdp packages -xrdp 0.10.80)

_**Important Notes**_

_The script **can be run multiple** times on the same machine.  If you have run initially the script with no parameters but you decide afterward to enable additional features, the script can be re-executed and the additional features will be enabled._  

### Remove Installation option

This version of the script also ship with the option to remove xRDP package.  The removal option should be only used  if you have uses this version of this script to perform the installation.  To remove the xrdp package, you would simply execute the following command  

> **./xrdp-installer-1.5.3.sh -r**     (to remove the xrdp packages)

## Step 5 – Test your configuration 

After the script has run and after the reboot/shutdown and start process, it’s time to test and see if you can indeed perform a smooth remote connection to your Ubuntu machine.  Start your favorite rdp client and simply enter your credentials and start testing your installation.  If everything is ok, you will see a similar Desktop interface where Gnome Desktop is used and the Dock is visible. 

# Limitations

## Switch between standard and Custom install

This version of the script can be run multiple times on the same machine.  However, because of this new behavior, you cannot perform a standard installation and then decide to perform the custom installation.  Once you have selected your installation mode, you will have to stick to it.  This is kind of checked by the script.  

So, if you have performed a standard installation but afterwards you might want to use the custom installation option, the script will ignore the request.  If you want to move from standard install mode to custom mode (or vice versa), the correct process is 

-   remove xrdp (using the xrdp-installer-1.5.3.sh -r option) 
-   Reboot
-   perform a new installation using your selected installation mode (standard or custom install mode) 
-   Reboot

# Known issues, Fixed Issues and limitations, New Behavior 

## Known Issues 

### Black Screen or disconnected immediately after connecting

As mentioned and explained multiple times,  this situation will happen (or can happen) when the same user account is used concurrently locally and remotely.  In other words,  the problem is related to the fact that the **same user account** is already logged in locally and a remote connection is attempted at the same time.  With xRDP software solution, a specific user account can be logged on either **locally or remotely** but not both….  

**Ubuntu 24.04** seems to have introduced a small change when such situation would happen.  If the user is remotely logged on via xRDP software and if the same user tries to login locally, he will be presented with the following popup (see screenshot) 

[![RemoteLoginMsg](https://c-nergy.be/blog/wp-content/gallery/ubuntu24-04/cache/RemoteLoginMsg.png-nggid045088-ngg0dyn-320x240x100-00f0w010c010r110f110r010t010.png "RemoteLoginMsg")](https://c-nergy.be/blog/wp-content/gallery/ubuntu24-04/RemoteLoginMsg.png)

_Click on Picture for better Resolution_

The only problem is that if you click **Force Stop** button, it seems not to work.  The remote session is not killed.  We have not tried this on older Ubuntu releases but I think this is because of the gnome-remote-login addition in **Gnome 46**.  

If a user is logged on locally and if the same user tries to perform a remote connection to the machine, the user will get informed about an existing session already running as shown in the screenshot below

[![RemoteLoginMsg2](https://c-nergy.be/blog/wp-content/gallery/ubuntu24-04/cache/RemoteLoginMsg2.png-nggid045089-ngg0dyn-320x240x100-00f0w010c010r110f110r010t010.png "RemoteLoginMsg2")](https://c-nergy.be/blog/wp-content/gallery/ubuntu24-04/RemoteLoginMsg2.png)

_Click on Picture for better Resolution_

Again, here there is no way to stop the existing session.  You will need to logout locally from the session or you will need to find other ways (such as ssh or another user account) that can be used to disconnect the existing session.

# Final Notes

This is it for this post !   

The script version has not been tested extensively but it should work in most cases.  The script should be seen as a **latest stable release version**.  Please if you have time or want to help us in creating the **best xRDP installer script**, download the script, test it and provide constructive feedback.  If you find a bug or an issue with the script, let us know as well so we can try to fix it.   

Till next time 

See ya  

## 41 thoughts on “xRDP – Easy install xRDP on Ubuntu 20.04,22.04,24.04,24.10 (Script Version 1.5.3)”

1.  It installs 0.9.17 version for Ubuntu 22.04 but not 0.10.2  
    Is it predictable?
    
2.  Hello, I have just missed parameter -d in my previous message.  
    Ultimately, xrdp 0.10.8 has been installed.
    
    Thank you for your efforts
    
3.  @Oleg,
    
    Thank you for visiting our blog and sharing some feedback. So, please read the blog fully in order to get full picture of how the script works  
    So, if you have version of xrdp set to 0.9.17 => you have performed a standard installation and the package that is used is the one in the distro repository
    
    You have to use switch or parameters to perform the installation (./xrdp-installer-1.5.3.sh -c )
    
    Till next time  
    See ya
    
4.  @Oleg,
    
    So, again to clarify, if you perform install using the -c switch => custom installation where the latest stable package is used (i.e. xrdp – 0.10.12)  
    if you perform the install using -c -d switch => custom installation of xrdp where you connect to the dev branch (which version is always 0.10.80)
    
    Till next time  
    see ya
    
5.  worked a treat, thanks
    
6.  @Martin,  
    Thank you for visiting our blog and sharing your experience. happy to see that the script is still working 🙂
    
    Till next time  
    See ya
    
7.  after connecting after a few seconds popup: “error connection to sesman on sesman socket”  
    after that session closes
    
8.  after connecting after a few seconds popup: “error connection to sesman on sesman socket”  
    after that session closes  
    ubuntu 24.10  
    i tried -c (req because of the ubuntu ver) and -c -d  
    same results
    
9.  @max2veg,
    
    Thank you for visiting our blog and sharing your experience and issues. So, never had this issue..so far and cannot reproduce at this stage… can you provide a screenshot of the error ?  
    Can you also provide the logs /var/log/xrdp.log and /var/log/xrdp-sesman.log  
    We would also need the logs from the user profile trying to connect (~/.xorgxrdp.xx.log) and ~/.xsession-errors
    
    Have you checked that the service is up and running ? have you tried a reboot first and tested again ?
    
    Waiting for your feedback so we can start investigate
    
    Till next time  
    See ya
    
10.  ty @griffon, i hadn’t tried rebooting, i’m re-installing w/ -c -d now.
    
    i did notice this time around that during “downloading xrdp binaries…” stage it stopped and broke (due to me having currently very poor wifi and no access to wired) and i had to keep and eye on the dl and ctrl-c the script when it’d notice “fatal…” and “error…” due to the connection timing out. after restarting the script, it does not resume the download, ending up in a repeating cycle of the above.
    
11.  i fixed my issue w/ broken downloads (git clone):
    
    git clone –depth=1 …  
    git fetch –depth=2  
    git fetch –unshallow
    
12.  @Max,
    
    Thank for the feedback… happy that you have found a way to get the download working… based on your feedback, we will try to update the script and improve error handling so if the download fails, the script would simply exit and a warning message will be displayed
    
    Thanks again
    
    Till next time  
    see ya
    
13.  Just like version 1.5.2, got it to work with Elementary OS 7.1 Horus. Here’s the script with modifications to support the distro: [https://gitlab.com/-/snippets/4799057](https://gitlab.com/-/snippets/4799057)
    
14.  FYI xrdp-installer-1.5.3.sh -c -d worked on Linux Mint 22.1
    
15.  @RipXrip;
    
    Thank you for visiting our blog and providing feedback… Good to know that the script is also working with the latest Linux Mint version
    
    Till next time  
    See ya
    
16.  @tetebueno;
    
    Thank you for visiting our blog and providing some feedback. We are happy to know that the script is also working with Elementary… we might will include this os as supported list of OS….
    
    Till next time  
    See ya
    
17.  Hello, are this works for antiX os?
    
18.  @Joe;
    
    Thank you for visiting our blog and sharing your interest. Never tried to run the script on AntixOS. This script is not supported by the script. You can try to run the script using the switch -u (for unsupported setup) and give it a try… it might work or might not
    
    hope this help  
    Till next time  
    See ya
    
19.  Linux Mint 22.1 Cinnamon  
    Custom Installation  
    ./xrdp-installer-1.5.3.sh -c -s
    
    installed and working with no errors
    
    Thank you,  
    ripxrip
    
20.  how do you go about enabling multiple sessions (2 users logged in simultaneously)?
    
21.  @afx,
    
    Thank you for visiting our blog and sharing your experience with us… You do not need to do anything if you want to multiple users remotely login to your linux machine if you use xRDP. let’s be more precise.. as long as different user account are used, each user should be able to get a remote session on the server. If you are trying to have the same user connected into the remote session and the local console session, this is not possible at this stage
    
    Hope this answer your question  
    Till next time  
    See ya
    
22.  @ripxrip,
    
    Thank you for visiting our blog and providing feedback. The script is supporting linux mint. .. Thank you for confirming that the latest version of linux mint is also working as expected.
    
    Till next time  
    See ya
    
23.  After installing the script in custom mode in Kubuntu 24.10, ordinary users no longer have the option to turn off and reboot the computer from the menu. Deleting the file /etc/polkit-1/rules.d/48-allow-flatpak.rules returns the ability for ordinary users to turn off and reboot the computer again.
    
24.  @SimlyUser,
    
    Thank you for visiting our blog and providing feedback. So, we are not heavy users of KDE desktop and we didn’t notice this issue. so thank you for reporting it. we will look if we can tweak the script and add some additional rules (polkit) that would take that into account
    
    Till next time  
    See ya
    
25.  ‘ve installed XRDP on a Ubuntu 22.04 LTS VM using the script version 1.5.3 (Ubuntu Gnome Desktop)
    
    When I try to login RDP closes directly after I enter the (correct) password.
    
    I’ve verified the PAM authentication, network – everything looking fine.
    
    In the xrdp.log and xrdp-sesman.log I just see that a session is created and then closed.
    
    I can log in just fine via SSH using the same account as well as to the Desktop using the VM console.
    
    However in xorgxrdp.10.log I see the following lines :
    
    \[ 52.571\] (II) systemd-logind: logind integration requires -keeptty and -keeptty was not provided, disabling logind integration
    
    \[ 52.571\] (II) xfree86: Adding drm device (/dev/dri/card0)
    
    \[ 52.571\] (EE) /dev/dri/card0: failed to set DRM interface version 1.4: Permission denied
    
    \[ 52.573\] (–) PCI:\*(0@0:15:0) 15ad:0405:15ad:0405 rev 0, Mem @ 0xf0000000/134217728, 0xfb800000/8388608, I/O @ 0x00002140/16, BIOS @ 0x????????/131072
    
    And a bit later:
    
    \[ 52.580\] rdpPreInit:
    
    \[ 52.580\] rdpPreInit: /dev/dri/renderD128 open failed
    
    It looks like xorg is lacking permissions to access the graphics devices.
    
    Changing permission to 660 to card0 and renderD128 didn’t help
    
    I’ve found tons of references to this permission issue dating back several years, but no fix related to XRDP.
    
    root@xxx-xxxxxx:/dev/dri# ls -la
    
    total 0
    
    drwxr-xr-x 3 root root 100 Feb 18 17:34 .
    
    drwxr-xr-x 19 root root 4340 Feb 18 17:34 ..
    
    drwxr-xr-x 2 root root 80 Feb 18 17:34 by-path
    
    crw-rw—-+ 1 root video 226, 0 Feb 18 17:34 card0
    
    crw-rw—-+ 1 root render 226, 128 Feb 18 17:34 renderD128
    
    Any ideas highly appreciated !
    
26.  For the options “-c -s -l” I had to change in the “Function 7” block twice from
    
    sudo ./bootstrap  
    sudo ./configure xyz  
    sudo make
    
    to
    
    ./bootstrap  
    ./bootstrap  
    ./configure xyz  
    make  
    sudo make install
    
    Double bootstrap because it would report “ltmain.sh” missing, despite being copied to multiple folders.  
    Removing sudo and adding only to “make install” because else it would say “make: no target install” on Ubuntu 24.04 LTS. Custom install because normal and develop install would use version 0.9.24 instead of 0.10.2.
    
27.  @Dor,  
    thank you for visiting our blog and providing feedback… strange indeed. we will check this and see if we can find the root cause
    
    Till next time  
    See ya
    
28.  works well in MX-Linux 23.5 XFCE  
    just remember to install xorgxrdp before running the script.
    
29.  @Dan,  
    thank you for visiting our blog and providing feedback. For info, the script will download and install xorgxrdp if you are using the custom install mode
    
    Till next time  
    See ya
    
30.  Hi guys, when not using gnome/kde the following error occurs:
    
    \> ./xrdp-installer-1.5.3.sh: line 243: \[: =: unary operator expected
    
    So please fix line 243 from…
    
    \> if \[ $DESKTOP\_SESSION = “lightdm-xsession” \]
    
    …to…
    
    \> if \[ “$DESKTOP\_SESSION” = “lightdm-xsession” \]
    
    (notice the quotation marks around a possibly-non-existant variable)
    
31.  The current system seems to lose the keyboard variant on a reconnect; not sure if this is an xrdp thing or a script thing. I’m using the Windows RDP client to connect to an Ubuntu 24.04 host on which this version (1.5.3) of the script has been installed. On the Ubuntu system I have the dvorak variant of the us layout. When I first start a session, everything works. But if I close the Windows RDP client, and then re-open it, the initial login screen lets me type in dvorak but then the session itself reverts to the qwerty layout. I do get correctly connected to my existing session and as a workaround I can execute “setxkbmap -layout us -variant dvorak” to restore the dvorak but that shouldn’t be necessary.
    
    On the first connection, everything works and “setxkbmap -query” shows:  
    rules: base  
    model: pc105+inet  
    layout: us  
    variant: dvorak
    
    After reconnecting, the same command shows:  
    rules: base  
    model: pc104  
    layout: dvorak
    
    It looks something is trying to set the layout to dvorak but it’s getting it wrong.
    
32.  The script is available in a version based on the xrdp-egfx branch, which has been tested in the real world This version has excellent graphics performance and a low enough bandwidth footprint.
    
33.  @Thorsten,
    
    Thank you for your feedback and visiting our blog… We are preparing the version 1.5.4 of the script and we will update the script in order to take into account your discovery… Thank you
    
    Till next time  
    See ya
    
34.  @Brent,
    
    Thank you for visiting our blog and providing some feedback…. We have encounter this issue in the past.. This can be because you have on your windows system multiple keyboard layout or it might be related to the issue described on this post ([xRDP – Strange issue with Keyboard layout and how to fix it (Really Rare)](https://c-nergy.be/blog/?p=17223)). This is rather an old post which might not apply anymore….
    
    When time permit and when we encounter the issue, we will try to investigate a little bit further and possibly provide a workaround to fix this…
    
    Till next time  
    See ya
    
35.  @elsu,
    
    Thank you for the feedback and sharing the info with you…We never tried this branch…but we will give it a try and see how this is working
    
    Till next time  
    See ya
    
36.  I’m using Ubuntu 24.10 and have installed xrdp with the -c switch.  
    There seems to be a problem with how the xrdp service is managed. It might be related to you mentioning that the service is now using a script in init.d instead of the usual xrdp and xrdp-sesman systemd unit files. What I have observed is that sometimes the xrdp service fails to start up, complaining that the address is already in use. When I look at the output of \`ss -lptn ‘sport = :3389’\` it gives me the output that there’s already a process like \`users:((“xrdp”,pid=757754,fd=6)) \` running. When killing it, restarting the xrdp service works. Something about that script seems broken. I find it weird that it is using this method to begin with, on the xrdp repository there are still the normal unit files here: [https://github.com/neutrinolabs/xrdp/blob/devel/instfiles/xrdp.service.in](https://github.com/neutrinolabs/xrdp/blob/devel/instfiles/xrdp.service.in) shouldn’t it just use those?
    
37.  @Vic,
    
    Thank you for the feedback and for visiting our blog. As you mentioned, we have also noticed an issue with the xrdp service and systemd… We didn’t had time to look into this one but we will with the next release of the xrdp-installer script.. We will check if the issue still exists with Ubuntu 25.04 or not. If still exists, we will try to come up with a quick fix
    
    **Updated – April 2025**  
    We have checked the repo and performed a manual installation. it seems that the files are not copied over during the build process. The files in the repo are using variable (@sysconfig@/…) to perform the configuration. So if you simply copy the files from the repo, it will not work, you will need to update these files accordingly…you might want to file a bug with xrdp team
    
    Hope this help
    
    Till next time  
    See ya
    
38.  @Griffon  
    I have created an issue over at the xrdp repo, see here: [https://github.com/neutrinolabs/xrdp/issues/3497](https://github.com/neutrinolabs/xrdp/issues/3497)  
    I don’t know if you need to change the script, but it seems like the issue is going to get fixed.  
    Thanks a lot for your amazing work!
    
39.  Sorry works for 25.10 with -c -u
    
40.  @Vic,
    
    Thank you for feedback and letting us know about this….. So, we have seen that indeed feedback has been provided and that the issue should be fixed. We are releasing the next version of the xrdp-installer-1.5.4 based on the old code.. We will try to work on an update in integrate also the changes in the way xrdp services are working
    
    Keep in touch  
    Till next time  
    See ya
    
41.  @Andrii,
    
    Thank you for the feedback. Yes, you can use the -u parameter to bypass the OS Check and check that previous version of the script still run against newer version of Ubuntu… However, we are releasing on regular base updates for the script to include new Ubuntu releases. We are about to release xrdp-installer-1.5.4 that includes support for Ubuntu 25.04…. You should try the latest version as well and possibly report any issue that you might encounter so we can fix it as we go
    
    Till next time  
    See ya
    

### Leave a Reply

Comment \*

Name \* 

Email \* 

Website
