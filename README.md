# Spot Gentoo Overlay

## Installation

As of version >= 2.2.16 of Portage, **Spot** is best installed (on Gentoo) via the [new plug-in sync system](https://wiki.gentoo.org/wiki/Project:Portage/Sync).

The following are short form instructions. If you haven't already installed **git**(1), do so first:

    # emerge --ask --verbose dev-vcs/git 

Next, create a custom `/etc/portage/repos.conf` entry for the **Spot** overlay, so Portage knows what to do. Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, fire up your favourite editor:

    # nano -w /etc/portage/repos.conf/spot.conf

and put the following text in the file:
```
[spot]

# Maintainer: syutkin (syutkin@gmail.com)

location = /usr/local/portage/spot
sync-type = git
sync-uri = https://github.com/Syutkin/gentoo-overlay.git
priority = 50
auto-sync = yes
```

Then run:

    # emaint sync --repo spot

## Maintainers

* [syutkin](mailto:syutkin@gmail.com)

Thanks [sakaki](mailto:sakaki@deciban.com) for this readme and inspiration.
