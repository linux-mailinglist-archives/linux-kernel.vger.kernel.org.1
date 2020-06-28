Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AFF20C771
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgF1Ky0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 06:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgF1KyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 06:54:25 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BECB02071A;
        Sun, 28 Jun 2020 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593341664;
        bh=P5cEvuK5v3+ozD4XkiGCIoW28pCnotfaQXcfJ27+tCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JpzHier/bx44hCHTosX6MhpCREMSoQnwefFCtTqMIWQz5xMBQL0sVLBHGYDvO9EH2
         +H906Buvig14JlqsbCeB9cesn1Wl4YSfTW5YqCKHysN9Vnxd4fQ/TX3fzalpgTzwZ7
         NOYsLGQoAeK7kqvkNywhS7T+MwyUu5o9Smq8VUKs=
Date:   Sun, 28 Jun 2020 12:54:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Search function in xconfig is partially broken after recent
 changes
Message-ID: <20200628125421.12458086@coco.lan>
In-Reply-To: <2d536ba419ffe76e031bd65375e5af6a401faec0.camel@redhat.com>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
        <20200625125906.6b7688eb@coco.lan>
        <20200625131758.52dbdab7@coco.lan>
        <855fea60f47c1a0dbcf0395a4cdbe5d9c57592c1.camel@redhat.com>
        <20200625170546.270cf5fc@coco.lan>
        <2d536ba419ffe76e031bd65375e5af6a401faec0.camel@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 28 Jun 2020 11:37:08 +0300
Maxim Levitsky <mlevitsk@redhat.com> escreveu:

> On Thu, 2020-06-25 at 17:05 +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 25 Jun 2020 15:53:46 +0300
> > Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> >   
> > > On Thu, 2020-06-25 at 13:17 +0200, Mauro Carvalho Chehab wrote:  
> > > > Em Thu, 25 Jun 2020 12:59:15 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > > >     
> > > > > Hi Maxim,
> > > > > 
> > > > > Em Thu, 25 Jun 2020 12:25:10 +0300
> > > > > Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> > > > >     
> > > > > > Hi!
> > > > > > 
> > > > > > I noticed that on recent kernels the search function in xconfig is partially broken.
> > > > > > This means that when you select a found entry, it is not selected in the main window,
> > > > > > something that I often do to find some entry near the area I would like to modify,
> > > > > > and then use main window to navigate/explore that area.
> > > > > > 
> > > > > > Reverting these commits helps restore the original behavier:
> > > > > > 
> > > > > > b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> > > > > > cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> > > > > > 
> > > > > > I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> > > > > > 
> > > > > > Could you explain what these commits are supposed to fix?
> > > > > > I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.
> > > > > >     
> > > > > 
> > > > > There are three view modes for qconf:
> > > > > 
> > > > > 	- Single
> > > > > 	- Split
> > > > > 	- Full
> > > > > 
> > > > > those got broken when gconf was converted to use Qt5, back on Kernel 3.14.
> > > > > Those patches restore the original behavior.    
> > > You mean xconfig/qconf? (gconf is another program that is GTK based as far as I know).  
> > 
> > Yeah, I meant the Qt one (qconfig).
> >   
> > > Could you expalin though what was broken? What exactly didn't work?  
> > 
> > Try to switch between the several modes and switch back. There used to
> > have several broken things there, because the Qt5 port was incomplete.
> > 
> > One of the things that got fixed on the Qt5 fixup series is the helper
> > window at the bottom. It should now have the same behavior as with the
> > old Qt3/Qt4 version.
> > 
> > Basically, on split mode, it should have 3 screen areas:
> > 
> > 	+------------+-------+
> > 	|            |       |
> > 	| Config     |  menu |
> > 	|            |       |
> > 	+------------+-------+
> > 	|                    |
> > 	| Config description +
> > 	|                    |
> > 	+--------------------+
> > 
> > The contents of the config description should follow up any changes at 
> > the "menu" part of the split mode, when an item is selected from "menu",
> > or follow what's selected at "config", when the active window is "config".  
> 
> Dunno. with the 2 b311142fcfd37b58dfec72e040ed04949eb1ac86 and cce1faba82645fee899ccef5b7d3050fed3a3d10,
> in split view, I wasn't able to make the 'config description' show anything wrong,
> in regard to currently selected item in 'config' and in 'menu'

