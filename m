Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B57283579
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgJEMMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJEMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:12:24 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F3C0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:12:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 632B623F823;
        Mon,  5 Oct 2020 14:12:22 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.993
X-Spam-Level: 
X-Spam-Status: No, score=-2.993 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.093, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uqxGltoPNjli; Mon,  5 Oct 2020 14:12:20 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 5C940241A54;
        Mon,  5 Oct 2020 14:12:20 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 05/32] auxdisplay: Move write_data pointer to hd44780_common
Date:   Mon,  5 Oct 2020 14:11:33 +0200
Message-Id: <20201005121200.3427363-6-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005121200.3427363-1-poeschel@lemonage.de>
References: <20201005121200.3427363-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This moves the write_data function pointer from struct charlcd_ops to
struct hd44780_common. This is the function that actually writes the
character to the display. This hd44780 hardware specific function is
used by two drivers at the moment.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 12 ++++++------
 drivers/auxdisplay/charlcd.h        |  1 -
 drivers/auxdisplay/hd44780.c        | 16 +++++++++-------
 drivers/auxdisplay/hd44780_common.h |  1 +
 drivers/auxdisplay/panel.c          | 12 ++++++------
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 59e0a815bf3d..df54078656c1 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -182,7 +182,7 @@ static void charlcd_print(struct charlcd *lcd, char c)
 	if (priv->addr.x < hdc->bwidth) {
 		if (lcd->char_conv)
 			c = lcd->char_conv[(unsigned char)c];
-		lcd->ops->write_data(lcd, c);
+		hdc->write_data(hdc, c);
 		priv->addr.x++;
 
 		/* prevents the cursor from wrapping onto the next line */
@@ -202,7 +202,7 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 		lcd->ops->clear_fast(lcd);
 	else
 		for (pos = 0; pos < min(2, lcd->height) * hdc->hwidth; pos++)
-			lcd->ops->write_data(lcd, ' ');
+			hdc->write_data(hdc, ' ');
 
 	charlcd_home(lcd);
 }
@@ -446,7 +446,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		int x;
 
 		for (x = priv->addr.x; x < hdc->bwidth; x++)
-			lcd->ops->write_data(lcd, ' ');
+			hdc->write_data(hdc, ' ');
 
 		/* restore cursor position */
 		charlcd_gotoxy(lcd);
@@ -505,7 +505,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 		lcd->ops->write_cmd(lcd, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
 		for (addr = 0; addr < cgoffset; addr++)
-			lcd->ops->write_data(lcd, cgbytes[addr]);
+			hdc->write_data(hdc, cgbytes[addr]);
 
 		/* ensures that we stop writing to CGRAM */
 		charlcd_gotoxy(lcd);
@@ -587,7 +587,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 				priv->addr.x--;
 			}
 			/* replace with a space */
-			lcd->ops->write_data(lcd, ' ');
+			hdc->write_data(hdc, ' ');
 			/* back one char again */
 			lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
 			break;
@@ -601,7 +601,7 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 			 * go to the beginning of the next line
 			 */
 			for (; priv->addr.x < hdc->bwidth; priv->addr.x++)
-				lcd->ops->write_data(lcd, ' ');
+				hdc->write_data(hdc, ' ');
 			priv->addr.x = 0;
 			priv->addr.y = (priv->addr.y + 1) % lcd->height;
 			charlcd_gotoxy(lcd);
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index 5dce9dd36562..fba4f2cd42c4 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -27,7 +27,6 @@ struct charlcd {
 struct charlcd_ops {
 	/* Required */
 	void (*write_cmd)(struct charlcd *lcd, int cmd);
-	void (*write_data)(struct charlcd *lcd, int data);
 
 	/* Optional */
 	void (*write_cmd_raw4)(struct charlcd *lcd, int cmd);	/* 4-bit only */
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index f6786239c36f..922f0e0d2e6d 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -115,9 +115,8 @@ static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
 }
 
 /* Send data to the LCD panel in 8 bit GPIO mode */
-static void hd44780_write_data_gpio8(struct charlcd *lcd, int data)
+static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
 	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, data, 1);
@@ -128,7 +127,6 @@ static void hd44780_write_data_gpio8(struct charlcd *lcd, int data)
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
 	.write_cmd	= hd44780_write_cmd_gpio8,
-	.write_data	= hd44780_write_data_gpio8,
 	.backlight	= hd44780_backlight,
 };
 
