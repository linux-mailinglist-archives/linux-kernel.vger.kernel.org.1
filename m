Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8211CBF9E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEIJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 05:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgEIJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:07:37 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37611C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 02:07:37 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id A32C611D4; Sat,  9 May 2020 11:07:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz A32C611D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589015252;
        bh=BQFL8wc2JPcaE2sLzGeBHq1Wirj6vteV2jC4e9PWYV4=;
        h=From:To:Cc:Subject:Date:From;
        b=oU0QDZi42jzlQodaW5G4ZSJElWFmop77WTN3m9Lp4coGctSJ4BIW+2okV5ZLrGV6z
         bTn19JoPASEeVCktoTydGKPvWHcdKJPaUe2xUgu6NCC7qUXgURbdEWjJ97KgTikwgW
         SZaYdE5pcWBwUryMzC2Ljz8/SlrTpJC3iqKJGC0U=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH] staging: vt6656: vt6655: clean Makefiles
Date:   Sat,  9 May 2020 11:07:27 +0200
Message-Id: <1589015247-738-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is removing CFLAGS that are defining flags that are not used.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/Makefile      | 27 ++++++++++++---------------
 drivers/staging/vt6655/device_main.c |  1 -
 drivers/staging/vt6656/Makefile      |  7 ++-----
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/vt6655/Makefile b/drivers/staging/vt6655/Makefile
index a151f30fc46f..eda08a1516ab 100644
--- a/drivers/staging/vt6655/Makefile
+++ b/drivers/staging/vt6655/Makefile
@@ -1,18 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
-# TODO: all of these should be removed
-ccflags-y := -DLINUX -D__KERNEL__ -D__NO_VERSION__
-ccflags-y += -DHOSTAP
-
-vt6655_stage-y +=	device_main.o \
-	card.o \
-	channel.o \
-	mac.o \
-	baseband.o \
-	rxtx.o \
-	dpc.o \
-	power.o \
-	srom.o \
-	key.o \
-	rf.o
 
 obj-$(CONFIG_VT6655) +=	vt6655_stage.o
+
+vt6655_stage-y +=	device_main.o \
+			card.o \
+			channel.o \
+			mac.o \
+			baseband.o \
+			rxtx.o \
+			dpc.o \
+			power.o \
+			srom.o \
+			key.o \
+			rf.o
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 5889023d19c4..41cbec4134b0 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -32,7 +32,6 @@
  *
  * Revision History:
  */
-#undef __NO_VERSION__
 
 #include <linux/file.h>
 #include "device.h"
diff --git a/drivers/staging/vt6656/Makefile b/drivers/staging/vt6656/Makefile
index a0f3862dea75..aac323d6a684 100644
--- a/drivers/staging/vt6656/Makefile
+++ b/drivers/staging/vt6656/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-# TODO: all of these should be removed
-ccflags-y := -DLINUX -D__KERNEL__ -DEXPORT_SYMTAB -D__NO_VERSION__
-ccflags-y += -DHOSTAP
+
+obj-$(CONFIG_VT6656) +=	vt6656_stage.o
 
 vt6656_stage-y +=	main_usb.o \
 			card.o  \
@@ -14,5 +13,3 @@ vt6656_stage-y +=	main_usb.o \
 			rf.o \
 			usbpipe.o \
 			channel.o
-
-obj-$(CONFIG_VT6656) +=	vt6656_stage.o
-- 
2.26.2