Well, the problem was related to how the code calls those 3 areas
internally: configView, menuView and configInfoView. 

When it is outside the split view, it should hide the
menuView, in order to show just the configView and the configInfoView.

There were lots of weird stuff there. I suspect that, after the
half-done Qt5 conversion (that handled badly the menuView hiding
logic), some hacks were added, assuming the wrong window hiding 
logic. When I fixed it, other things stopped working. So, additional
fixup patches were needed.

> At that point this is mostly an academic interset for me since,
> the patch that you sent fixes search. Thank you very much!

Anytime!

> BTW, I re-discovered another bug (I have seen it already but it didn't bother me that much),
> while trying to break the version with these commits reverted (but it happens 
> with them not reverted as well):
> 
> When I enable 'show debug info' to understand why I can't enable/disable some config
> option, the hyperlinks in the config description don't work - they make the config
> window to be empty.

It sounds that the creation of the search list for the QTextBrowser 
instantiated class (e. g. configInfoView) is not fine.

It sounds that it was supposed to call either setInfo() or
setMenuLink() when a debug info hyperlink is clicked:

	info = new ConfigInfoView(split, name);
	connect(list->list, SIGNAL(menuChanged(struct menu *)),
		info, SLOT(setInfo(struct menu *)));

But this is not happening. Perhaps this also broke with the Qt5
conversion?

I suspect it should, instead, use a different signal to handle it.

See, with the enclosed patch, clicking on a link will now show:

	Clicked on URL QUrl("s0x21c3f10")
	QTextBrowser: No document for s0x21c3f10

Which helps to explain what's happening here.

See, when debug is turned on, it will create hyperlinks like:

	head += QString().sprintf("<a href=\"s%p\">", sym);

It seems that the code needs something like:

	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
			 helpText, SLOT (clicked (const QUrl &)) );

and a handler for this signal that would translate "s%p"
back into sym, using such value to update the menus.

Do you know if this used to work after Kernel 3.14?

Thanks,
Mauro

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index b8f577c6e8aa..4d9bf9330c73 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -4,27 +4,19 @@
  * Copyright (C) 2015 Boris Barbulovski <bbarbulovski@gmail.com>
  */
 
-#include <qglobal.h>
-
-#include <QMainWindow>
-#include <QList>
-#include <qtextbrowser.h>
 #include <QAction>
+#include <QApplication>
+#include <QCloseEvent>
+#include <QDebug>
+#include <QDesktopWidget>
 #include <QFileDialog>
+#include <QLabel>
+#include <QLayout>
+#include <QList>
 #include <QMenu>
-
-#include <qapplication.h>
-#include <qdesktopwidget.h>
-#include <qtoolbar.h>
-#include <qlayout.h>
-#include <qsplitter.h>
-#include <qlineedit.h>
-#include <qlabel.h>
-#include <qpushbutton.h>
-#include <qmenubar.h>
-#include <qmessagebox.h>
-#include <qregexp.h>
-#include <qevent.h>
+#include <QMenuBar>
+#include <QMessageBox>
+#include <QToolBar>
 
 #include <stdlib.h>
 
@@ -400,6 +392,8 @@ void ConfigList::updateSelection(void)
 	struct menu *menu;
 	enum prop_type type;
 
+qInfo() << __FUNCTION__;
+
 	if (mode == symbolMode)
 		setHeaderLabels(QStringList() << "Item" << "Name" << "N" << "M" << "Y" << "Value");
 	else
