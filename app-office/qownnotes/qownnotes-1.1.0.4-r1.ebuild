# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# QOwnNotes 1.1.0.4
#

EAPI=7

inherit qmake-utils eutils

DESCRIPTION="A plain-text file notepad with markdown support and ownCloud/NC integration"
HOMEPAGE="http://www.qownnotes.org/"
MY_P="e68eff27765394e5ecab187f36cdb17dd8c87feb"
SRC_URI="https://github.com/pbek/QOwnNotes/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/QOwnNotes-${MY_P}"

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
	cd src
	echo "#define VERSION \"1.1.0.4\"" > version.h
	echo "#define RELEASE \"Gentoo\"" > release.h
	default

	cd libraries
	rmdir qmarkdowntextedit piwikitracker
	git clone https://github.com/pbek/qmarkdowntextedit.git
	cd qmarkdowntextedit
	git checkout 99a44cdab26b18300895af4fbe6e4c2fb7b621aa
	cd ..
	git clone https://github.com/pbek/qt-piwik-tracker.git piwiktracker
	cd piwiktracker
	git checkout 656771e33fd4af5039b5cf9131a958fd3a4dfd41
	cd ..
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
