Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF122A40EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKCJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgKCJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:57 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id C543624027D;
        Tue,  3 Nov 2020 10:58:55 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.942
X-Spam-Level: 
X-Spam-Status: No, score=-2.942 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.042, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JGgxeZIAubFO; Tue,  3 Nov 2020 10:58:53 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 6A2E623FB43;
        Tue,  3 Nov 2020 10:58:53 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 14/25] auxdisplay: Move init_display to hd44780_common
Date:   Tue,  3 Nov 2020 10:58:17 +0100
Message-Id: <20201103095828.515831-15-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The init_display function is moved over to hd44780_common. charlcd uses
it via its ops function pointer and drivers initialize the ops with the
common hd44780_common_init_display function.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v5:
- Fix commit message typo: it's -> its
---
 drivers/auxdisplay/charlcd.c        | 95 ++---------------------------
 drivers/auxdisplay/charlcd.h        |  9 +++
 drivers/auxdisplay/hd44780.c        |  2 +
 drivers/auxdisplay/hd44780_common.c | 88 ++++++++++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  2 +
 drivers/auxdisplay/panel.c          |  3 +
 6 files changed, 110 insertions(+), 89 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 9631f70e8128..94f6b0afab13 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -8,7 +8,6 @@
 
 #include <linux/atomic.h>
 #include <linux/ctype.h>
-#include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -26,17 +25,7 @@
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
 
-#define LCD_FLAG_B		0x0004	/* Blink on */
-#define LCD_FLAG_C		0x0008	/* Cursor on */
-#define LCD_FLAG_D		0x0010	/* Display on */
-#define LCD_FLAG_F		0x0020	/* Large font mode */
-#define LCD_FLAG_N		0x0040	/* 2-rows mode */
-#define LCD_FLAG_L		0x0080	/* Backlight enabled */
-
 /* LCD commands */
-#define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
-#define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
-
 #define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
 #define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
 #define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
@@ -84,12 +73,6 @@ struct charlcd_priv {
 /* Device single-open policy control */
 static atomic_t charlcd_available = ATOMIC_INIT(1);
 
-/* sleeps that many milliseconds with a reschedule */
-static void long_sleep(int ms)
-{
-	schedule_timeout_interruptible(msecs_to_jiffies(ms));
-}
-
 /* turn the backlight on or off */
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
@@ -177,76 +160,6 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 	charlcd_home(lcd);
 }
 