@@ -536,6 +530,8 @@ void ConfigList::setRootMenu(struct menu *menu)
 {
 	enum prop_type type;
 
+
+qInfo() << __FUNCTION__ << "menu:" << menu;
 	if (rootEntry == menu)
 		return;
 	type = menu && menu->prompt ? menu->prompt->type : P_UNKNOWN;
@@ -1020,6 +1016,7 @@ void ConfigView::updateListAll(void)
 ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 	: Parent(parent), sym(0), _menu(0)
 {
+qInfo() << __FUNCTION__;
 	setObjectName(name);
 
 
@@ -1033,6 +1030,7 @@ ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
 
 void ConfigInfoView::saveSettings(void)
 {
+qInfo() << __FUNCTION__;
 	if (!objectName().isEmpty()) {
 		configSettings->beginGroup(objectName());
 		configSettings->setValue("/showDebug", showDebug());
@@ -1042,6 +1040,7 @@ void ConfigInfoView::saveSettings(void)
 
 void ConfigInfoView::setShowDebug(bool b)
 {
+qInfo() << __FUNCTION__;
 	if (_showDebug != b) {
 		_showDebug = b;
 		if (_menu)
@@ -1054,6 +1053,8 @@ void ConfigInfoView::setShowDebug(bool b)
 
 void ConfigInfoView::setInfo(struct menu *m)
 {
+qInfo() << __FUNCTION__ << "menu:" << m;
+
 	if (_menu == m)
 		return;
 	_menu = m;
@@ -1068,6 +1069,8 @@ void ConfigInfoView::symbolInfo(void)
 {
 	QString str;
 
+qInfo() << __FUNCTION__;
+
 	str += "<big>Symbol: <b>";
 	str += print_filter(sym->name);
 	str += "</b></big><br><br>value: ";
@@ -1085,6 +1088,8 @@ void ConfigInfoView::menuInfo(void)
 	struct symbol* sym;
 	QString head, debug, help;
 
+qInfo() << __FUNCTION__;
+
 	sym = _menu->sym;
 	if (sym) {
 		if (_menu->prompt) {
@@ -1140,6 +1145,7 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 {
 	QString debug;
 
+qInfo() << __FUNCTION__;
 	debug += "type: ";
 	debug += print_filter(sym_type_name(sym->type));
 	if (sym_is_choice(sym))
@@ -1191,6 +1197,7 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 
 QString ConfigInfoView::print_filter(const QString &str)
 {
+qInfo() << __FUNCTION__;
 	QRegExp re("[<>&\"\\n]");
 	QString res = str;
 	for (int i = 0; (i = res.indexOf(re, i)) >= 0;) {
@@ -1225,6 +1232,7 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
 	QString* text = reinterpret_cast<QString*>(data);
 	QString str2 = print_filter(str);
 
+qInfo() << __FUNCTION__;
 	if (sym && sym->name && !(sym->flags & SYMBOL_CONST)) {
 		*text += QString().sprintf("<a href=\"s%p\">", sym);
 		*text += str2;
@@ -1233,11 +1241,17 @@ void ConfigInfoView::expr_print_help(void *data, struct symbol *sym, const char
 		*text += str2;
 }
 
+void ConfigInfoView::clicked(const QUrl &url)
+{
+	qInfo() << "Clicked on URL" << url;
+}
+
 QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 {
 	QMenu* popup = Parent::createStandardContextMenu(pos);
 	QAction* action = new QAction("Show Debug Info", popup);
 
+qInfo() << __FUNCTION__;
 	action->setCheckable(true);
 	connect(action, SIGNAL(toggled(bool)), SLOT(setShowDebug(bool)));
 	connect(this, SIGNAL(showDebugChanged(bool)), action, SLOT(setOn(bool)));
@@ -1249,6 +1263,7 @@ QMenu* ConfigInfoView::createStandardContextMenu(const QPoint & pos)
 
 void ConfigInfoView::contextMenuEvent(QContextMenuEvent *e)
 {
+qInfo() << __FUNCTION__;
 	Parent::contextMenuEvent(e);
 }
 
@@ -1258,6 +1273,8 @@ ConfigSearchWindow::ConfigSearchWindow(ConfigMainWindow* parent, const char *nam
 	setObjectName(name);
 	setWindowTitle("Search Config");
 
+qInfo() << __FUNCTION__ << "name:" << name;
+
 	QVBoxLayout* layout1 = new QVBoxLayout(this);
 	layout1->setContentsMargins(11, 11, 11, 11);
 	layout1->setSpacing(6);
@@ -1506,6 +1523,9 @@ ConfigMainWindow::ConfigMainWindow(void)
 	helpMenu->addAction(showIntroAction);
 	helpMenu->addAction(showAboutAction);
 
+	connect (helpText, SIGNAL (anchorClicked (const QUrl &)),
+		 helpText, SLOT (clicked (const QUrl &)) );
+
 	connect(configList, SIGNAL(menuChanged(struct menu *)),
 		helpText, SLOT(setInfo(struct menu *)));
 	connect(configList, SIGNAL(menuSelected(struct menu *)),
@@ -1603,6 +1623,7 @@ void ConfigMainWindow::saveConfigAs(void)
 
 void ConfigMainWindow::searchConfig(void)
 {
+qInfo() << __FUNCTION__;
 	if (!searchWindow)
 		searchWindow = new ConfigSearchWindow(this, "search");
 	searchWindow->show();
@@ -1610,6 +1631,11 @@ void ConfigMainWindow::searchConfig(void)
 
 void ConfigMainWindow::changeItens(struct menu *menu)
 {
+qInfo() << __FUNCTION__ << "Changing to menu" << menu;
+
+	if (menu->flags & MENU_ROOT)
+		qInfo() << "Wrong type when changing item";
+
 	configList->setRootMenu(menu);
 
 	if (configList->rootEntry->parent == &rootmenu)
@@ -1620,6 +1646,11 @@ void ConfigMainWindow::changeItens(struct menu *menu)
 
 void ConfigMainWindow::changeMenu(struct menu *menu)
 {
+qInfo() << __FUNCTION__ << "Changing to menu" << menu;
+
+	if (!(menu->flags & MENU_ROOT))
+		qInfo() << "Wrong type when changing menu";
+
 	menuList->setRootMenu(menu);
 
 	if (menuList->rootEntry->parent == &rootmenu)
@@ -1633,6 +1664,7 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
 	struct menu *parent;
 	ConfigList* list = NULL;
 	ConfigItem* item;
+qInfo() << __FUNCTION__ << "Changing to menu" << menu;
 
 	if (configList->menuSkip(menu))
 		return;
@@ -1681,6 +1713,7 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
 
 void ConfigMainWindow::listFocusChanged(void)
 {
+qInfo() << __FUNCTION__;
 	if (menuList->mode == menuMode)
 		configList->clearSelection();
 }
@@ -1689,6 +1722,7 @@ void ConfigMainWindow::goBack(void)
 {
 	ConfigItem* item, *oldSelection;
 
+qInfo() << __FUNCTION__;
 	configList->setParentMenu();
 	if (configList->rootEntry == &rootmenu)
 		backAction->setEnabled(false);
diff --git a/scripts/kconfig/qconf.h b/scripts/kconfig/qconf.h
index c879d79ce817..a193137f2314 100644
--- a/scripts/kconfig/qconf.h
+++ b/scripts/kconfig/qconf.h
@@ -3,17 +3,17 @@
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  */
 
-#include <QTextBrowser>
-#include <QTreeWidget>
-#include <QMainWindow>
+#include <QCheckBox>
+#include <QDialog>
 #include <QHeaderView>
-#include <qsettings.h>
+#include <QLineEdit>
+#include <QMainWindow>
 #include <QPushButton>
 #include <QSettings>
-#include <QLineEdit>
 #include <QSplitter>
-#include <QCheckBox>
-#include <QDialog>
+#include <QTextBrowser>
+#include <QTreeWidget>
+
 #include "expr.h"
 
 class ConfigView;
@@ -250,6 +250,7 @@ public slots:
 	void setInfo(struct menu *menu);
 	void saveSettings(void);
 	void setShowDebug(bool);
+	void clicked (const QUrl &url);
 
 signals:
 	void showDebugChanged(bool);



