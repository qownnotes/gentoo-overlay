# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# QOwnNotes 16.05.0
#

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="A plain-text file notepad with markdown support and ownCloud/NC integration"
HOMEPAGE="http://www.qownnotes.org/"

MY_P="e018b9546bb4a35c34d2e93f358287aa7a564905"
MY_QMDTE="b31976d2803f12504dca08aaf8b312ab306b46a5"
MY_PWT="656771e33fd4af5039b5cf9131a958fd3a4dfd41"
SRC_URI="https://github.com/pbek/QOwnNotes/archive/${MY_P}.tar.gz -> ${P}.tar.gz
	https://github.com/pbek/qmarkdowntextedit/archive/${MY_QMDTE}.tar.gz -> qmarkdowntextedit-${MY_QMDTE}.tar.gz
	https://github.com/pbek/qt-piwik-tracker/archive/${MY_PWT}.tar.gz -> piwiktracker-${MY_PWT}.tar.gz
"
S="${WORKDIR}/QOwnNotes-${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/qtscript:5
	dev-qt/qtprintsupport:5
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}"/src/libraries
	rmdir qmarkdowntextedit piwiktracker

	unpack "qmarkdowntextedit-${MY_QMDTE}.tar.gz"
	mv "qmarkdowntextedit-${MY_QMDTE}" qmarkdowntextedit

	unpack "piwiktracker-${MY_PWT}.tar.gz"
	mv "qt-piwik-tracker-${MY_PWT}" piwiktracker
}

src_prepare() {
	cd src
	echo "#define VERSION \"16.05.0\"" > version.h
	echo "#define RELEASE \"Gentoo\"" > release.h
	default
}

src_compile() {
	cd src
	eqmake5 QOwnNotes.pro -r
}

src_install() {
	cd src
	emake
	dobin QOwnNotes

	dodir /usr/share/QOwnNotes/languages
	insinto /usr/share/QOwnNotes/languages

	doins languages/*.qm

	insinto /usr/share/applications
	doicon -s 128 images/icons/128x128/QOwnNotes.png
	doicon -s scalable images/icons/scalable/QOwnNotes.svg
	doins QOwnNotes.desktop
}
