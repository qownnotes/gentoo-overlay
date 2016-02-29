# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils eutils

DESCRIPTION="A plain-text file notepad with markdown support and (optional) ownCloud integration"
HOMEPAGE="http://www.qownnotes.org/"
MY_P="b1119-064549"
SRC_URI="https://github.com/pbek/QOwnNotes/archive/linux-${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/QOwnNotes-linux-${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
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

src_prepare() {
	cd src/libraries
	rmdir qmarkdowntextedit piwikitracker
	git clone https://github.com/pbek/qmarkdowntextedit.git
	git clone https://github.com/pbek/qt-piwik-tracker.git piwiktracker
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
