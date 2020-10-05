Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980E28361A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJENCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgJENBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:01:38 -0400
Received: from smtp3.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6143C0613BA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 06:01:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id A36F423F72E;
        Mon,  5 Oct 2020 15:01:36 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.957
X-Spam-Level: 
X-Spam-Status: No, score=-2.957 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.057, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YXvJSXof_ukl; Mon,  5 Oct 2020 15:01:34 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id A5C2023F123;
        Mon,  5 Oct 2020 15:01:34 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 15/32] auxdisplay: implement hd44780_common_shift_cursor
Date:   Mon,  5 Oct 2020 15:01:11 +0200
Message-Id: <20201005130128.3430804-3-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005130128.3430804-1-poeschel@lemonage.de>
References: <20201005130128.3430804-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Implement a hd44780_common_shift_cursor function for drivers to use and
make charlcd use this function through ops function pointer.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 33 ++++++++++++-----------------
 drivers/auxdisplay/charlcd.h        |  7 ++++++
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 22 +++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  2 ++
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 94f6b0afab13..85747e13bf48 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -288,21 +288,18 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
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
@@ -456,19 +453,17 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
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
index 6281cf299a6d..0a340beacd3e 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -21,6 +21,11 @@ enum charlcd_onoff {
 	CHARLCD_ON,
 };
 
+enum charlcd_shift_dir {
+	CHARLCD_SHIFT_LEFT,
+	CHARLCD_SHIFT_RIGHT,
+};
+
 struct charlcd {
 	const struct charlcd_ops *ops;
 	const unsigned char *char_conv;	/* Optional */
@@ -53,6 +58,7 @@ struct charlcd {
  * values in addr.x and addr.y are set to 0, 0 by charlcd prior to calling this
  * function.
  * @init_display: Initialize the display.
+ * @shift_cursor: Shift cursor left or right one position.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
@@ -62,6 +68,7 @@ struct charlcd_ops {
 	int (*home)(struct charlcd *lcd);
 	int (*clear_display)(struct charlcd *lcd);
 	int (*init_display)(struct charlcd *lcd);
+	int (*shift_cursor)(struct charlcd *lcd, enum charlcd_shift_dir dir);
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 5916da09f738..6ffeeb3fb0d0 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -131,6 +131,7 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -179,6 +180,7 @@ static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 8e64de2e44f2..894a195eda39 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -17,6 +17,9 @@
 #define LCD_CMD_CURSOR_ON	0x02	/* Set cursor on */
 #define LCD_CMD_BLINK_ON	0x01	/* Set blink on */
 
+#define LCD_CMD_SHIFT		0x10	/* Shift cursor/display */
+#define LCD_CMD_SHIFT_RIGHT	0x04	/* Shift display/cursor to the right */
+
 #define LCD_CMD_FUNCTION_SET	0x20	/* Set function */
 #define LCD_CMD_DATA_LEN_8BITS	0x10	/* Set data length to 8 bits */
 #define LCD_CMD_TWO_LINES	0x08	/* Set to two display lines */
@@ -158,6 +161,25 @@ int hd44780_common_init_display(struct charlcd *lcd)
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
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index cefd78d67675..432fc37213cf 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -20,5 +20,7 @@ int hd44780_common_gotoxy(struct charlcd *lcd);
 int hd44780_common_home(struct charlcd *lcd);
 int hd44780_common_clear_display(struct charlcd *lcd);
 int hd44780_common_init_display(struct charlcd *lcd);
+int hd44780_common_shift_cursor(struct charlcd *lcd,
+		enum charlcd_shift_dir dir);
 struct hd44780_common *hd44780_common_alloc(void);
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 583bd22d3abd..4275223080e8 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -879,6 +879,7 @@ static const struct charlcd_ops charlcd_serial_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
@@ -888,6 +889,7 @@ static const struct charlcd_ops charlcd_parallel_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
@@ -897,6 +899,7 @@ static const struct charlcd_ops charlcd_tilcd_ops = {
 	.home		= hd44780_common_home,
 	.clear_display	= hd44780_common_clear_display,
 	.init_display	= hd44780_common_init_display,
+	.shift_cursor	= hd44780_common_shift_cursor,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

