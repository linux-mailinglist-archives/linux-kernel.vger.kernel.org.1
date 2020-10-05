Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CC4283588
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgJEMN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgJEMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:33 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C23C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id AC123241A1F;
        Mon,  5 Oct 2020 14:12:31 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.986
X-Spam-Level: 
X-Spam-Status: No, score=-2.986 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.086, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6vjR6U4RNVdn; Mon,  5 Oct 2020 14:12:30 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 40CFE241B22;
        Mon,  5 Oct 2020 14:12:30 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 18/32] auxdisplay: Implement hd44780_common_cursor
Date:   Mon,  5 Oct 2020 14:11:46 +0200
Message-Id: <20201005121200.3427363-19-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005121200.3427363-1-poeschel@lemonage.de>
References: <20201005121200.3427363-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Implement a hd44780_common_cursor function to turn the cursor on and
off. The hd44780 drivers can use this function and charlcd calls it
through its ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        |  6 ++++++
 drivers/auxdisplay/charlcd.h        |  2 ++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 14 ++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 28 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 9bd3c0f2c470..a2f0becb1a9f 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -246,10 +246,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case 'C':	/* Cursor ON */
 		priv->flags |= LCD_FLAG_C;
+		if (priv->flags != oldflags)
+			lcd->ops->cursor(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'c':	/* Cursor OFF */
 		priv->flags &= ~LCD_FLAG_C;
+		if (priv->flags != oldflags)
+			lcd->ops->cursor(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case 'B':	/* Blink ON */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index ec739a25195e..5aab359ebd91 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -61,6 +61,7 @@ struct charlcd {
  * @shift_cursor: Shift cursor left or right one position.
  * @shift_display: Shift whole display content left or right.
  * @display: Turn display on or off.
+ * @cursor: Turn cursor on or off.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -73,6 +74,7 @@ struct charlcd_ops {
 	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 	int (*display)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*cursor)(struct charlcd *lcd, enum charlcd_onoff on);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0f76b812fa20..d5ce3955b577 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -134,6 +134,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -185,6 +186,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 07fd03555e99..587385e55bae 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -222,6 +222,20 @@ int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_display);
 
+int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_C;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_C;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_cursor);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 1550fa77b956..7327a9b2e997 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -25,5 +25,6 @@ int hd44780_common_shift_cursor(struct charlcd *lcd,
 int hd44780_common_shift_display(struct charlcd *lcd,
 		enum charlcd_shift_dir dir);
 int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 9cb895c74cfb..26fbf91c1501 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -882,6 +882,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -894,6 +895,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -906,6 +908,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
 	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

