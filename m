Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47D272910
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIUOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgIUOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:48:01 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E062C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:48:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 57DF323F02F;
        Mon, 21 Sep 2020 16:47:59 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.005
X-Spam-Level: 
X-Spam-Status: No, score=-3.005 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.105, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L3RHe5ozNRkV; Mon, 21 Sep 2020 16:47:57 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id B6CB923F029;
        Mon, 21 Sep 2020 16:47:57 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2 10/32] auxdisplay: add home to charlcd_ops
Date:   Mon, 21 Sep 2020 16:46:22 +0200
Message-Id: <20200921144645.2061313-11-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This adds a home function to the charlcd_ops struct and offer an
implementation for hd44780_common. This implementation is used by our
two hd44780 drivers. This is to make charlcd device independent.

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
index 04fd241fe6d6..12c348c1a0ae 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -40,12 +40,15 @@ struct charlcd {
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
index e04c81bbd333..e659f16e9139 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -40,6 +40,14 @@ int hd44780_common_gotoxy(struct charlcd *lcd)
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
index 0bee6c22761e..1365484963d8 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -16,5 +16,6 @@ struct hd44780_common {
 
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

