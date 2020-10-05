Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12737283604
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJENBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgJENBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:39 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69506C0613B9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 51B5923F42B;
        Mon,  5 Oct 2020 15:01:38 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.956
X-Spam-Level: 
X-Spam-Status: No, score=-2.956 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.056, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VPCTKeJ1SL5d; Mon,  5 Oct 2020 15:01:36 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 5190A23F727;
        Mon,  5 Oct 2020 15:01:36 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 17/32] auxdisplay: Implement a hd44780_common_display
Date:   Mon,  5 Oct 2020 15:01:13 +0200
Message-Id: <20201005130128.3430804-5-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Implement a hd44780_common_display function to turn the whole display on
or off. The hd44780 drivers can use this and charlcd uses this through
its ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        |  6 ++++++
 drivers/auxdisplay/charlcd.h        |  2 ++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 26 ++++++++++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 40 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index e48287197732..9bd3c0f2c470 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -232,10 +232,16 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	switch (*esc) {
 	case 'D':	/* Display ON */
 		priv->flags |= LCD_FLAG_D;
+		if (priv->flags != oldflags)
+			lcd->ops->display(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'd':	/* Display OFF */
 		priv->flags &= ~LCD_FLAG_D;
+		if (priv->flags != oldflags)
+			lcd->ops->display(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case 'C':	/* Cursor ON */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 6fd4a77f5794..ec739a25195e 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -60,6 +60,7 @@ struct charlcd {
  * @init_display: Initialize the display.
  * @shift_cursor: Shift cursor left or right one position.
  * @shift_display: Shift whole display content left or right.
+ * @display: Turn display on or off.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -71,6 +72,7 @@ struct charlcd_ops {
 	int (*init_display)(struct charlcd *lcd);
 	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*display)(struct charlcd *lcd, enum charlcd_onoff on);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index a3b18bbc2e4a..0f76b812fa20 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -133,6 +133,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -183,6 +184,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 972c74a22294..07fd03555e99 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -196,6 +196,32 @@ int hd44780_common_shift_display(struct charlcd *lcd,
 }
 EXPORT_SYMBOL_GPL(hd44780_common_shift_display);
 
+static void hd44780_common_set_mode(struct hd44780_common *hdc)
+{
+	hdc->write_cmd(hdc,
+		LCD_CMD_DISPLAY_CTRL |
+		((hdc->hd44780_common_flags & LCD_FLAG_D) ?
+			LCD_CMD_DISPLAY_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_C) ?
+			LCD_CMD_CURSOR_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_B) ?
+			LCD_CMD_BLINK_ON : 0));
+}
+
+int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_D;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_D;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_display);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 7badb96cb8a9..1550fa77b956 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -24,5 +24,6 @@ int hd44780_common_shift_cursor(struct charlcd *lcd,
 		enum charlcd_shift_dir dir);
 int hd44780_common_shift_display(struct charlcd *lcd,
 		enum charlcd_shift_dir dir);
+int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 7ebbfb338518..9cb895c74cfb 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -881,6 +881,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -892,6 +893,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -903,6 +905,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
 	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