-static int charlcd_init_display(struct charlcd *lcd)
-{
-	void (*write_cmd_raw)(struct hd44780_common *hdc, int cmd);
-	struct charlcd_priv *priv = charlcd_to_priv(lcd);
-	struct hd44780_common *hdc = lcd->drvdata;
-	u8 init;
-
-	if (hdc->ifwidth != 4 && hdc->ifwidth != 8)
-		return -EINVAL;
-
-	priv->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
-		      LCD_FLAG_C | LCD_FLAG_B;
-
-	long_sleep(20);		/* wait 20 ms after power-up for the paranoid */
-
-	/*
-	 * 8-bit mode, 1 line, small fonts; let's do it 3 times, to make sure
-	 * the LCD is in 8-bit mode afterwards
-	 */
-	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
-	if (hdc->ifwidth == 4) {
-		init >>= 4;
-		write_cmd_raw = hdc->write_cmd_raw4;
-	} else {
-		write_cmd_raw = hdc->write_cmd;
-	}
-	write_cmd_raw(hdc, init);
-	long_sleep(10);
-	write_cmd_raw(hdc, init);
-	long_sleep(10);
-	write_cmd_raw(hdc, init);
-	long_sleep(10);
-
-	if (hdc->ifwidth == 4) {
-		/* Switch to 4-bit mode, 1 line, small fonts */
-		hdc->write_cmd_raw4(hdc, LCD_CMD_FUNCTION_SET >> 4);
-		long_sleep(10);
-	}
-
-	/* set font height and lines number */
-	hdc->write_cmd(hdc,
-		LCD_CMD_FUNCTION_SET |
-		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
-		((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
-		((priv->flags & LCD_FLAG_N) ? LCD_CMD_TWO_LINES : 0));
-	long_sleep(10);
-
-	/* display off, cursor off, blink off */
-	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CTRL);
-	long_sleep(10);
-
-	hdc->write_cmd(hdc,
-		LCD_CMD_DISPLAY_CTRL |	/* set display mode */
-		((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
-		((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
-		((priv->flags & LCD_FLAG_B) ? LCD_CMD_BLINK_ON : 0));
-
-	charlcd_backlight(lcd, (priv->flags & LCD_FLAG_L) ? 1 : 0);
-
-	long_sleep(10);
-
-	/* entry mode set : increment, cursor shifting */
-	hdc->write_cmd(hdc, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
-
-	lcd->ops->clear_display(lcd);
-	lcd->addr.x = 0;
-	lcd->addr.y = 0;
-	return 0;
-}
-
 /*
  * Parses a movement command of the form "(.*);", where the group can be
  * any number of subcommands of the form "(x|y)[0-9]+".
@@ -418,7 +331,9 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	}
 	case 'I':	/* reinitialize display */
-		charlcd_init_display(lcd);
+		lcd->ops->init_display(lcd);
+		priv->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
+			LCD_FLAG_C | LCD_FLAG_B;
 		processed = 1;
 		break;
 	case 'G': {
@@ -727,6 +642,8 @@ static int charlcd_init(struct charlcd *lcd)
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	int ret;
 
+	priv->flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) | LCD_FLAG_D |
+		      LCD_FLAG_C | LCD_FLAG_B;
 	if (lcd->ops->backlight) {
 		mutex_init(&priv->bl_tempo_lock);
 		INIT_DELAYED_WORK(&priv->bl_work, charlcd_bl_off);
@@ -737,7 +654,7 @@ static int charlcd_init(struct charlcd *lcd)
 	 * Since charlcd_init_display() needs to write data, we have to
 	 * enable mark the LCD initialized just before.
 	 */
-	ret = charlcd_init_display(lcd);
+	ret = lcd->ops->init_display(lcd);
 	if (ret)
 		return ret;
 
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index a3210305cae7..dd40fd814a57 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -9,6 +9,13 @@
 #ifndef _CHARLCD_H
 #define _CHARLCD_H
 
+#define LCD_FLAG_B		0x0004	/* Blink on */
+#define LCD_FLAG_C		0x0008	/* Cursor on */
+#define LCD_FLAG_D		0x0010	/* Display on */
+#define LCD_FLAG_F		0x0020	/* Large font mode */
+#define LCD_FLAG_N		0x0040	/* 2-rows mode */
+#define LCD_FLAG_L		0x0080	/* Backlight enabled */
+
 enum charlcd_onoff {
 	CHARLCD_OFF = 0,
 	CHARLCD_ON,
@@ -46,6 +53,7 @@ struct charlcd {
  * @clear_display: Again clear the whole display, set the cursor to 0, 0. The
  * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
  * function.
+ * @init_display: Initialize the display.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -54,6 +62,7 @@ struct charlcd_ops {
 	int (*gotoxy)(struct charlcd *lcd);
 	int (*home)(struct charlcd *lcd);
 	int (*clear_display)(struct charlcd *lcd);
+	int (*init_display)(struct charlcd *lcd);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 40ea6d25dbe1..5916da09f738 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -130,6 +130,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -177,6 +178,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 2f7d55668eb4..7d4aea36cc55 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -9,6 +9,19 @@
 /* LCD commands */
 #define LCD_CMD_DISPLAY_CLEAR	0x01	/* Clear entire display */
 
+#define LCD_CMD_ENTRY_MODE	0x04	/* Set entry mode */
+#define LCD_CMD_CURSOR_INC	0x02	/* Increment cursor */
+
+#define LCD_CMD_DISPLAY_CTRL	0x08	/* Display control */
+#define LCD_CMD_DISPLAY_ON	0x04	/* Set display on */
+#define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
+#define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
+
+#define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
+#define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
+#define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
+#define LCD_CMD_FONT_5X10_DOTS	0x04	/* Set char font to 5x10 dots */
+
 #define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
 
 /* sleeps that many milliseconds with a reschedule */
@@ -70,6 +83,81 @@ int hd44780_common_clear_display(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
 
+int hd44780_common_init_display(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	void (*write_cmd_raw)(struct hd44780_common *hdc, int cmd);
+	u8 init;
+
+	if (hdc->ifwidth != 4 && hdc->ifwidth != 8)
+		return -EINVAL;
+
+	hdc->hd44780_common_flags = ((lcd->height > 1) ? LCD_FLAG_N : 0) |
+		LCD_FLAG_D | LCD_FLAG_C | LCD_FLAG_B;
+
+	long_sleep(20);		/* wait 20 ms after power-up for the paranoid */
+
+	/*
+	 * 8-bit mode, 1 line, small fonts; let's do it 3 times, to make sure
+	 * the LCD is in 8-bit mode afterwards
+	 */
+	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
+	if (hdc->ifwidth == 4) {
+		init >>= 4;
+		write_cmd_raw = hdc->write_cmd_raw4;
+	} else {
+		write_cmd_raw = hdc->write_cmd;
+	}
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+	write_cmd_raw(hdc, init);
+	long_sleep(10);
+
+	if (hdc->ifwidth == 4) {
+		/* Switch to 4-bit mode, 1 line, small fonts */
+		hdc->write_cmd_raw4(hdc, LCD_CMD_FUNCTION_SET >> 4);
+		long_sleep(10);
+	}
+
+	/* set font height and lines number */
+	hdc->write_cmd(hdc,
+		LCD_CMD_FUNCTION_SET |
+		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_F) ?
+			LCD_CMD_FONT_5X10_DOTS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_N) ?
+			LCD_CMD_TWO_LINES : 0));
+	long_sleep(10);
+
+	/* display off, cursor off, blink off */
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CTRL);
+	long_sleep(10);
+
+	hdc->write_cmd(hdc,
+		LCD_CMD_DISPLAY_CTRL |	/* set display mode */
+		((hdc->hd44780_common_flags & LCD_FLAG_D) ?
+			LCD_CMD_DISPLAY_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_C) ?
+			LCD_CMD_CURSOR_ON : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_B) ?
+			LCD_CMD_BLINK_ON : 0));
+
+	charlcd_backlight(lcd,
+			(hdc->hd44780_common_flags & LCD_FLAG_L) ? 1 : 0);
+
+	long_sleep(10);
+
+	/* entry mode set : increment, cursor shifting */
+	hdc->write_cmd(hdc, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
+
+	hd44780_common_clear_display(lcd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_init_display);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index ef11935a3764..a8e322891ce2 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -7,6 +7,7 @@ struct hd44780_common {
 	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int bwidth;			/* Default set by hd44780_alloc() */
 	int hwidth;			/* Default set by hd44780_alloc() */
+	unsigned long hd44780_common_flags;
 	void (*write_data)(struct hd44780_common *hdc, int data);
 	void (*write_cmd)(struct hd44780_common *hdc, int cmd);
 	/* write_cmd_raw4 is for 4-bit connected displays only */
@@ -18,4 +19,5 @@ int hd44780_common_print(struct charlcd *lcd, int c);
 int hd44780_common_gotoxy(struct charlcd *lcd);
 int hd44780_common_home(struct charlcd *lcd);
 int hd44780_common_clear_display(struct charlcd *lcd);
+int hd44780_common_init_display(struct charlcd *lcd);
 struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 8adf627529f1..583bd22d3abd 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -878,6 +878,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -886,6 +887,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -894,6 +896,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.gotoxy		= hd44780_common_gotoxy,
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
+	.init_display	= hd44780_common_init_display,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

