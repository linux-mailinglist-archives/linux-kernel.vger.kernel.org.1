Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EA2835CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgJEM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJEM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:27:51 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6CC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:27:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 2C4FA23FC29;
        Mon,  5 Oct 2020 14:27:49 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.978
X-Spam-Level: 
X-Spam-Status: No, score=-2.978 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.078, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SYUYRXfW2lLw; Mon,  5 Oct 2020 14:27:47 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPA id 3E7A523F6E9;
        Mon,  5 Oct 2020 14:27:47 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 06/32] auxdisplay: Move write_cmd pointers to hd44780 drivers
Date:   Mon,  5 Oct 2020 14:27:06 +0200
Message-Id: <20201005122732.3429347-7-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122732.3429347-1-poeschel@lemonage.de>
References: <20201005122732.3429347-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The write_cmd function is used to send commands to hd44780 displays.
The individual hd44780 drivers then implement their appropriate way of
doing this with their supported displays. So we move this pointer so
hd44780_common.

Reviewed-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/auxdisplay/charlcd.c        | 45 +++++++++++++++--------------
 drivers/auxdisplay/charlcd.h        |  5 ----
 drivers/auxdisplay/hd44780.c        | 15 ++++------
 drivers/auxdisplay/hd44780_common.h |  3 ++
 drivers/auxdisplay/panel.c          | 12 ++++----
 5 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index df54078656c1..ce6622f71c34 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -162,7 +162,7 @@ static void charlcd_gotoxy(struct charlcd *lcd)
 		addr += hdc->hwidth;
 	if (priv->addr.y & 2)
 		addr += hdc->bwidth;
-	lcd->ops->write_cmd(lcd, LCD_CMD_SET_DDRAM_ADDR | addr);
+	hdc->write_cmd(hdc, LCD_CMD_SET_DDRAM_ADDR | addr);
 }
 
 static void charlcd_home(struct charlcd *lcd)
