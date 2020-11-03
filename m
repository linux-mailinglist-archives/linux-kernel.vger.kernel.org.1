Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF62A40FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgKCJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgKCJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:58 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA7C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 003AE23FF26;
        Tue,  3 Nov 2020 10:58:57 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.942
X-Spam-Level: 
X-Spam-Status: No, score=-2.942 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.042, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5tP_oXZlf_pf; Tue,  3 Nov 2020 10:58:54 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id 5497223FA57;
        Tue,  3 Nov 2020 10:58:54 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 15/25] auxdisplay: implement various hd44780_common_ functions
Date:   Tue,  3 Nov 2020 10:58:18 +0100
Message-Id: <20201103095828.515831-16-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This implements various hd44780_common_ functions for hd44780 compatible
display drivers to use. charlcd then calls these functions through its
ops function pointer.
The functions namely are:
- hd44780_common_shift_cursor
- hd44780_common_display_shift
- hd44780_common_display
- hd44780_common_cursor
- hd44780_common_blink
- hd44780_common_fontsize
- hd44780_common_lines

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
Changes in v5:
- this patch is squashed together from the former individual
  hd44780_common_ function patches
---
 drivers/auxdisplay/charlcd.c        |  73 ++++++++++------
 drivers/auxdisplay/charlcd.h        |  28 ++++++
 drivers/auxdisplay/hd44780.c        |  14 +++
 drivers/auxdisplay/hd44780_common.c | 131 ++++++++++++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |   9 ++
 drivers/auxdisplay/panel.c          |  21 +++++
 6 files changed, 249 insertions(+), 27 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 94f6b0afab13..281a3259c144 100644
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
@@ -236,26 +232,44 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
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
 		priv->flags |= LCD_FLAG_B;
+		if (priv->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_ON);
+
 		processed = 1;
 		break;
 	case 'b':	/* Blink OFF */
 		priv->flags &= ~LCD_FLAG_B;
+		if (priv->flags != oldflags)
+			lcd->ops->blink(lcd, CHARLCD_OFF);
+
 		processed = 1;
 		break;
 	case '+':	/* Back light ON */
@@ -272,47 +286,54 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		break;
 	case 'f':	/* Small Font */
 		priv->flags &= ~LCD_FLAG_F;
+		if (priv->flags != oldflags)
+			lcd->ops->fontsize(lcd, CHARLCD_FONTSIZE_SMALL);
+
 		processed = 1;
 		break;
 	case 'F':	/* Large Font */
 		priv->flags |= LCD_FLAG_F;
+		if (priv->flags != oldflags)
+			lcd->ops->fontsize(lcd, CHARLCD_FONTSIZE_LARGE);
+
 		processed = 1;
 		break;
 	case 'n':	/* One Line */
 		priv->flags &= ~LCD_FLAG_N;
+		if (priv->flags != oldflags)
+			lcd->ops->lines(lcd, CHARLCD_LINES_1);
+
 		processed = 1;
 		break;
 	case 'N':	/* Two Lines */
 		priv->flags |= LCD_FLAG_N;
+		if (priv->flags != oldflags)
+			lcd->ops->lines(lcd, CHARLCD_LINES_2);
+
 		processed = 1;
 		break;
 	case 'l':	/* Shift Cursor Left */
 		if (lcd->addr.x > 0) {
-			/* back one char if not at end of line */
-			if (lcd->addr.x < hdc->bwidth)
-				hdc->write_cmd(hdc, LCD_CMD_SHIFT);
-			lcd->addr.x--;
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_LEFT))
+				lcd->addr.x--;
 		}
+
 		processed = 1;
 		break;
 	case 'r':	/* shift cursor right */
 		if (lcd->addr.x < lcd->width) {
-			/* allow the cursor to pass the end of the line */
-			if (lcd->addr.x < (hdc->bwidth - 1))
-				hdc->write_cmd(hdc,
-					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
-			lcd->addr.x++;
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_RIGHT))
+				lcd->addr.x++;
 		}
+
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
@@ -456,19 +477,17 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 		case '\b':
 			/* go back one char and clear it */
 			if (lcd->addr.x > 0) {
-				/*
-				 * check if we're not at the
-				 * end of the line
-				 */
-				if (lcd->addr.x < hdc->bwidth)
-					/* back one char */
-					hdc->write_cmd(hdc, LCD_CMD_SHIFT);
-				lcd->addr.x--;
+				/* back one char */
+				if (!lcd->ops->shift_cursor(lcd,
+							CHARLCD_SHIFT_LEFT))
+					lcd->addr.x--;
 			}
 			/* replace with a space */
-			hdc->write_data(hdc, ' ');
+			charlcd_print(lcd, ' ');
 			/* back one char again */
