Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80B92A40EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgKCJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgKCJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:53 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FBC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id E92F423F2AD;
        Tue,  3 Nov 2020 10:58:51 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.943
X-Spam-Level: 
X-Spam-Status: No, score=-2.943 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.043, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ODbornBxtewL; Tue,  3 Nov 2020 10:58:50 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id E802C23F87F;
        Tue,  3 Nov 2020 10:58:49 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 09/25] auxdisplay: provide hd44780_common_gotoxy
Date:   Tue,  3 Nov 2020 10:58:12 +0100
Message-Id: <20201103095828.515831-10-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Provide a hd44780_common_gotoxy function and a pointer in the ops for
charlcd to use to move the cursor.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 38 +++++++++--------------------
 drivers/auxdisplay/charlcd.h        |  4 ++-
 drivers/auxdisplay/hd44780.c        |  2 ++
 drivers/auxdisplay/hd44780_common.c | 23 +++++++++++++++++
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          |  3 +++
 6 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 72ed004a8980..d6f971eea6ae 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -55,7 +55,7 @@
 
 #define LCD_CMD_SET_CGRAM_ADDR	0x40	/* Set char generator RAM address */
 
-#define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
+#define LCD_CMD_SET_DDRAM_ADDR 0x80    /* Set display data RAM address */
 
 #define LCD_ESCAPE_LEN		24	/* Max chars for LCD escape command */
 #define LCD_ESCAPE_CHAR		27	/* Use char 27 for escape command */
@@ -140,33 +140,17 @@ void charlcd_poke(struct charlcd *lcd)
 }
 EXPORT_SYMBOL_GPL(charlcd_poke);
 
-static void charlcd_gotoxy(struct charlcd *lcd)
-{
-	struct hd44780_common *hdc = lcd->drvdata;
-	unsigned int addr;
-
-	/*
-	 * we force the cursor to stay at the end of the
-	 * line if it wants to go farther
-	 */
-	addr = lcd->addr.x < hdc->bwidth ? lcd->addr.x & (hdc->hwidth - 1)
-					  : hdc->bwidth - 1;
-	if (lcd->addr.y & 1)
-		addr += hdc->hwidth;
-	if (lcd->addr.y & 2)
-		addr += hdc->bwidth;
-	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
-}
-
 static void charlcd_home(struct charlcd *lcd)
 {
 	lcd->addr.x = 0;
 	lcd->addr.y = 0;
-	charlcd_gotoxy(lcd);
+	lcd->ops->gotoxy(lcd);
 }
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
+	struct hd44780_common *hdc = lcd->drvdata;
+
 	if (lcd->char_conv)
 		c = lcd->char_conv[(unsigned char)c];
 
@@ -174,8 +158,8 @@ static void charlcd_print(struct charlcd *lcd, char c)
 		lcd->addr.x++;
 
 	/* prevents the cursor from wrapping onto the next line */
-	if (lcd->addr.x == lcd->width)
-		charlcd_gotoxy(lcd);
+	if (lcd->addr.x == hdc->bwidth)
+		lcd->ops->gotoxy(lcd);
 }
 
 static void charlcd_clear_fast(struct charlcd *lcd)
@@ -440,7 +424,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		/* restore cursor position */
 		lcd->addr.x = xs;
 		lcd->addr.y = ys;
-		charlcd_gotoxy(lcd);
+		lcd->ops->gotoxy(lcd);
 		processed = 1;
 		break;
 	}
@@ -499,7 +483,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 			hdc->write_data(hdc, cgbytes[addr]);
 
 		/* ensures that we stop writing to CGRAM */
-		charlcd_gotoxy(lcd);
+		lcd->ops->gotoxy(lcd);
 		processed = 1;
 		break;
 	}
@@ -510,7 +494,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 		/* If the command is valid, move to the new address */
 		if (parse_xy(esc, &lcd->addr.x, &lcd->addr.y))
-			charlcd_gotoxy(lcd);
+			lcd->ops->gotoxy(lcd);
 
 		/* Regardless of its validity, mark as processed */
 		processed = 1;
@@ -596,12 +580,12 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 
 			lcd->addr.x = 0;
 			lcd->addr.y = (lcd->addr.y + 1) % lcd->height;
-			charlcd_gotoxy(lcd);
+			lcd->ops->gotoxy(lcd);
 			break;
 		case '\r':
 			/* go to the beginning of the same line */
 			lcd->addr.x = 0;
-			charlcd_gotoxy(lcd);
+			lcd->ops->gotoxy(lcd);
 			break;
 		case '\t':
 			/* print a space instead of the tab */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 94922e3c1c4c..f36cc80ce385 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -37,14 +37,16 @@ struct charlcd {
  * Optional.
  * @backlight: Turn backlight on or off. Optional.
  * @print: Print one character to the display at current cursor position.
- * The cursor is advanced by charlcd.
  * The buffered cursor position is advanced by charlcd. The cursor should not
  * wrap to the next line at the end of a line.
+ * @gotoxy: Set cursor to x, y. The x and y values to set the cursor to are
+ * previously set in addr.x and addr.y by charlcd.
  */
 struct charlcd_ops {
 	void (*clear_fast)(struct charlcd *lcd);
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 	int (*print)(struct charlcd *lcd, int c);
+	int (*gotoxy)(struct charlcd *lcd);
 };
 
 struct charlcd *charlcd_alloc(void);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 9680bb611639..4d9478f6e5ff 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -127,6 +127,7 @@ static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
+	.gotoxy		= hd44780_common_gotoxy,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
@@ -171,6 +172,7 @@ static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.backlight	= hd44780_backlight,
 	.print		= hd44780_common_print,
+	.gotoxy		= hd44780_common_gotoxy,
 };
 
 static int hd44780_probe(struct platform_device *pdev)
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 1dfcb2cdbc70..f86eb2f27cee 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -5,6 +5,9 @@
 #include "charlcd.h"
 #include "hd44780_common.h"
 
+/* LCD commands */
+#define LCD_CMD_SET_DDRAM_ADDR	0x80	/* Set display data RAM address */
+
 int hd44780_common_print(struct charlcd *lcd, int c)
 {
 	struct hd44780_common *hdc = lcd->drvdata;
@@ -18,6 +21,26 @@ int hd44780_common_print(struct charlcd *lcd, int c)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_print);
 
+int hd44780_common_gotoxy(struct charlcd *lcd)
+{
+	struct hd44780_common *hdc = lcd->drvdata;
+	unsigned int addr;
+
+	/*
+	 * we force the cursor to stay at the end of the
+	 * line if it wants to go farther
+	 */
+	addr = lcd->addr.x < hdc->bwidth ? lcd->addr.x & (hdc->hwidth - 1)
+					  : hdc->bwidth - 1;
+	if (lcd->addr.y & 1)
+		addr += hdc->hwidth;
+	if (lcd->addr.y & 2)
+		addr += hdc->bwidth;
+	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hd44780_common_gotoxy);
+
 struct hd44780_common *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index ac404a44889b..d8cbea4a8658 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -15,4 +15,5 @@ struct hd44780_common {
 };
 
 int hd44780_common_print(struct charlcd *lcd, int c);
+int hd44780_common_gotoxy(struct charlcd *lcd);
 struct hd44780_common *hd44780_common_alloc(void);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 7ef9bc7188ca..75894eacd12f 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -875,16 +875,19 @@ static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
 static const struct charlcd_ops charlcd_serial_ops = {
 	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
 	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
 	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
+	.gotoxy		= hd44780_common_gotoxy,
 };
 
 /* initialize the LCD driver */
-- 
2.28.0

