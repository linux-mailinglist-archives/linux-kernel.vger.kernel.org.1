Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737EE2A40FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKCJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKCJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:55 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D31C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 863F723FED3;
        Tue,  3 Nov 2020 10:58:53 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.943
X-Spam-Level: 
X-Spam-Status: No, score=-2.943 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.043, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bB7HiYhNgZdd; Tue,  3 Nov 2020 10:58:51 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 933CA23F3FE;
        Tue,  3 Nov 2020 10:58:51 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 11/25] auxdisplay: Move clear_display to hd44780_common
Date:   Tue,  3 Nov 2020 10:58:14 +0100
Message-Id: <20201103095828.515831-12-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This moves the clear_display function from charlcd to hd44780_common.
This is one more step to make charlcd independent from device specific
code. The two hd44780 drivers use the new function from hd44780_common
and charlcd calls this function through its function pointer in its ops
structure.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 22 ++++++----------------
 drivers/auxdisplay/charlcd.h        |  4 ++++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 21 +++++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 44dd6e02eaf9..fc0daf4987d5 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -34,8 +34,6 @@
 #define LCD_FLAG_L		0x0080	/* Backlight enabled */
 
 /* LCD commands */
-#define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
-
 #define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
 #define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
 
@@ -178,18 +176,6 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 	charlcd_home(lcd);
 }
 
-/* clears the display and resets X/Y */
-static void charlcd_clear_display(struct charlcd *lcd)
-{
-	struct hd44780_common *hdc = lcd->drvdata;
-
-	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
-	lcd->addr.x = 0;
-	lcd->addr.y = 0;
-	/* we must wait a few milliseconds (15) */
-	long_sleep(15);
-}
-
 static int charlcd_init_display(struct charlcd *lcd)
 {
 	void (*write_cmd_raw)(struct hd44780_common *hdc, int cmd);
@@ -254,7 +240,9 @@ static int charlcd_init_display(struct charlcd *lcd)
 	/* entry mode set : increment, cursor shifting */
 	hdc->write_cmd(hdc, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
 
-	charlcd_clear_display(lcd);
+	lcd->ops->clear_display(lcd);
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
 	return 0;
 }
 
@@ -670,8 +658,10 @@ static int charlcd_open(struct inode *inode, struct file *file)
 		goto fail;
 
 	if (priv->must_clear) {
-		charlcd_clear_display(&priv->lcd);
+		priv->lcd.ops->clear_display(&priv->lcd);
 		priv->must_clear = false;
+		priv->lcd.addr.x = 0;
+		priv->lcd.addr.y = 0;
 	}
 	return nonseekable_open(inode, file);
 
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 236fd0e9e8ab..a6c32c4d1aac 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -43,6 +43,9 @@ struct charlcd {
  * previously set in addr.x and addr.y by charlcd.
  * @home: Set cursor to 0, 0. The values in addr.x and addr.y are set to 0, 0 by
  * charlcd prior to calling this function.
+ * @clear_display: Again clear the whole display, set the cursor to 0, 0. The
+ * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
+ * function.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -50,6 +53,7 @@ struct charlcd_ops {
 	int (*print)(struct charlcd *lcd, int c);
 	int (*gotoxy)(struct charlcd *lcd);
 	int (*home)(struct charlcd *lcd);
+	int (*clear_display)(struct charlcd *lcd);
 };
 
 struct charlcd *charlcd_alloc(void);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index b0893ea49165..40ea6d25dbe1 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -129,6 +129,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -175,6 +176,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index ea62beada9d8..2f7d55668eb4 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -1,13 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
 #include "charlcd.h"
 #include "hd44780_common.h"
 
 /* LCD commands */
+#define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
+
 #define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
 
+/* sleeps that many milliseconds with a reschedule */
+static void long_sleep(int ms)
+{
+	schedule_timeout_interruptible(msecs_to_jiffies(ms));
+}
+
 int hd44780_common_print(struct charlcd *lcd, int c)
 {
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -49,6 +58,18 @@ int hd44780_common_home(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_home);
 
+/* clears the display and resets X/Y */
+int hd44780_common_clear_display(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
+	/* we must wait a few milliseconds (15) */
+	long_sleep(15);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index c91070ed931b..ef11935a3764 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -17,4 +17,5 @@ struct hd44780_common {
 int hd44780_common_print(struct charlcd *lcd, int c);
 int hd44780_common_gotoxy(struct charlcd *lcd);
 int hd44780_common_home(struct charlcd *lcd);
+int hd44780_common_clear_display(struct charlcd *lcd);
 struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index b1e874f07456..8adf627529f1 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -877,6 +877,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -884,6 +885,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -891,6 +893,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
+	.clear_display	= hd44780_common_clear_display,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

