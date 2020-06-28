# QOwnNotes Gentoo Overlay

This is a Gentoo overlay for [QOwnNotes](http://www.qownnotes.org), the open source (GPL) plain-text file notepad with markdown support and todo list manager for GNU/Linux, Mac OS X and Windows, that (optionally) works together with the notes application of Nextcloud/ownCloud.

## Usage

### layman

Add and install QOwnNotes with *layman*.

```bash
layman -f -a qownnotes-overlay -o https://raw.githubusercontent.com/qownnotes/gentoo-overlay/master/overlay.xml
emerge qownnotes
```

### direct

To create a configuration file for the QOwnNotes overlay you have to run these commands as root.

```bash
mkdir -p /etc/portage/repos.conf
nano /etc/portage/repos.conf/qownnotes-overlay.conf
```

Add these lines to the file:

```
[qownnotes-overlay]
location = /usr/local/portage/qownnotes-overlay
sync-type = git
sync-uri = https://github.com/qownnotes/gentoo-overlay.git
```

Then you should be able to install QOwnNotes from the overlay.

```bash
emerge --sync
emerge app-office/qownnotes
```

If you run into troubles with libpcre you might have to do a `env USE=pcre16 emerge -1 libpcre`.
