Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571732A4101
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgKCJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgKCJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:58:49 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F2C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:58:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 615A923FA28;
        Tue,  3 Nov 2020 10:58:47 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.944
X-Spam-Level: 
X-Spam-Status: No, score=-2.944 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.044, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i-mmdfH3vPC2; Tue,  3 Nov 2020 10:58:45 +0100 (CET)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPA id C47DF23F82F;
        Tue,  3 Nov 2020 10:58:44 +0100 (CET)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v6 03/25] auxdisplay: Move hwidth and bwidth to struct hd44780_common
Date:   Tue,  3 Nov 2020 10:58:06 +0100
Message-Id: <20201103095828.515831-4-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103095828.515831-1-poeschel@lemonage.de>
References: <20201103095828.515831-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

hwidth is for the hardware buffer size and bwidth is for the buffer
width of one single line. This is specific to the hd44780 displays and
so it is moved out from charlcd to struct hd44780_common.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 40 ++++++++++++-------------
 drivers/auxdisplay/charlcd.h        |  6 ++--
 drivers/auxdisplay/hd44780.c        | 24 +++++++++------
 drivers/auxdisplay/hd44780_common.c |  2 ++
 drivers/auxdisplay/hd44780_common.h |  5 ++++
 drivers/auxdisplay/panel.c          | 45 +++++++++++++++--------------
 6 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 8aaee0fea9ab..02392336d7d3 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -21,9 +21,7 @@
 #include <generated/utsrelease.h>
 
 #include "charlcd.h"
-
-#define DEFAULT_LCD_BWIDTH      40
-#define DEFAULT_LCD_HWIDTH      64
+#include "hd44780_common.h"
 
 /* Keep the backlight on this many seconds for each flash */
 #define LCD_BL_TEMPO_PERIOD	4
@@ -151,18 +149,19 @@ EXPORT_SYMBOL_GPL(charlcd_poke);
 static void charlcd_gotoxy(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 	unsigned int addr;
 
 	/*
 	 * we force the cursor to stay at the end of the
 	 * line if it wants to go farther
 	 */
-	addr = priv->addr.x < lcd->bwidth ? priv->addr.x & (lcd->hwidth - 1)
-					  : lcd->bwidth - 1;
+	addr = priv->addr.x < hdc->bwidth ? priv->addr.x & (hdc->hwidth - 1)
+					  : hdc->bwidth - 1;
 	if (priv->addr.y & 1)
-		addr += lcd->hwidth;
+		addr += hdc->hwidth;
 	if (priv->addr.y & 2)
-		addr += lcd->bwidth;
+		addr += hdc->bwidth;
 	lcd->ops->write_cmd(lcd, LCD_CMD_SET_DDRAM_ADDR | addr);
 }
 
@@ -178,21 +177,23 @@ static void charlcd_home(struct charlcd *lcd)
 static void charlcd_print(struct charlcd *lcd, char c)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 
