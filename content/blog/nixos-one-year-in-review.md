+++
date = "2019-01-10T12:00:00+02:00"
draft = false
title = "NixOS: One Year In (I'm still in love)"
+++

As I have written in a [previous post](/blog/nixos-the-distribution-i-got-to-love), I switched to [NixOS](https://nixos.org/) from [OS X](https://en.wikipedia.org/wiki/MacOS).
I have now been using it for 13 months, and wish to my general desktop configurations and experiences.

### Desktop Environment? Window Manager?
Most Linux users are very avid to either discuss or highlight the Desktop Environment (DE) or their use of a minimalistic use of a Window Manager-only setup (VM).
The discussions can, even as a senior engineer, become quite loopy and feel without ending at times.
In case you are curious about it, head over to [/r/unixporn](https://www.reddit.com/r/unixporn/) (I'm a shameless fan) or [/r/linuxmasterrace](https://www.reddit.com/r/linuxmasterrace/) and get your dose of nerdy discussions.

Except from the avoidance of endless discussions, I am sadly not that different, I have tried an unhealthy dose of DEs and WMs over the last year.
However, I haven't changed my setup dramatically within the last six months, which I hope is a sign of me converging to an ideal solution for me.
Thankfully, [NixOS](https://nixos.org/) makes in incredibly easy to try out different DEs and VMs, and it even cleans up after it self leaving you without dangling packages(!).
I have been through a couple, firstly: [KDE Plasma](https://www.kde.org/) and [GNOME3](https://www.gnome.org/).
After using Plasma briefly, the design of GNOME appealed more to me as it felt more intuitive to me personally.
I stuck with GNOME for a couple of months, before [getting annoyed by the fact that configurations are being stored on a database](https://wiki.gnome.org/Projects/dconf) while also getting persuaded by [/r/unixporn](https://www.reddit.com/r/unixporn/) to try [bspwm](https://wiki.archlinux.org/index.php/bspwm).

Booting with bspwm for the first time, to realize that [sxhkd](https://wiki.archlinux.org/index.php/Sxhkd) (hotkey daemon) does not have any default configuration in case of no configuration file [*seriously, what can of default behaviour is that?*] leaving your keyboard completely paralyzed.
Resolving that issue, let me to use bspwm for coupe of weeks until realizing time consuming process of implementing almost every single key binding from scratch. This let me to move on to the more user-friendly [i3](https://i3wm.org/), which has some sane defaults.

Where are we today? As of writing, I have been using the [bspwm](https://wiki.archlinux.org/index.php/bspwm) + [sxhkd](https://wiki.archlinux.org/index.php/Sxhkd) cocktail for over six months.
*But didn't you move away from bspwm, due to its heavy requirement?* Yes, but that was also what I ended up missing.
Realizing the unchangeable quirks of many other hotkey daemons, I realized how I missed sxhkd's ability to do *exactly like I wanted*.

<p align="center">
<a href="/img/my_desktop_2019.png">
<img style="margin: 50px auto; display: block; width: 70%" src="/img/my_desktop_2019_small.png">
</a>
</p>

### Cmd+C, Cmd+V

The switch back to bspwm was heavily driven by one of the concepts I missed the most about running OS X, the elegant integration of the `cmd` key.
Despite the typical anti-Apple movement of Linux users, some design choices in OS X are deeply elegant, with one of the most overlooked ones being the hotkey daemon.

For those who have never used OS X, or in clear what I hint towards, let's start off with an example.
Most developers spend a decent amount of time in the terminal, for which the `ctrl` key has a very distinct behaviour, namely the fact it is used to [send signals](https://en.wikipedia.org/wiki/Signal_(IPC)), e.g. canceling execution with `ctrl-c` (`SIGINT`).
This often interveins with typical application-based shortcuts, e.g. `ctrl-c` (app: `copy`, term: `SIGINT`). 

This leads to the shortcut in most terminal applications for `copy` is either `ctrl-alt-c` or `ctrl-shift-c`.
However, on OS X, it is a much more cohesive experience as typical application shortcuts are performed with `cmd`, e.g. `cmd-c` is `copy`.
This simply elegant design, and well thought out.
For many months I tried to replicate this behaviour to Linux, however, it is slightly non-trivial as most shortcuts are directly baked into the applications.

However, sxhkd in combination with a bit of clever scripting actually got me some places.
I have bound my `super-c` to the following script (with a replica for `paste` on `super-v`).
``` bash
CURRENT_WINDOW=$(xprop -id $(xdotool getwindowfocus) WM_CLASS | awk '{ print $3 }' | cut -d '"' -f2)
if [ "$CURRENT_WINDOW" = "Alacritty" ]; then
    xdotool key --delay 0 --clearmodifiers ctrl+shift+c
else
    xdotool key --delay 0 --clearmodifiers ctrl+c
fi
```
Not as cohesive as the OS X experience, but it works like I want, and allow me to use (`super-c`, `super-v`) to (`copy`,`paste`) in any application.
	

### File Manager: fzf

Another small modification that I use a lot for my daily tasks, is a customized [fzf](https://github.com/junegunn/fzf) script.
That, in combination with `cp` and `mv` (and getting used naming files in a unix friendly way) made my need for a file manager completely obsolete.
In short, it is a script that activates `fzf` on my home directory, for which it pipes the result to [mimeo](https://xyne.archlinux.ca/projects/mimeo/).
The script is very efficient (thanks to `fzf`) at searching, even in deeply nested directories, and is being activated with `super+d`.
You can see a preview of the whole process below, and find the script.

<p align="center">
<a href="/img/fzf-open.gif">
<img style="margin: 50px auto; display: block; width: 100%" src="/img/fzf-open.gif">
</a>
</p>

``` bash
#!/run/current-system/sw/bin/bash
IFS=':'

get_selection() {
    find ~ -type d ! -readable -prune -o -print | fzf --reverse --color pointer:3,info:14,bg+:-1
}

if selection=$( get_selection ); then
    nohup mimeo "$selection" >/dev/null 2>&1 &
    sleep 0.05
fi

echo -ne ' '
exit 0
```
Beware! the script contains a bit of color configuration to match my personal [nord theme](https://github.com/arcticicestudio/nord).

### Autostart
OS X had the ability to reopen application upon boot, that was open during last shutdown.
Just like your favorite web browser, the feature was very convenient.
However, it often (just like your browser) lead to a lot of dangling and unused resources that just *sat there* after every reboot.
Reproducing the same behaviour on Linux was non-trivial, so looked other ways.

I started using autostart for spinning up specific application on every boot, and now I even prefer that, rather than having your left overs served to you from the last boot.
Currently, I have Firefox and Emacs in autostart and it seems to fit perfectly for my needs.

### Applications
This list is a small sample of some of the applications I use, and have used (R.I.P. ✝).

- bspwm, sxhkd [✝ GNOME3, ✝ i3] &mdash; *window manager and hotkey daemon*
- Plank [✝ polybar] &mdash; *simple dock with icons*
- Thunderbird [✝ claws, ✝ notmuch] &mdash; *mail client with great html support*
- tint2 [✝ polybar] &mdash; *tiny bar with basic system information and systray*
- rofi &mdash; *application launcher*
- emacs &mdash; *my beloved text editor*
- Firefox &mdash; *my current browser of choice*
- Alacritty [✝ urxvt, ✝ termite] &mdash; *decent modern terminal (finally with scrollback)*
- dunst &mdash; *notifications daemon*

### All in all

Running NixOS as a daily driver has been highly enjoyable, [even during times of a hard disk migration](/blog/nixos-the-distribution-i-got-to-love).
In fact, I ended up loving it so much that I changed my personal [VPS](https://en.wikipedia.org/wiki/Virtual_private_server) to run NixOS.
NixOS seems like taste of what the future of operating systems will bring, true reproducibility **will** be a requirement of the future.
However, you can try it out today, *free of charge*.

My only advice to you, dear reader, is to head over to the [NixOS manual](https://nixos.org/nixos/manual/index.html#ch-installation) to try it out today.

### Planned Improvements (2019)

I wish to start using [org-agenda](https://orgmode.org/manual/Agenda-commands.html) (extensible todo system for Emacs), properly.
Properly, refers to the fact that I have tried it once, but never got *hooked* on it.
My experience with `org-mode` was the same, not entirely hooked on the first attempt, but now I cannot live without it.