@@ -163,9 +161,8 @@ static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
 }
 
 /* Send data to the LCD panel in 4 bit GPIO mode */
-static void hd44780_write_data_gpio4(struct charlcd *lcd, int data)
+static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
 	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, data, 1);
@@ -177,7 +174,6 @@ static void hd44780_write_data_gpio4(struct charlcd *lcd, int data)
 static const struct charlcd_ops hd44780_ops_gpio4 = {
 	.write_cmd	= hd44780_write_cmd_gpio4,
 	.write_cmd_raw4	= hd44780_write_cmd_raw_gpio4,
-	.write_data	= hd44780_write_data_gpio4,
 	.backlight	= hd44780_backlight,
 };
 
@@ -276,7 +272,13 @@ static int hd44780_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "internal-buffer-width", &hdc->bwidth);
 
 	hdc->ifwidth = ifwidth;
-	lcd->ops = ifwidth == 8 ? &hd44780_ops_gpio8 : &hd44780_ops_gpio4;
+	if (ifwidth == 8) {
+		lcd->ops = &hd44780_ops_gpio8;
+		hdc->write_data = hd44780_write_data_gpio8;
+	} else {
+		lcd->ops = &hd44780_ops_gpio4;
+		hdc->write_data = hd44780_write_data_gpio4;
+	}
 
 	ret = charlcd_register(lcd);
 	if (ret)
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 1100e0a32394..1d686c99b2c1 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -7,6 +7,7 @@ struct hd44780_common {
 	int ifwidth;			/* 4-bit or 8-bit (default) */
 	int bwidth;			/* Default set by hd44780_alloc() */
 	int hwidth;			/* Default set by hd44780_alloc() */
+	void (*write_data)(struct hd44780_common *hdc, int data);
 	void *hd44780;
 };
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index cec6b729d668..15100d21a6e9 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -734,7 +734,7 @@ static void lcd_write_cmd_s(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the LCD panel in serial mode */
-static void lcd_write_data_s(struct charlcd *charlcd, int data)
+static void lcd_write_data_s(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	lcd_send_serial(0x5F);	/* R/W=W, RS=1 */
@@ -767,7 +767,7 @@ static void lcd_write_cmd_p8(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the LCD panel in 8 bits parallel mode */
-static void lcd_write_data_p8(struct charlcd *charlcd, int data)
+static void lcd_write_data_p8(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -799,7 +799,7 @@ static void lcd_write_cmd_tilcd(struct charlcd *charlcd, int cmd)
 }
 
 /* send data to the TI LCD panel */
-static void lcd_write_data_tilcd(struct charlcd *charlcd, int data)
+static void lcd_write_data_tilcd(struct hd44780_common *hdc, int data)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -874,21 +874,18 @@ static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
 
 static const struct charlcd_ops charlcd_serial_ops = {
 	.write_cmd	= lcd_write_cmd_s,
-	.write_data	= lcd_write_data_s,
 	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
 	.write_cmd	= lcd_write_cmd_p8,
-	.write_data	= lcd_write_data_p8,
 	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
 	.write_cmd	= lcd_write_cmd_tilcd,
-	.write_data	= lcd_write_data_tilcd,
 	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
 };
@@ -1019,6 +1016,7 @@ static void lcd_init(void)
 
 	if (lcd.proto == LCD_PROTO_SERIAL) {	/* SERIAL */
 		charlcd->ops = &charlcd_serial_ops;
+		hdc->write_data = lcd_write_data_s;
 
 		if (lcd.pins.cl == PIN_NOT_SET)
 			lcd.pins.cl = DEFAULT_LCD_PIN_SCL;
@@ -1027,6 +1025,7 @@ static void lcd_init(void)
 
 	} else if (lcd.proto == LCD_PROTO_PARALLEL) {	/* PARALLEL */
 		charlcd->ops = &charlcd_parallel_ops;
+		hdc->write_data = lcd_write_data_p8;
 
 		if (lcd.pins.e == PIN_NOT_SET)
 			lcd.pins.e = DEFAULT_LCD_PIN_E;
@@ -1036,6 +1035,7 @@ static void lcd_init(void)
 			lcd.pins.rw = DEFAULT_LCD_PIN_RW;
 	} else {
 		charlcd->ops = &charlcd_tilcd_ops;
+		hdc->write_data = lcd_write_data_tilcd;
 	}
 
 	if (lcd.pins.bl == PIN_NOT_SET)
-- 
2.28.0