-	if (priv->addr.x < lcd->bwidth) {
+	if (priv->addr.x < hdc->bwidth) {
 		if (lcd->char_conv)
 			c = lcd->char_conv[(unsigned char)c];
 		lcd->ops->write_data(lcd, c);
 		priv->addr.x++;
 
 		/* prevents the cursor from wrapping onto the next line */
-		if (priv->addr.x == lcd->bwidth)
+		if (priv->addr.x == hdc->bwidth)
 			charlcd_gotoxy(lcd);
 	}
 }
 
 static void charlcd_clear_fast(struct charlcd *lcd)
 {
+	struct hd44780_common *hdc = lcd->drvdata;
 	int pos;
 
 	charlcd_home(lcd);
@@ -200,7 +201,7 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 	if (lcd->ops->clear_fast)
 		lcd->ops->clear_fast(lcd);
 	else
-		for (pos = 0; pos < min(2, lcd->height) * lcd->hwidth; pos++)
+		for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
 			lcd->ops->write_data(lcd, ' ');
 
 	charlcd_home(lcd);
@@ -348,6 +349,7 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* LCD special codes */
 
@@ -413,7 +415,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	case 'l':	/* Shift Cursor Left */
 		if (priv->addr.x > 0) {
 			/* back one char if not at end of line */
-			if (priv->addr.x < lcd->bwidth)
+			if (priv->addr.x < hdc->bwidth)
 				lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
 			priv->addr.x--;
 		}
@@ -422,7 +424,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	case 'r':	/* shift cursor right */
 		if (priv->addr.x < lcd->width) {
 			/* allow the cursor to pass the end of the line */
-			if (priv->addr.x < (lcd->bwidth - 1))
+			if (priv->addr.x < (hdc->bwidth - 1))
 				lcd->ops->write_cmd(lcd,
 					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
 			priv->addr.x++;
@@ -442,7 +444,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	case 'k': {	/* kill end of line */
 		int x;
 
-		for (x = priv->addr.x; x < lcd->bwidth; x++)
+		for (x = priv->addr.x; x < hdc->bwidth; x++)
 			lcd->ops->write_data(lcd, ' ');
 
 		/* restore cursor position */
@@ -554,6 +556,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 static void charlcd_write_char(struct charlcd *lcd, char c)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 
 	/* first, we'll test if we're in escape mode */
 	if ((c != '\n') && priv->esc_seq.len >= 0) {
@@ -577,7 +580,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 				 * check if we're not at the
 				 * end of the line
 				 */
-				if (priv->addr.x < lcd->bwidth)
+				if (priv->addr.x < hdc->bwidth)
 					/* back one char */
 					lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
 				priv->addr.x--;
@@ -596,7 +599,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * flush the remainder of the current line and
 			 * go to the beginning of the next line
 			 */
-			for (; priv->addr.x < lcd->bwidth; priv->addr.x++)
+			for (; priv->addr.x < hdc->bwidth; priv->addr.x++)
 				lcd->ops->write_data(lcd, ' ');
 			priv->addr.x = 0;
 			priv->addr.y = (priv->addr.y + 1) % lcd->height;
@@ -779,12 +782,12 @@ static int charlcd_init(struct charlcd *lcd)
 	return 0;
 }
 
-struct charlcd *charlcd_alloc(unsigned int drvdata_size)
+struct charlcd *charlcd_alloc(void)
 {
 	struct charlcd_priv *priv;
 	struct charlcd *lcd;
 
-	priv = kzalloc(sizeof(*priv) + drvdata_size, GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return NULL;
 
@@ -792,9 +795,6 @@ struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 
 	lcd = &priv->lcd;
 	lcd->ifwidth = 8;
-	lcd->bwidth = DEFAULT_LCD_BWIDTH;
-	lcd->hwidth = DEFAULT_LCD_HWIDTH;
-	lcd->drvdata = priv->drvdata;
 
 	return lcd;
 }
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index c66f038e5d2b..2a12d07705a3 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -21,10 +21,8 @@ struct charlcd {
 	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int height;
 	int width;
-	int bwidth;			/* Default set by charlcd_alloc() */
-	int hwidth;			/* Default set by charlcd_alloc() */
 
-	void *drvdata;			/* Set by charlcd_alloc() */
+	void *drvdata;
 };
 
 struct charlcd_ops {
@@ -38,7 +36,7 @@ struct charlcd_ops {
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 };
 
-struct charlcd *charlcd_alloc(unsigned int drvdata_size);
+struct charlcd *charlcd_alloc(void);
 void charlcd_free(struct charlcd *lcd);
 
 int charlcd_register(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 271dba9cd108..0603af8f2336 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -40,7 +40,8 @@ struct hd44780 {
 
 static void hd44780_backlight(struct charlcd *lcd, enum charlcd_onoff on)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	if (hd->pins[PIN_CTRL_BL])
 		gpiod_set_value_cansleep(hd->pins[PIN_CTRL_BL], on);
@@ -104,7 +105,8 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 /* Send a command to the LCD panel in 8 bit GPIO mode */
 static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, cmd, 0);
 
@@ -115,7 +117,8 @@ static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
 /* Send data to the LCD panel in 8 bit GPIO mode */
 static void hd44780_write_data_gpio8(struct charlcd *lcd, int data)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, data, 1);
 
@@ -132,7 +135,8 @@ static const struct charlcd_ops hd44780_ops_gpio8 = {
 /* Send a command to the LCD panel in 4 bit GPIO mode */
 static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, cmd, 0);
 
@@ -144,7 +148,8 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 {
 	DECLARE_BITMAP(values, 6); /* for DATA[4-7], RS, RW */
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 	unsigned int n;
 
 	/* Command nibble + RS, RW */
@@ -160,7 +165,8 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 /* Send data to the LCD panel in 4 bit GPIO mode */
 static void hd44780_write_data_gpio4(struct charlcd *lcd, int data)
 {
-	struct hd44780 *hd = lcd->drvdata;
+	struct hd44780_common *hdc = lcd->drvdata;
+	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, data, 1);
 
@@ -204,7 +210,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	if (!hdc)
 		return -ENOMEM;
 
-	lcd = charlcd_alloc(sizeof(struct hd44780));
+	lcd = charlcd_alloc();
 	if (!lcd)
 		goto fail1;
 
@@ -264,10 +270,10 @@ static int hd44780_probe(struct platform_device *pdev)
 	 * usually equal to the display width
 	 */
 	if (lcd->height > 2)
-		lcd->bwidth = lcd->width;
+		hdc->bwidth = lcd->width;
 
 	/* Optional properties */
-	device_property_read_u32(dev, "internal-buffer-width", &lcd->bwidth);
+	device_property_read_u32(dev, "internal-buffer-width", &hdc->bwidth);
 
 	lcd->ifwidth = ifwidth;
 	lcd->ops = ifwidth == 8 ? &hd44780_ops_gpio8 : &hd44780_ops_gpio4;
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 2fdea29d6a8f..3a05fd30cae0 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -12,6 +12,8 @@ struct hd44780_common *hd44780_common_alloc(void)
 	if (!hd)
 		return NULL;
 
+	hd->bwidth = DEFAULT_LCD_BWIDTH;
+	hd->hwidth = DEFAULT_LCD_HWIDTH;
 	return hd;
 }
 EXPORT_SYMBOL_GPL(hd44780_common_alloc);
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 974868f7529c..9647d24c4490 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -1,6 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
+#define DEFAULT_LCD_BWIDTH      40
+#define DEFAULT_LCD_HWIDTH      64
+
 struct hd44780_common {
+	int bwidth;			/* Default set by hd44780_alloc() */
+	int hwidth;			/* Default set by hd44780_alloc() */
 	void *hd44780;
 };
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index c3a60e190a7a..cec6b729d668 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -299,8 +299,6 @@ static unsigned char lcd_bits[LCD_PORTS][LCD_BITS][BIT_STATES];
 #define DEFAULT_LCD_TYPE        LCD_TYPE_OLD
 #define DEFAULT_LCD_HEIGHT      2
 #define DEFAULT_LCD_WIDTH       40
-#define DEFAULT_LCD_BWIDTH      40
-#define DEFAULT_LCD_HWIDTH      64
 #define DEFAULT_LCD_CHARSET     LCD_CHARSET_NORMAL
 #define DEFAULT_LCD_PROTO       LCD_PROTO_PARALLEL
 
@@ -813,10 +811,11 @@ static void lcd_write_data_tilcd(struct charlcd *charlcd, int data)
 /* fills the display with spaces and resets X/Y */
 static void lcd_clear_fast_s(struct charlcd *charlcd)
 {
+	struct hd44780_common *hdc = charlcd->drvdata;
 	int pos;
 
 	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
+	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
 		lcd_send_serial(0x5F);	/* R/W=W, RS=1 */
 		lcd_send_serial(' ' & 0x0F);
 		lcd_send_serial((' ' >> 4) & 0x0F);
@@ -829,10 +828,11 @@ static void lcd_clear_fast_s(struct charlcd *charlcd)
 /* fills the display with spaces and resets X/Y */
 static void lcd_clear_fast_p8(struct charlcd *charlcd)
 {
+	struct hd44780_common *hdc = charlcd->drvdata;
 	int pos;
 
 	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
+	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
 		/* present the data to the data port */
 		w_dtr(pprt, ' ');
 
@@ -859,10 +859,11 @@ static void lcd_clear_fast_p8(struct charlcd *charlcd)
 /* fills the display with spaces and resets X/Y */
 static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
 {
+	struct hd44780_common *hdc = charlcd->drvdata;
 	int pos;
 
 	spin_lock_irq(&pprt_lock);
-	for (pos = 0; pos < charlcd->height * charlcd->hwidth; pos++) {
+	for (pos = 0; pos < charlcd->height * hdc->hwidth; pos++) {
 		/* present the data to the data port */
 		w_dtr(pprt, ' ');
 		udelay(60);
@@ -902,7 +903,7 @@ static void lcd_init(void)
 	if (!hdc)
 		return;
 
-	charlcd = charlcd_alloc(0);
+	charlcd = charlcd_alloc();
 	if (!charlcd) {
 		kfree(hdc);
 		return;
@@ -917,8 +918,8 @@ static void lcd_init(void)
 	 */
 	charlcd->height = lcd_height;
 	charlcd->width = lcd_width;
-	charlcd->bwidth = lcd_bwidth;
-	charlcd->hwidth = lcd_hwidth;
+	hdc->bwidth = lcd_bwidth;
+	hdc->hwidth = lcd_hwidth;
 
 	switch (selected_lcd_type) {
 	case LCD_TYPE_OLD:
@@ -929,8 +930,8 @@ static void lcd_init(void)
 		lcd.pins.rs = PIN_AUTOLF;
 
 		charlcd->width = 40;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_KS0074:
@@ -942,8 +943,8 @@ static void lcd_init(void)
 		lcd.pins.da = PIN_D0;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 16;
+		hdc->bwidth = 40;
+		hdc->hwidth = 16;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_NEXCOM:
@@ -955,8 +956,8 @@ static void lcd_init(void)
 		lcd.pins.rw = PIN_INITP;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	case LCD_TYPE_CUSTOM:
@@ -974,8 +975,8 @@ static void lcd_init(void)
 		lcd.pins.rs = PIN_SELECP;
 
 		charlcd->width = 16;
-		charlcd->bwidth = 40;
-		charlcd->hwidth = 64;
+		hdc->bwidth = 40;
+		hdc->hwidth = 64;
 		charlcd->height = 2;
 		break;
 	}
@@ -986,9 +987,9 @@ static void lcd_init(void)
 	if (lcd_width != NOT_SET)
 		charlcd->width = lcd_width;
 	if (lcd_bwidth != NOT_SET)
-		charlcd->bwidth = lcd_bwidth;
+		hdc->bwidth = lcd_bwidth;
 	if (lcd_hwidth != NOT_SET)
-		charlcd->hwidth = lcd_hwidth;
+		hdc->hwidth = lcd_hwidth;
 	if (lcd_charset != NOT_SET)
 		lcd.charset = lcd_charset;
 	if (lcd_proto != NOT_SET)
@@ -1009,10 +1010,10 @@ static void lcd_init(void)
 	/* this is used to catch wrong and default values */
 	if (charlcd->width <= 0)
 		charlcd->width = DEFAULT_LCD_WIDTH;
-	if (charlcd->bwidth <= 0)
-		charlcd->bwidth = DEFAULT_LCD_BWIDTH;
-	if (charlcd->hwidth <= 0)
-		charlcd->hwidth = DEFAULT_LCD_HWIDTH;
+	if (hdc->bwidth <= 0)
+		hdc->bwidth = DEFAULT_LCD_BWIDTH;
+	if (hdc->hwidth <= 0)
+		hdc->hwidth = DEFAULT_LCD_HWIDTH;
 	if (charlcd->height <= 0)
 		charlcd->height = DEFAULT_LCD_HEIGHT;
 
-- 
2.28.0

