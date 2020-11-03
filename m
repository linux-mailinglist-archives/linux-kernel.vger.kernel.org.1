Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5422A4104
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKCJ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgKCJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:54 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8000123F87F;
        Tue,  3 Nov 2020 10:58:52 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.943
X-Spam-Level: 
X-Spam-Status: No, score=-2.943 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.043, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r32O-hNISKBI; Tue,  3 Nov 2020 10:58:51 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id BE9F623FEE3;
        Tue,  3 Nov 2020 10:58:50 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 10/25] auxdisplay: add home to charlcd_ops
Date:   Tue,  3 Nov 2020 10:58:13 +0100
Message-Id: <20201103095828.515831-11-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This adds a home function to the charlcd_ops struct and offer an
implementation for hd44780_common. This implementation is used by our
two hd44780 drivers. This is to make charlcd device independent.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 2 +-
 drivers/auxdisplay/charlcd.h        | 3 +++
 drivers/auxdisplay/hd44780.c        | 2 ++
 drivers/auxdisplay/hd44780_common.c | 8 ++++++++
 drivers/auxdisplay/hd44780_common.h | 1 +
 drivers/auxdisplay/panel.c          | 3 +++
 6 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index d6f971eea6ae..44dd6e02eaf9 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -144,7 +144,7 @@ static void charlcd_home(struct charlcd *lcd)
 {
 	lcd->addr.x = 0;
 	lcd->addr.y = 0;
-	lcd->ops->gotoxy(lcd);
+	lcd->ops->home(lcd);
 }
 
 static void charlcd_print(struct charlcd *lcd, char c)
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index f36cc80ce385..236fd0e9e8ab 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -41,12 +41,15 @@ struct charlcd {
  * wrap to the next line at the end of a line.
  * @gotoxy: Set cursor to x, y. The x and y values to set the cursor to are
  * previously set in addr.x and addr.y by charlcd.
+ * @home: Set cursor to 0, 0. The values in addr.x and addr.y are set to 0, 0 by
+ * charlcd prior to calling this function.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*print)(struct charlcd *lcd, int c);
 	int (*gotoxy)(struct charlcd *lcd);
+	int (*home)(struct charlcd *lcd);
 };
 
 struct charlcd *charlcd_alloc(void);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 4d9478f6e5ff..b0893ea49165 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -128,6 +128,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -173,6 +174,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
 	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index f86eb2f27cee..ea62beada9d8 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -41,6 +41,14 @@ int hd44780_common_gotoxy(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_gotoxy);
 
+int hd44780_common_home(struct charlcd *lcd)
+{
+	lcd->addr.x = 0;
+	lcd->addr.y = 0;
+	return hd44780_common_gotoxy(lcd);
+}
+EXPORT_SYMBOL_GPL(hd44780_common_home);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index d8cbea4a8658..c91070ed931b 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -16,4 +16,5 @@ struct hd44780_common {
 
 int hd44780_common_print(struct charlcd *lcd, int c);
 int hd44780_common_gotoxy(struct charlcd *lcd);
+int hd44780_common_home(struct charlcd *lcd);
 struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 75894eacd12f..b1e874f07456 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -876,18 +876,21 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
 	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
 	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
 	.gotoxy		= hd44780_common_gotoxy,
+	.home		= hd44780_common_home,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