@@ -211,8 +211,9 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 static void charlcd_clear_display(struct charlcd *lcd)
 {
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
+	struct hd44780_common *hdc = lcd->drvdata;
 
-	lcd->ops->write_cmd(lcd, LCD_CMD_DISPLAY_CLEAR);
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
 	priv->addr.x = 0;
 	priv->addr.y = 0;
 	/* we must wait a few milliseconds (15) */
@@ -221,7 +222,7 @@ static void charlcd_clear_display(struct charlcd *lcd)
 
 static int charlcd_init_display(struct charlcd *lcd)
 {
-	void (*write_cmd_raw)(struct charlcd *lcd, int cmd);
+	void (*write_cmd_raw)(struct hd44780_common *hdc, int cmd);
 	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	struct hd44780_common *hdc = lcd->drvdata;
 	u8 init;
@@ -241,25 +242,25 @@ static int charlcd_init_display(struct charlcd *lcd)
 	init = LCD_CMD_FUNCTION_SET | LCD_CMD_DATA_LEN_8BITS;
 	if (hdc->ifwidth == 4) {
 		init >>= 4;
-		write_cmd_raw = lcd->ops->write_cmd_raw4;
+		write_cmd_raw = hdc->write_cmd_raw4;
 	} else {
-		write_cmd_raw = lcd->ops->write_cmd;
+		write_cmd_raw = hdc->write_cmd;
 	}
-	write_cmd_raw(lcd, init);
+	write_cmd_raw(hdc, init);
 	long_sleep(10);
-	write_cmd_raw(lcd, init);
+	write_cmd_raw(hdc, init);
 	long_sleep(10);
-	write_cmd_raw(lcd, init);
+	write_cmd_raw(hdc, init);
 	long_sleep(10);
 
 	if (hdc->ifwidth == 4) {
 		/* Switch to 4-bit mode, 1 line, small fonts */
-		lcd->ops->write_cmd_raw4(lcd, LCD_CMD_FUNCTION_SET >> 4);
+		hdc->write_cmd_raw4(hdc, LCD_CMD_FUNCTION_SET >> 4);
 		long_sleep(10);
 	}
 
 	/* set font height and lines number */
-	lcd->ops->write_cmd(lcd,
+	hdc->write_cmd(hdc,
 		LCD_CMD_FUNCTION_SET |
 		((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
 		((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
@@ -267,10 +268,10 @@ static int charlcd_init_display(struct charlcd *lcd)
 	long_sleep(10);
 
 	/* display off, cursor off, blink off */
-	lcd->ops->write_cmd(lcd, LCD_CMD_DISPLAY_CTRL);
+	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CTRL);
 	long_sleep(10);
 
-	lcd->ops->write_cmd(lcd,
+	hdc->write_cmd(hdc,
 		LCD_CMD_DISPLAY_CTRL |	/* set display mode */
 		((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
 		((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
@@ -281,7 +282,7 @@ static int charlcd_init_display(struct charlcd *lcd)
 	long_sleep(10);
 
 	/* entry mode set : increment, cursor shifting */
-	lcd->ops->write_cmd(lcd, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
+	hdc->write_cmd(hdc, LCD_CMD_ENTRY_MODE | LCD_CMD_CURSOR_INC);
 
 	charlcd_clear_display(lcd);
 	return 0;
@@ -417,7 +418,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		if (priv->addr.x > 0) {
 			/* back one char if not at end of line */
 			if (priv->addr.x < hdc->bwidth)
-				lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
+				hdc->write_cmd(hdc, LCD_CMD_SHIFT);
 			priv->addr.x--;
 		}
 		processed = 1;
@@ -426,18 +427,18 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 		if (priv->addr.x < lcd->width) {
 			/* allow the cursor to pass the end of the line */
 			if (priv->addr.x < (hdc->bwidth - 1))
-				lcd->ops->write_cmd(lcd,
+				hdc->write_cmd(hdc,
 					LCD_CMD_SHIFT | LCD_CMD_SHIFT_RIGHT);
 			priv->addr.x++;
 		}
 		processed = 1;
 		break;
 	case 'L':	/* shift display left */
-		lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
+		hdc->write_cmd(hdc, LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT);
 		processed = 1;
 		break;
 	case 'R':	/* shift display right */
-		lcd->ops->write_cmd(lcd,
+		hdc->write_cmd(hdc,
 				    LCD_CMD_SHIFT | LCD_CMD_DISPLAY_SHIFT |
 				    LCD_CMD_SHIFT_RIGHT);
 		processed = 1;
@@ -503,7 +504,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 			}
 		}
 
-		lcd->ops->write_cmd(lcd, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
+		hdc->write_cmd(hdc, LCD_CMD_SET_CGRAM_ADDR | (cgaddr * 8));
 		for (addr = 0; addr < cgoffset; addr++)
 			hdc->write_data(hdc, cgbytes[addr]);
 
@@ -535,14 +536,14 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 	if ((oldflags ^ priv->flags) &
 	    (LCD_FLAG_B | LCD_FLAG_C | LCD_FLAG_D))
 		/* set display mode */
-		lcd->ops->write_cmd(lcd,
+		hdc->write_cmd(hdc,
 			LCD_CMD_DISPLAY_CTRL |
 			((priv->flags & LCD_FLAG_D) ? LCD_CMD_DISPLAY_ON : 0) |
 			((priv->flags & LCD_FLAG_C) ? LCD_CMD_CURSOR_ON : 0) |
 			((priv->flags & LCD_FLAG_B) ? LCD_CMD_BLINK_ON : 0));
 	/* check whether one of F,N flags was changed */
 	else if ((oldflags ^ priv->flags) & (LCD_FLAG_F | LCD_FLAG_N))
-		lcd->ops->write_cmd(lcd,
+		hdc->write_cmd(hdc,
 			LCD_CMD_FUNCTION_SET |
 			((hdc->ifwidth == 8) ? LCD_CMD_DATA_LEN_8BITS : 0) |
 			((priv->flags & LCD_FLAG_F) ? LCD_CMD_FONT_5X10_DOTS : 0) |
@@ -583,13 +584,13 @@ static void charlcd_write_char(struct charlcd *lcd, char c)
 				 */
 				if (priv->addr.x < hdc->bwidth)
 					/* back one char */
-					lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
+					hdc->write_cmd(hdc, LCD_CMD_SHIFT);
 				priv->addr.x--;
 			}
 			/* replace with a space */
 			hdc->write_data(hdc, ' ');
 			/* back one char again */
-			lcd->ops->write_cmd(lcd, LCD_CMD_SHIFT);
+			hdc->write_cmd(hdc, LCD_CMD_SHIFT);
 			break;
 		case '\f':
 			/* quickly clear the display */
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index fba4f2cd42c4..ad6fd2733523 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -25,11 +25,6 @@ struct charlcd {
 };
 
 struct charlcd_ops {
-	/* Required */
-	void (*write_cmd)(struct charlcd *lcd, int cmd);
-
-	/* Optional */
-	void (*write_cmd_raw4)(struct charlcd *lcd, int cmd);	/* 4-bit only */
 	void (*clear_fast)(struct charlcd *lcd);
 	void (*backlight)(struct charlcd *lcd, enum charlcd_onoff on);
 };
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 922f0e0d2e6d..dc4738563298 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -103,9 +103,8 @@ static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
 }
 
 /* Send a command to the LCD panel in 8 bit GPIO mode */
-static void hd44780_write_cmd_gpio8(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_gpio8(struct hd44780_common *hdc, int cmd)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
 	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio8(hd, cmd, 0);
@@ -126,14 +125,12 @@ static void hd44780_write_data_gpio8(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio8 = {
-	.write_cmd	= hd44780_write_cmd_gpio8,
 	.backlight	= hd44780_backlight,
 };
 
 /* Send a command to the LCD panel in 4 bit GPIO mode */
-static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_gpio4(struct hd44780_common *hdc, int cmd)
 {
-	struct hd44780_common *hdc = lcd->drvdata;
 	struct hd44780 *hd = hdc->hd44780;
 
 	hd44780_write_gpio4(hd, cmd, 0);
@@ -143,10 +140,9 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
 }
 
 /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
-static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
+static void hd44780_write_cmd_raw_gpio4(struct hd44780_common *hdc, int cmd)
 {
 	DECLARE_BITMAP(values, 6); /* for DATA[4-7], RS, RW */
-	struct hd44780_common *hdc = lcd->drvdata;
 	struct hd44780 *hd = hdc->hd44780;
 	unsigned int n;
 
@@ -172,8 +168,6 @@ static void hd44780_write_data_gpio4(struct hd44780_common *hdc, int data)
 }
 
 static const struct charlcd_ops hd44780_ops_gpio4 = {
-	.write_cmd	= hd44780_write_cmd_gpio4,
-	.write_cmd_raw4	= hd44780_write_cmd_raw_gpio4,
 	.backlight	= hd44780_backlight,
 };
 
@@ -275,9 +269,12 @@ static int hd44780_probe(struct platform_device *pdev)
 	if (ifwidth == 8) {
 		lcd->ops = &hd44780_ops_gpio8;
 		hdc->write_data = hd44780_write_data_gpio8;
+		hdc->write_cmd = hd44780_write_cmd_gpio8;
 	} else {
 		lcd->ops = &hd44780_ops_gpio4;
 		hdc->write_data = hd44780_write_data_gpio4;
+		hdc->write_cmd = hd44780_write_cmd_gpio4;
+		hdc->write_cmd_raw4 = hd44780_write_cmd_raw_gpio4;
 	}
 
 	ret = charlcd_register(lcd);
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index 1d686c99b2c1..6c38ddf8f2ce 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -8,6 +8,9 @@ struct hd44780_common {
 	int bwidth;			/* Default set by hd44780_alloc() */
 	int hwidth;			/* Default set by hd44780_alloc() */
 	void (*write_data)(struct hd44780_common *hdc, int data);
+	void (*write_cmd)(struct hd44780_common *hdc, int cmd);
+	/* write_cmd_raw4 is for 4-bit connected displays only */
+	void (*write_cmd_raw4)(struct hd44780_common *hdc, int cmd);
 	void *hd44780;
 };
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 15100d21a6e9..7ef9bc7188ca 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -723,7 +723,7 @@ static void lcd_backlight(struct charlcd *charlcd, enum charlcd_onoff on)
 }
 
 /* send a command to the LCD panel in serial mode */
-static void lcd_write_cmd_s(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_s(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	lcd_send_serial(0x1F);	/* R/W=W, RS=0 */
@@ -745,7 +745,7 @@ static void lcd_write_data_s(struct hd44780_common *hdc, int data)
 }
 
 /* send a command to the LCD panel in 8 bits parallel mode */
-static void lcd_write_cmd_p8(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_p8(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the data port */
@@ -789,7 +789,7 @@ static void lcd_write_data_p8(struct hd44780_common *hdc, int data)
 }
 
 /* send a command to the TI LCD panel */
-static void lcd_write_cmd_tilcd(struct charlcd *charlcd, int cmd)
+static void lcd_write_cmd_tilcd(struct hd44780_common *hdc, int cmd)
 {
 	spin_lock_irq(&pprt_lock);
 	/* present the data to the control port */
@@ -873,19 +873,16 @@ static void lcd_clear_fast_tilcd(struct charlcd *charlcd)
 }
 
 static const struct charlcd_ops charlcd_serial_ops = {
-	.write_cmd	= lcd_write_cmd_s,
 	.clear_fast	= lcd_clear_fast_s,
 	.backlight	= lcd_backlight,
 };
 
 static const struct charlcd_ops charlcd_parallel_ops = {
-	.write_cmd	= lcd_write_cmd_p8,
 	.clear_fast	= lcd_clear_fast_p8,
 	.backlight	= lcd_backlight,
 };
 
 static const struct charlcd_ops charlcd_tilcd_ops = {
-	.write_cmd	= lcd_write_cmd_tilcd,
 	.clear_fast	= lcd_clear_fast_tilcd,
 	.backlight	= lcd_backlight,
 };
@@ -1017,6 +1014,7 @@ static void lcd_init(void)
 	if (lcd.proto == LCD_PROTO_SERIAL) {	/* SERIAL */
 		charlcd->ops = &charlcd_serial_ops;
 		hdc->write_data = lcd_write_data_s;
+		hdc->write_cmd = lcd_write_cmd_s;
 
 		if (lcd.pins.cl == PIN_NOT_SET)
 			lcd.pins.cl = DEFAULT_LCD_PIN_SCL;
@@ -1026,6 +1024,7 @@ static void lcd_init(void)
 	} else if (lcd.proto == LCD_PROTO_PARALLEL) {	/* PARALLEL */
 		charlcd->ops = &charlcd_parallel_ops;
 		hdc->write_data = lcd_write_data_p8;
+		hdc->write_cmd = lcd_write_cmd_p8;
 
 		if (lcd.pins.e == PIN_NOT_SET)
 			lcd.pins.e = DEFAULT_LCD_PIN_E;
@@ -1036,6 +1035,7 @@ static void lcd_init(void)
 	} else {
 		charlcd->ops = &charlcd_tilcd_ops;
 		hdc->write_data = lcd_write_data_tilcd;
+		hdc->write_cmd = lcd_write_cmd_tilcd;
 	}
 
 	if (lcd.pins.bl == PIN_NOT_SET)
-- 
2.28.0

