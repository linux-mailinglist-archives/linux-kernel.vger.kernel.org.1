Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097F81CCA21
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEJKNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 06:13:42 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:47530 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgEJKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:13:40 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id ED02D3EE0; Sun, 10 May 2020 12:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz ED02D3EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589105617;
        bh=QlOGZJaxuXbEjYRzF7O9Rg0ORS1ErUT1AjDPBU3SWyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/UpnWchh96RseMCrkqqvytF34vk2wTA9OkHfl/B/Y3apM8Y7Bm+nv1EGZC1o3zTt
         tSQJfK67+V3OUTyHFnH8e0ulvNs0JvQFwChvM0PTKvX8qmG/j/bgeS0C494zxE8E/c
         cV1SWY2zim3ir4ytGrCaqUbhoff2vUGKYSBSAqXA=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v2 2/2] staging: vt6655: vt6656: change order of makefile variable definitions
Date:   Sun, 10 May 2020 12:13:35 +0200
Message-Id: <1589105615-22271-3-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1589105615-22271-1-git-send-email-mdujava@kocurkovo.cz>
References: <1589105615-22271-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will add indentation to multiline variable and put obj-$(CONFIG_X)
at the begining of the file.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/vt6655/Makefile | 24 ++++++++++++------------
 drivers/staging/vt6656/Makefile |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/Makefile b/drivers/staging/vt6655/Makefile
index e70357ec0af8..eda08a1516ab 100644
--- a/drivers/staging/vt6655/Makefile
+++ b/drivers/staging/vt6655/Makefile
@@ -1,15 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
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
-
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
diff --git a/drivers/staging/vt6656/Makefile b/drivers/staging/vt6656/Makefile
index f696a9d7a143..aac323d6a684 100644
--- a/drivers/staging/vt6656/Makefile
+++ b/drivers/staging/vt6656/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_VT6656) +=	vt6656_stage.o
+
 vt6656_stage-y +=	main_usb.o \
 			card.o  \
 			mac.o   \
@@ -11,5 +13,3 @@ vt6656_stage-y +=	main_usb.o \
 			rf.o \
 			usbpipe.o \
 			channel.o
-
-obj-$(CONFIG_VT6656) +=	vt6656_stage.o
-- 
2.26.2

