+++
date = "2018-06-14T12:00:00+02:00"
draft = false
title = "NixOS: The distribution I got to love"
+++
As I started my PhD studies I was faced with the choice of deciding my own hardware setup for the next 3 years, as long as I used the bureaucratic supply contract and kept a certain budget.
I could easily see that getting a 15" MacBook Pro and an external monitor would blow the budget, so I quickly decided I wanted to adopt Linux full-time.
At my previous company, [Tryg](https://tryg.dk), I used the new 15" MacBook Pro with Touch Bar.
Needless to say, the touch bar is god awful and is simply a tool to steal space from relevant components (e.g. media keys).
With that frustration in mind, I decided to picking up the **Lenovo ThinkPad T470s**.

<p align="center">
<img style="margin: 50px auto; display: block; width: 70%" src="/img/t470s.jpg">
</p>

## Choice of Distribution
It was my first time trying to run Linux full-time, as I previous had used OSX for more than 7 years.
During my time in high school one of my classmates was actually the owner and administrator of [the danish Arch Linux community](http://www.archlinux.dk/).
Back then I definitely did not have the skills required to pursue any hand-tailored Linux like [Arch Linux](https://wiki.archlinux.org/index.php/Arch_Linux), but luckily after receiving my computer science degree, the thought does not seem that frightening to me anymore.
Through my education, I started to appreciate minimalism and the ability to pick-and-choose **only** the tools you *actually* need.
However, I was aware of some the pitfalls that comes with the rolling release nature of Arch, and the thought of my computer suddenly malfunctioning one day, and the entire time spend configuring it being lost, was scary.

I then started my search for minimal alternatives, especially ones that could reduce the configuration overhead that typically comes with Arch Linux, Gentoo, and alike.
This was when I discovered [NixOS](https://nixos.org/), and when first read the description I was unsure whether the feature promises was too good to be true.
It claimed that it was "Declarative" (e.g. less time configuring) and "Reliable" (atomic upgrades and rollbacks) was it truly too good to be true?
I had to dig in to find out.

## NixOS

<p align="center">
<img style="margin: 50px auto; display: block; width: 30%" src="/img/nixos_logo.png">
</p>

NixOS is a very different Linux distribution than *the classical ones* (Ubuntu, Debian, Arch, etc.).
It relies heavy on the [Nix package manager](https://nixos.org/nix/), which is available as a standalone binary for Unix distributions.
However, in NixOS, its use has been taken the next level as it functions as a center piece for package management **and** configuration management.
Essentially, Nix is declarative programming language and NixOS evolves around having a single `configuration.nix`-file of this language, that is responsible for *declaring* your environment in the Nix programming language.
Like other programming languages, you can reference other language files and thereby let your `configuration.nix` reference other Nix-files and decompose your system configuration.
When you run the `nixos-generate-config` during install, you will be receiving a `configuration.nix` file that looks like the following:

```nix
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # ...

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];
  
  # ...

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # ...

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
}
```

I left out some of the commented options to shrink the size for visibility, but I think this default `configuration.nix`-file give a sense of how and the extend the Nix language can configure your system.
For a complete list of options visit the [Nix Option site](https://nixos.org/nixos/options.html#).
When you modify the your `configuration.nix`-file and want the changes to take effect, you use the `nixos-rebuild {switch, boot}` command in order to migrate to a new system configuration directly or on next boot respectively.
I highly encourage you to read the [well-written manual](https://nixos.org/nixos/manual/), and you can find my personal `configuration.nix` in [my dotfiles repository](https://github.com/tpanum/dotfiles/tree/master/nix).
It is current about 600 lines, and I run a very minimal environment with just a window manager and a bit of [ricing](https://www.reddit.com/r/unixporn/).
So currently I have a setup which sits at about ~1 GB RAM usage on boot with [Emacs](https://www.gnu.org/software/emacs/), [i3wm](https://i3wm.org/), and Firefox Quantum.


## Aftermath
Right now I am typing this article on my T470s running NixOS, and I am about six months into the adventure.
Was it everything I hoped for? Definitely!
During my adventure I had to upgrade my single drive laptop to a 1 TB drive, which lead me to try the reproducibility of NixOS and it went smoothly.
It has been a bit of wild ride and the rolling updates managed to break my system twice, however, the rollback functionality made sure that no unrevertable harm was made.
Overall, I can highly recommend trying out NixOS and often find my self wondering it has not gotten more tracking since its first release in 2003.
