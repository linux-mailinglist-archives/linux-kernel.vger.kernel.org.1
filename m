Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04D628358B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJEMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgJEMMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:32 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A2C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id B6799241CA4;
        Mon,  5 Oct 2020 14:12:30 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.987
X-Spam-Level: 
X-Spam-Status: No, score=-2.987 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.087, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b9Ec05JAMD6o; Mon,  5 Oct 2020 14:12:28 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 83CCE241509;
        Mon,  5 Oct 2020 14:12:28 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 16/32] auxdisplay: Implement hd44780_common_display_shift
Date:   Mon,  5 Oct 2020 14:11:44 +0200
Message-Id: <20201005121200.3427363-17-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005121200.3427363-1-poeschel@lemonage.de>
References: <20201005121200.3427363-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Implement a hd44780_common_display_shift function for hd44780 drivers to
use. charlcd uses this through its ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 10 ++--------
 drivers/auxdisplay/charlcd.h        |  2 ++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 16 ++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  2 ++
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 85747e13bf48..e48287197732 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -31,10 +31,6 @@
 #define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
 #define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
 
-#define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
-#define LCD_CMD_DISPLAY_SHIFT	0x08	/* Shift display instead of cursor */
-#define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
-
 #define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
 #define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
 #define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
@@ -303,13 +299,11 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		processed = 1;
 		break;
 	case 'L':	/* shift display left */
-		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
+		lcd->ops->shift_display(lcd, CHARLCD_SHIFT_LEFT);
 		processed = 1;
 		break;
 	case 'R':	/* shift display right */
-		hdc->write_cmd(hdc,
-				    LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT |
-				    LCD_CMD_SHIFT_RIGHT);
+		lcd->ops->shift_display(lcd, CHARLCD_SHIFT_RIGHT);
 		processed = 1;
 		break;
 	case 'k': {	/* kill end of line */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 0a340beacd3e..6fd4a77f5794 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -59,6 +59,7 @@ struct charlcd {
  * function.
  * @init_display: Initialize the display.
  * @shift_cursor: Shift cursor left or right one position.
+ * @shift_display: Shift whole display content left or right.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -69,6 +70,7 @@ struct charlcd_ops {
 	int (*clear_display)(struct charlcd *lcd);
 	int (*init_display)(struct charlcd *lcd);
 	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 6ffeeb3fb0d0..a3b18bbc2e4a 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -132,6 +132,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -181,6 +182,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 894a195eda39..972c74a22294 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -18,6 +18,7 @@
 #define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
 
 #define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
+#define LCD_CMD_DISPLAY_SHIFT	0x08	/* Shift display instead of cursor */
 #define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
 
 #define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
@@ -180,6 +181,21 @@ int hd44780_common_shift_cursor(struct charlcd *lcd, enum charlcd_shift_dir dir)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_shift_cursor);
 
+int hd44780_common_shift_display(struct charlcd *lcd,
+		enum charlcd_shift_dir dir)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (dir == CHARLCD_SHIFT_LEFT)
+		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
+	else if (dir == CHARLCD_SHIFT_RIGHT)
+		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT |
+			LCD_CMD_SHIFT_RIGHT);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_shift_display);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 432fc37213cf..7badb96cb8a9 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -22,5 +22,7 @@ int hd44780_common_clear_display(struct charlcd *lcd);
 int hd44780_common_init_display(struct charlcd *lcd);
 int hd44780_common_shift_cursor(struct charlcd *lcd,
 		enum charlcd_shift_dir dir);
+int hd44780_common_shift_display(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 4275223080e8..7ebbfb338518 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -880,6 +880,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -890,6 +891,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -900,6 +902,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
 	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