-			hdc->write_cmd(hdc, LCD_CMD_SHIFT);
+			if (!lcd->ops->shift_cursor(lcd, CHARLCD_SHIFT_LEFT))
+				lcd->addr.x--;
+
 			break;
 		case '\f':
 			/* quickly clear the display */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index dd40fd814a57..5a89bdeb659a 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -21,6 +21,21 @@ enum charlcd_onoff {
 	CHARLCD_ON,
 };
 
+enum charlcd_shift_dir {
+	CHARLCD_SHIFT_LEFT,
+	CHARLCD_SHIFT_RIGHT,
+};
+
+enum charlcd_fontsize {
+	CHARLCD_FONTSIZE_SMALL,
+	CHARLCD_FONTSIZE_LARGE,
+};
+
+enum charlcd_lines {
+	CHARLCD_LINES_1,
+	CHARLCD_LINES_2,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
@@ -54,6 +69,12 @@ struct charlcd {
  * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
  * function.
  * @init_display: Initialize the display.
+ * @shift_cursor: Shift cursor left or right one position.
+ * @shift_display: Shift whole display content left or right.
+ * @display: Turn display on or off.
+ * @cursor: Turn cursor on or off.
+ * @blink: Turn cursor blink on or off.
+ * @lines: One or two lines.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -63,6 +84,13 @@ struct charlcd_ops {
 	int (*home)(struct charlcd *lcd);
 	int (*clear_display)(struct charlcd *lcd);
 	int (*init_display)(struct charlcd *lcd);
+	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*shift_display)(struct charlcd *lcd, enum charlcd_shift_dir dir);
+	int (*display)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*cursor)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*blink)(struct charlcd *lcd, enum charlcd_onoff on);
+	int (*fontsize)(struct charlcd *lcd, enum charlcd_fontsize size);
+	int (*lines)(struct charlcd *lcd, enum charlcd_lines lines);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 5916da09f738..7b7b28d72198 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -131,6 +131,13 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -179,6 +186,13 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 7d4aea36cc55..9d538fdcd260 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -17,6 +17,10 @@
 #define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
 #define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
 
+#define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
+#define LCD_CMD_DISPLAY_SHIFT	0x08	/* Shift display instead of cursor */
+#define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
+
 #define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
 #define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
 #define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
@@ -158,6 +162,133 @@ int hd44780_common_init_display(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_init_display);
 
+int hd44780_common_shift_cursor(struct charlcd *lcd, enum charlcd_shift_dir dir)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (dir == CHARLCD_SHIFT_LEFT) {
+		/* back one char if not at end of line */
+		if (lcd->addr.x < hdc->bwidth)
+			hdc->write_cmd(hdc, LCD_CMD_SHIFT);
+	} else if (dir == CHARLCD_SHIFT_RIGHT) {
+		/* allow the cursor to pass the end of the line */
+		if (lcd->addr.x < (hdc->bwidth - 1))
+			hdc->write_cmd(hdc,
+					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_shift_cursor);
+
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
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (on == CHARLCD_ON)
+		hdc->hd44780_common_flags |= LCD_FLAG_B;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_B;
+
+	hd44780_common_set_mode(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_blink);
+
+static void hd44780_common_set_function(struct hd44780_common *hdc)
+{
+	hdc->write_cmd(hdc,
+		LCD_CMD_FUNCTION_SET |
+		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_F) ?
+			LCD_CMD_FONT_5X10_DOTS : 0) |
+		((hdc->hd44780_common_flags & LCD_FLAG_N) ?
+			LCD_CMD_TWO_LINES : 0));
+}
+
+int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (size == CHARLCD_FONTSIZE_LARGE)
+		hdc->hd44780_common_flags |= LCD_FLAG_F;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_F;
+
+	hd44780_common_set_function(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_fontsize);
+
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+
+	if (lines == CHARLCD_LINES_2)
+		hdc->hd44780_common_flags |= LCD_FLAG_N;
+	else
+		hdc->hd44780_common_flags &= ~LCD_FLAG_N;
+
+	hd44780_common_set_function(hdc);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_lines);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index a8e322891ce2..e5a69fdc3b61 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -20,4 +20,13 @@ int hd44780_common_gotoxy(struct charlcd *lcd);
 int hd44780_common_home(struct charlcd *lcd);
 int hd44780_common_clear_display(struct charlcd *lcd);
 int hd44780_common_init_display(struct charlcd *lcd);
+int hd44780_common_shift_cursor(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
+int hd44780_common_shift_display(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
+int hd44780_common_display(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_cursor(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_blink(struct charlcd *lcd, enum charlcd_onoff on);
+int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
+int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
 struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 583bd22d3abd..3d33d7cc979c 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -879,6 +879,13 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -888,6 +895,13 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -897,6 +911,13 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
+	.shift_display	= hd44780_common_shift_display,
+	.display	= hd44780_common_display,
+	.cursor		= hd44780_common_cursor,
+	.blink		= hd44780_common_blink,
+	.fontsize	= hd44780_common_fontsize,
+	.lines		= hd44780_common_lines,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

